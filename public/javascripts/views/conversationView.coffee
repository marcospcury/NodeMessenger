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

            template: _.template "<div id='conversation-history'></div><textarea id='message-area'></textarea><button id='send-button'>Enviar</button><button id='emoticon-button'>Emoticons</button>"

            initialize: ->
                @messages = new MessageCollection()
                @messageHistory = new MessageHistoryView @messages
                @emoticonsDialog = new EmoticonsDialogView()
                @websocket = new WebSocket()
                @mapExternalEvents()

            events: ->
                "click #send-button" : "sendMessage"
                "keypress #message-area" : "handleEnterKey"
                "click #emoticon-button" : "showEmoticonsAvailable"

            mapExternalEvents: ->
                @emoticonsDialog.on "emoticonSelected", @addEmoticonToMessage
                self = @
                @websocket.on "messageReceived", (message) ->
                    self.messages.add message

            render: ->
                @$el.append @template
                @messageHistory.setElement @$("#conversation-history")
                @messageHistory.render()
                @emoticonsDialog.render()
                @renderDialog()
                @renderButtons()

            sendMessage: ->
                @websocket.sendMessage author: "Marcos", recipient: "Daniela", body: $("#message-area").val()
                $("#message-area").val ""

            handleEnterKey: (e) ->                 
                if e.which == 13 and not e.shiftKey
                    @sendMessage()
                    e.preventDefault()

            showEmoticonsAvailable: ->
                @emoticonsDialog.show()

            addEmoticonToMessage: (emoticon) ->
                $("#message-area").val $("#message-area").val() + emoticon

            renderButtons: ->
                $('#send-button').button icons: primary: "ui-icon-mail-closed"
                $("#emoticon-button").button icons: primary: "ui-icon-person"

            renderDialog: ->
                self = @
                @$el.dialog
                    width: 400
                    resizable: yes
                    close: (event, ui) -> self.closeConversation self

            closeConversation: (self) ->
                self.undelegateEvents()
                self.$el.dialog( "destroy" )
                self.websocket.disconnect()
                self.$el.remove()

        ConversationView