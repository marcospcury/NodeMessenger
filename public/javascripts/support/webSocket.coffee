define [
        'jquery', 
        'underscore', 
        'backbone',
        'socketio'
    ], ($, _, Backbone, io) ->
      class WebSocket extends Backbone.Model
        connect: (status) ->
          @websocket = io.connect()
          self = @
          @websocket.on "news", (data) ->
            self.trigger "messageReceived", data

        sendMessage: (message) ->
          @websocket.emit "message", message

        disconnect: ->
          @websocket.disconnect()
          @destroy()

      WebSocket