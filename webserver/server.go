package webserver

import (
	"log"
	"text/template"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

func Apply(router *gin.Engine) error {

	s := server{}
	router.LoadHTMLGlob("templates/*")
	router.Static("js", "public")

	router.GET("", s.IndexPage)
	router.GET("ws", s.WSConnect)

	return nil
}

type server struct {
	index *template.Template
}

func (s *server) IndexPage(c *gin.Context) {
	c.HTML(200, "index.tmpl", nil)
}

func (s *server) WSConnect(c *gin.Context) {
	conn, err := websocket.Upgrade(c.Writer, c.Request, nil, 1024, 1024)
	if err != nil {
		log.Printf("Error upgrade request: %s", err)
	}
	for {
		t, msg, err := conn.ReadMessage()
		if err != nil {
			break
		}
		conn.WriteMessage(t, msg)
	}
}
