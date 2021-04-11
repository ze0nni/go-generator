package webserver

import (
	"log"
	"sync"
	"text/template"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

func Apply(router *gin.Engine) (WebServer, error) {

	s := &server{
		connections: make(map[*connection]struct{}),
		commands:    make(chan commandPerformerRec),
	}
	router.LoadHTMLGlob("templates/*")
	router.Static("js", "public")

	router.GET("", s.indexPage)
	router.GET("ws", s.wSConnect)

	return s, nil
}

type WebServer interface {
	Run()
}

type server struct {
	index *template.Template

	connMutex   sync.RWMutex
	connections map[*connection]struct{}

	commands chan commandPerformerRec
}

type commandPerformer func(*connection, *server, []byte)

type commandPerformerRec struct {
	conn *connection
	cmd  commandPerformer
	body []byte
}

func (s *server) indexPage(c *gin.Context) {
	c.HTML(200, "index.tmpl", nil)
}

func (s *server) wSConnect(c *gin.Context) {
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

func (s *server) Run() {
	for rec := range s.commands {
		go rec.cmd(rec.conn, s, rec.body)
	}
}

func (s *server) performCommand(conn *connection, command string, body []byte) {
	switch command {
	case "fetch":
		s.addCommand(conn, cmdFetch, body)
	}
}

func (s *server) addCommand(conn *connection, cmd commandPerformer, body []byte) {
	s.commands <- commandPerformerRec{
		conn: conn,
		cmd:  cmd,
		body: body,
	}
}
