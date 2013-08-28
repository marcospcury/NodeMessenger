require ['bootstrap'], ->
    require ['jquery', 'underscore', 'backbone', 'support/webSocket', 'views/conversationView'], ($, _, Backbone, WebSocket, ConversationView) ->
        $ ->
            $("#botao-novo").click ->
              websocket = new WebSocket()
              conversationView = new ConversationView websocket: websocket
              conversationView.render()