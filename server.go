package main

import (
	"github.com/ze0nni/go-generator/webserver"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	server, err := webserver.Apply(r)
	if err != nil {
		panic(err)
	}

	go server.Run()
	r.Run("localhost:80")
}
