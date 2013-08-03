define ['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->
    class MessageModel extends Backbone.Model
        defaults:
            author: ""
            recipient: ""
            body: ""

    MessageModel