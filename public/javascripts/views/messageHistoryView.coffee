define [
        'jquery', 
        'underscore', 
        'backbone', 
        'jqueryui', 
        'models/messageCollection'
    ], ($, _, Backbone, MessageCollection) ->
        class MessageHistoryView extends Backbone.View
            initialize: (data) ->
                _.bindAll @, "addMessage", "render"
                @messageCollection = data
                @messageCollection.bind "add", @addMessage

            template: _.template "<%=author%>: <br />&nbsp;&nbsp;&nbsp;<%=body%> <br />"

            render: ->
                self = @
                @$el.empty()
                @messageCollection.each (message) ->
                    self.$el.append self.template message.toJSON()
                @$el.animate 
                    scrollTop: @$el.prop("scrollHeight"), 
                    500

            addMessage: (model) ->
                @render()

        MessageHistoryView