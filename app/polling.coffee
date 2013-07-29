exports.start = (server) ->
	socketio = require "socket.io"

	io = socketio.listen server

	io.configure ->
		io.set "transports", ["xhr-polling"]
		io.set "polling duration", 30

	io.sockets.on "connection", (socket) ->
		console.log "conectado"
		socket.on "message", (data) ->
			io.sockets.emit "news", data
		socket.on "disconnect", ->
			console.log "desconectado"