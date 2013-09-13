define [
    'jquery',
    'underscore',
    'backbone',
    'views/messageHistoryView',
    'views/emoticonsDialogView',
    'models/messageModel',
    'text!./templates/conversationDialogTemplate.html',
    'models/contact',
    'jqueryui',
    'jqueryAlert',
    'twitterBoostrap'
  ],
  ($, _, Backbone, MessageHistoryView, EmoticonsDialogView, MessageModel, templateHtml, Contact) ->
    class ConversationView extends Backbone.View

      template: _.template templateHtml

      initialize: (opt) ->
        _.bindAll(@)
        @messageHistory = new MessageHistoryView()
        @emoticonsDialog = new EmoticonsDialogView()
        @contact = opt.contact
        @currentUser = opt.currentUser
        @websocket = opt.websocket
        @_mapExternalEvents()
        @messageAreaId = "#message-area_#{@contact.get('id')}"
        @sendButtonId = "#send-button_#{@contact.get('id')}"
        @closeButtonId = "#close_#{@contact.get('id')}"
        @emoticonButtonId = "#emoticon-button_#{@contact.get('id')}"
        @conversationHistoryId = "#conversation-history_#{@contact.get('id')}"
        @masterDivId = "#master-div_#{@contact.get('id')}"

      events: ->
        eventHash = {}
        eventHash["click #{@sendButtonId}"] = '_sendMessage'
        eventHash["keypress #{@messageAreaId}"] = '_handleEnterKey'
        eventHash["click #{@emoticonButtonId}"] = '_showEmoticonsAvailable'
        eventHash["click #{@closeButtonId}"] = '_closeConversation'
        eventHash

      render: ->
        @$el.attr "id", "conversation_#{@contact.get("id")}"
        @$el.attr "class", "conversation-dialog"
        @$el.html @template contactId: @contact.get("id")
        @messageHistory.setElement @$(@conversationHistoryId)
        @messageHistory.render()
        @emoticonsDialog.render()
        @$(@masterDivId).draggable()
        @$(".modal-header > h3").html "#{@contact.get("name")} - Conversa"

      _mapExternalEvents: ->
        @emoticonsDialog.on "emoticonSelected", @_addEmoticonToMessage
        @websocket.on "messageReceived", (message) =>
          @messageHistory.appendMessage new MessageModel(message)

      _sendMessage: (e) ->
        @websocket.sendMessage author: @currentUser.get('name'), recipient: @contact.get('name'), body: @$(@messageAreaId).val()
        @$(@messageAreaId).val ''

      _handleEnterKey: (e) ->
        if e.which == 13 and not e.shiftKey
          @_sendMessage()
          e.preventDefault()

      _showEmoticonsAvailable: ->
        @emoticonsDialog.show()

      _addEmoticonToMessage: (emoticon) ->
        $("#message-area").val $("#message-area").val() + emoticon

      _closeConversation: ->
        @trigger 'conversationClose', @contact.get("id")

    ConversationView
