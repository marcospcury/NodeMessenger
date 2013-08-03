define ['jquery', 'underscore', 'backbone', 'models/MessageModel'], ($, _, Backbone, MessageModel) ->
    class MessageCollection extends Backbone.Collection
        model: MessageModel
        

    MessageCollection