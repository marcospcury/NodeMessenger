define [
  'jquery',
  'underscore',
  'backbone',
  'views/conversationView',
  'views/emoticonsDialogView',
  'models/contact',
  'models/contacts',
  'text!./templates/appMessengerTemplate.html',
  'jqueryui',
  'jqueryAlert'
  ],
  ($, _, Backbone, ConversationView, EmoticonsDialogView, Contact, Contacts, templateHtml) ->
    class AppMessengerView extends Backbone.View
      el: '#app-container'
      
      _template: _.template templateHtml

      events:
        "dblclick .friend-contact" : "_selectContact"
    
      initialize: (opt) ->
        @websocket = opt.websocket
        @contacts = opt.contacts
        @currentUser = opt.currentUser
        @conversationsOpen = new Backbone.Collection()
        @websocket.connect("status-online")
        @_mapExternalEvents()

      render: ->
        @$el.append @_template contacts: @contacts.toJSON()

      _selectContact: (e) ->
        @_startConversation $(e.target).attr "contactId"

      _startConversation: (contactId) ->
        contact = @contacts.get(contactId)
        @_renderConversationView contact
        @websocket.notifyConversation contact.get("id")

      _renderConversationView: (contact) ->
        conversationView = new ConversationView contact: contact , websocket: @websocket, currentUser: @currentUser
        conversationView.render()
        @listenTo conversationView, 'conversationClose', (contactId) =>
          @_handlesEndingConversation contactId
        @$("#conversation-area").append conversationView.$el
        @conversationsOpen.add id: contact.get("id"), dialog: conversationView

      _mapExternalEvents: ->
        @websocket.on "conversationNotification", (contactId) =>
          @_handlesIncomingConversation contactId
        @websocket.on "friendStatusChanged", (eventArgs) =>
          @_handlesFriendStatusChange eventArgs
        @websocket.on "conversationEndNotification", (contactId) =>
          @_handlesEndingConversation contactId

      _handlesIncomingConversation: (contactId) ->
        contact = @contacts.get(contactId)
        @_renderConversationView contact

      _handlesEndingConversation: (contactId) ->
        dialog = @conversationsOpen.get(contactId).get("dialog")
        dialog.remove()
        object = @conversationsOpen.get(contactId)
        @conversationsOpen.remove(object)

      _handlesFriendStatusChange: (eventArgs) ->
        contact = @contacts.get(eventArgs.contactId)
        control = @$("#contact_#{eventArgs.contactId}")
        control.removeClass(contact.get "status")
        control.addClass eventArgs.status
        contact.set "status", eventArgs.status
