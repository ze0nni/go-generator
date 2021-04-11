package webserver

type fetchResponce struct {
	Responce
}

func cmdFetch(conn *connection, s *server, body []byte) {
	resp := fetchResponce{}
	resp.Command = "fill_all"

	conn.writeJSON(&resp)
}
