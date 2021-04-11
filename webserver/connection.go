package webserver

import (
	"bytes"
	"encoding/json"
	"log"
	"sync"

	"github.com/gorilla/websocket"
)

func newConnection(server *server, conn *websocket.Conn) {
	connection := &connection{
		server: server,
		conn:   conn,
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
	writeLock sync.Mutex

	server *server
	conn   *websocket.Conn
}

type command struct {
	Command string `json:command"`
	HasBody bool   `json:hasBody"`
}

func (c *connection) listen() error {
	for {
		_, msg, err := c.conn.ReadMessage()
		if err != nil {
			return err
		}
		dec := json.NewDecoder(bytes.NewReader(msg))
		var cmd command
		dec.Decode(&cmd)

		if !cmd.HasBody {
			c.server.performCommand(c, cmd.Command, nil)
		} else {
			_, body, err := c.conn.ReadMessage()
			if err != nil {
				return err
			}
			c.server.performCommand(c, cmd.Command, body)
		}
	}
}

func (c *connection) writeJSON(command interface{}) {
	c.writeLock.Lock()
	defer c.writeLock.Unlock()
	err := c.conn.WriteJSON(command)
	if err != nil {
		log.Printf("Error writeJson %s", err)
		c.conn.Close()
	}
}
