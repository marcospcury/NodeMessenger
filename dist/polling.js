exports.start = function(server) {
  var io, socketio;

  socketio = require("socket.io");
  io = socketio.listen(server);
  io.configure(function() {
    io.set("transports", ["xhr-polling"]);
    return io.set("polling duration", 30);
  });
  return io.sockets.on("connection", function(socket) {
    console.log("conectado");
    socket.on("message", function(data) {
      return io.sockets.emit("news", data);
    });
    return socket.on("disconnect", function() {
      return console.log("desconectado");
    });
  });
};
