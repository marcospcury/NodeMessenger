exports.start = function(cb) {
  var app, express, http, mongoose, path, polling, router, server;
  express = require("express");
  router = require("./routes/router");
  http = require("http");
  path = require("path");
  polling = require("./polling");
  mongoose = require("mongoose");
  app = express();
  app.configure(function() {
    app.set("port", process.env.PORT || 3000);
    app.set("views", "" + __dirname + "/views");
    app.set("view engine", "jade");
    app.set("view options", {
      layout: false
    });
    app.use(express.favicon());
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    return app.use(express["static"](path.join(__dirname, '..', "public")));
  });
  app.configure("development", function() {
    return app.use(express.errorHandler());
  });
  router.route(app);
  server = http.createServer(app).listen(app.get("port"), function() {
    console.log("listening on port " + (app.get('port')));
    return console.log(app.get("env"));
  });
  return polling.start(server);
};
