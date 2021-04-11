package webserver

import (
	"text/template"

	"github.com/gin-gonic/gin"
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

}
