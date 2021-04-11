package webserver

import (
	"log"

	"github.com/gorilla/websocket"
)

func newConnection(server *server, conn *websocket.Conn) {
	connection := &connection{
		conn: conn,
	}
	go func() {
		server.addConnection(connection)
		err := connection.listen()
		if err != nil {
			log.Printf("Error listening ws %s", err)
		}
		server.removeConnection(connection)
		conn.Close()
	}()
}

type connection struct {
	conn *websocket.Conn
}

func (c *connection) listen() error {
	for {
		t, msg, err := c.conn.ReadMessage()
		if err != nil {
			return err
		}
		c.conn.WriteMessage(t, msg)
	}
}
