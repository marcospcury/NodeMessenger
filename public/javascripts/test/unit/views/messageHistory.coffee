define = require('amdefine')(module, requirejs) if (typeof define isnt 'function')
define [
  'jquery',
  'views/messageHistoryView',
  'models/messageModel'
], ($, MessageHistoryView, MessageModel) ->

  el = $('<div></div>')
  messageHistoryView = new MessageHistoryView el: el

  describe 'MessageHistoryView', ->
    it 'appends the message to history', ->
      messageHistoryView.appendMessage new MessageModel()
      expect($('.message', el).html()).to.not.equal undefined

    it 'renders the message content', ->
      messageHistoryView.appendMessage new MessageModel(author: "autor", body: "mensagem")
      expect($('.author', el).text()).to.equal "autor"
      expect($('.body', el).text()).to.equal "mensagem"

