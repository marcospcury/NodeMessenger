define ['jquery', 'underscore', 'backbone', 'models/messageModel'], ($, _, Backbone, MessageModel) ->
    class MessageCollection extends Backbone.Collection
        model: MessageModel
        

    MessageCollection