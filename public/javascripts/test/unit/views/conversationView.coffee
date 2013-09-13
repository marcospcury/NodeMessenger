define = require('amdefine')(module, requirejs) if (typeof define isnt 'function')
define [
  'jquery',
  'views/conversationView',
  'models/contact',
  'models/contacts',
  'models/messageModel',
  'test/support/mockWebsocket'
], ($, ConversationView, Contact, Contacts,  MessageModel, Websocket) ->

  el = $('<div></div>')
  
  contact = new Contact id:1, name: "Contact 1", status: "status-online"
  currentUser = new Contact id:2, name: "Current User", status: "status-online"
  conversationView = null
  websocket = null

  describe 'ConversationView', ->
    before ->
      websocket = new Websocket()
      sinon.stub websocket, "sendMessage"
      conversationView = new ConversationView el: el, currentUser: currentUser, contact: contact, websocket: websocket
      conversationView.render()
      $('#send-button_1', el).click()

    describe 'When conversation is initialized', ->
      it 'renders dialog with unique inner objects', ->
        expect($('#master-div_1', el).html()).to.not.equal undefined
        expect($('#conversation-history_1', el).html()).to.not.equal undefined
        expect($('#message-area_1', el).html()).to.not.equal undefined
        expect($('#send-button_1', el).html()).to.not.equal undefined
        expect($('#emoticon-button_1', el).html()).to.not.equal undefined

      it 'initializes blank conversation-history', ->
        expect($('#conversation-history_1', el).html()).to.equal ''

      it 'renders conversation title', ->
        expect($('.modal-header > h3', el).html()).to.equal 'Contact 1 - Conversa'

    describe 'When user sends a message', ->
      before ->
        $('#message-area_1', el).val 'mensagem escrita'
        $('#send-button_1', el).click()

      after ->
        $('#conversation-history_1', el).empty()

      it 'sends the message on websocket', ->
        expect(websocket.sendMessage.calledWithMatch(author: 'Current User', recipient: 'Contact 1', body: 'mensagem escrita')).to.be.true

      it 'cleans the message area', ->
        expect($('#message-area_1', el).val()).to.equal ''

    describe 'When a message is received', ->
      it 'renders the message on the conversation-history', ->
        websocket.trigger 'messageReceived', {author: 'Contact 1', recipient: 'Current User', body: 'mensagem teste'}
        expect($('#conversation-history_1 > .message > .body', el).html()).to.equal 'mensagem teste'
        


