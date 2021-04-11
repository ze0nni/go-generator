package webserver

import (
	"log"
	"sync"
	"text/template"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

func Apply(router *gin.Engine) error {

	s := server{
		connections: make(map[*connection]struct{}),
	}
	router.LoadHTMLGlob("templates/*")
	router.Static("js", "public")

	router.GET("", s.IndexPage)
	router.GET("ws", s.WSConnect)

	return nil
}

type server struct {
	index *template.Template

	connMutex   sync.RWMutex
	connections map[*connection]struct{}
}

func (s *server) IndexPage(c *gin.Context) {
	c.HTML(200, "index.tmpl", nil)
}

func (s *server) WSConnect(c *gin.Context) {
	conn, err := websocket.Upgrade(c.Writer, c.Request, nil, 1024, 1024)
	if err != nil {
		log.Printf("Error upgrade request: %s", err)
	}
	newConnection(s, conn)
}

func (s *server) addConnection(conn *connection) {
	s.connMutex.Lock()
	defer s.connMutex.Unlock()
	s.connections[conn] = struct{}{}
}

func (s *server) removeConnection(conn *connection) {
	s.connMutex.Lock()
	defer s.connMutex.Unlock()
	delete(s.connections, conn)
}
