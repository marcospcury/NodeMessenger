define = require('amdefine')(module, requirejs) if (typeof define isnt 'function')
define [
  'jquery',
  'backbone',
  'views/appMessengerView',
  'views/conversationView',
  'models/contact',
  'models/contacts',
  'test/support/mockWebsocket'
], ($, Backbone, AppMessengerView, ConversationView, Contact, Contacts, Websocket) ->
  describe 'AppMessengerView', ->
    
    contacts = new Contacts()
    contacts.add id: 1, name: "Contact 1", status: "status-offline"
    contacts.add id: 2, name: "Contact 2", status: "status-offline"

    appMessengerView = null
    websocket = null

    beforeEach ->
      $("body").append '<div id="app-container"></div>'
      websocket = new Websocket()
      sinon.stub websocket, "connect"
      appMessengerView = new AppMessengerView websocket: websocket, contacts: contacts
      appMessengerView.render()

    afterEach ->
      appMessengerView.$el.empty()
      appMessengerView.remove()

    after ->
      $('.ui-dialog').remove()

    describe 'When application starts', ->
      it 'renders the app main view', ->
        expect($('#app-main', appMessengerView.el)).to.not.equal undefined

      it 'sets user status on server to online', ->
        expect(websocket.connect.calledWithMatch("status-online")).to.be.true

      it 'renders the friends available list', ->
        expect($('.friend-contact', appMessengerView.el).length).to.equal contacts.length

      it 'updates the friend status when notified', ->
        websocket.trigger "friendStatusChanged", contactId: contacts.get(1).get("id"), status: "status-online"
        expect($('.status-online', appMessengerView.el).length).to.equal 1
        expect($('.status-offline', appMessengerView.el).length).to.equal 1

    describe 'When user starts a conversation', ->
      beforeEach ->
        sinon.stub websocket, "notifyConversation"
        $('.friend-contact:first', appMessengerView.el).trigger 'dblclick'

      it 'renders a new conversation view with unique id', ->
        expect($('#conversation-area > .conversation-dialog', appMessengerView.el).length).to.equal 1

      it 'notifies friend about the conversation', ->
        expect(websocket.notifyConversation.calledWithMatch(contacts.get(1).get("id"))).to.be.true

    describe 'When a friend starts a conversation', ->
      it 'renders the conversation view with unique id', ->
        websocket.trigger "conversationNotification", contacts.get(1).get("id")
        expect($('#conversation-area > .conversation-dialog', appMessengerView.el).length).to.equal 1
   
    describe 'When the user closes the conversation', ->
      it 'removes the dialog from screen and memory', ->
        $('.friend-contact:first', appMessengerView.el).trigger 'dblclick'
        appMessengerView.conversationsOpen.get('1').get("dialog").trigger 'conversationClose', '1'
        expect($('#conversation-area > .conversation-dialog', appMessengerView.el).length).to.equal 0

    describe 'When a friend closes a conversation', ->
      it 'removes the dialog from screen and memory', ->
        websocket.trigger "conversationNotification", contacts.get(1).get("id")
        websocket.trigger "conversationEndNotification", contacts.get(1).get("id")
        expect($('#conversation-area > .conversation-dialog', appMessengerView.el).length).to.equal 0
