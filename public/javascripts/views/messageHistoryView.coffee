define [
    'jquery', 
    'underscore', 
    'backbone',
    'text!./templates/messageHistoryTemplate.html'
  ], ($, _, Backbone, templateHtml) ->
    class MessageHistoryView extends Backbone.View
      initialize: (opt) ->
        
      template: _.template templateHtml

      appendMessage: (message) ->
        @$el.append @template message.toJSON()
        @$el.animate 
          scrollTop: @$el.prop("scrollHeight"), 
          500        
        
    MessageHistoryView