socketio = require "socket.io"

class SocketServer
	constructor: ->

	startPooling: (server) ->
		self = @
		@io = socketio.listen server

		@io.configure ->
			self.io.set "transports", ["xhr-polling"]
			self.io.set "polling duration", 30

		@io.sockets.on "connection", (socket) -> 
			self.handleEvents socket

	handleEvents: (socket) ->
		self = @
		socket.on "message", (data) ->
			self.io.sockets.emit "news", data	

		socket.on "disconnect", ->
			console.log "desconectado"

		socket.on "set nickname", (name) ->
			console.log name
			socket.set "nickname", name, ->
				socket.emit "ready"

module.exports = SocketServer