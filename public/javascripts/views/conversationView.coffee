define [
        'jquery', 
        'underscore', 
        'backbone', 
        'views/messageHistoryView',
        'views/emoticonsDialogView', 
        'models/messageModel',
        'models/messageCollection',
        'support/webSocket'
        'jqueryui',
        'jqueryAlert'
    ], 
    ($, _, Backbone, MessageHistoryView, EmoticonsDialogView, MessageModel, MessageCollection, WebSocket) ->
        class ConversationView extends Backbone.View
            el: "#dialog-conversation"

            initialize: ->
                @messages = new MessageCollection()
                @messageHistory = new MessageHistoryView @messages
                @emoticonsDialog = new EmoticonsDialogView()
                @websocket = new WebSocket()
                @mapExternalEvents()

            events: ->
                "click #send-button" : "sendMessage"
                "keypress #message-area" : "handleEnterKey"
                "click #emoticon-button" : "showEmoticons"

            mapExternalEvents: ->
                @emoticonsDialog.on "emoticonSelected", @addEmoticonToMessage
                self = @
                @websocket.on "messageReceived", (message) ->
                    self.messages.add message

            render: ->
                @emoticonsDialog.render()
                @$el.attr "title", "Conversa"
                @$el.dialog
                    width: 400
                    resizable: yes

            sendMessage: ->
                @websocket.sendMessage author: "Marcos", recipient: "Daniela", body: $("#message-area").val()
                $("#message-area").val ""

            handleEnterKey: (e) ->                 
                if e.which == 13 and not e.shiftKey
                    @sendMessage()
                    e.preventDefault()

            showEmoticons: ->
                @emoticonsDialog.show()

            addEmoticonToMessage: (emoticon) ->
                $("#message-area").val $("#message-area").val() + emoticon

        ConversationView