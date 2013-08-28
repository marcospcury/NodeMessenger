define = require('amdefine')(module, requirejs) if (typeof define isnt 'function')
define [
  'jquery',
  'views/conversationView',
  'models/messageModel',
  'test/support/mockWebsocket'
], ($, ConversationView, MessageModel, Websocket) ->

  el = $('<div></div>')
  websocket = new Websocket()
  sinon.stub websocket, "on"
  conversationView = new ConversationView el: el, websocket: websocket

  describe 'ConversationView', ->
    it 'maps websocket events', ->
      expect(websocket.on.calledWithMatch("messageReceived", sinon.match.func)).to.be.true

    it 'creates message history', ->
      conversationView.render()
      expect($("#conversation-history", el).html()).to.not.equal undefined

    it 'appends message to history view', ->
      websocket.on.restore()
      conversationView = new ConversationView el: el, websocket: websocket
      conversationView.render()
      websocket.trigger "messageReceived", {author: "autor", body: "messageEvent"}
      expect($(".body", conversationView.messageHistory.el).text()).to.equal "messageEvent"