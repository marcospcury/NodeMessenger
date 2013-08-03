require ['bootstrap'], ->
    require ['jquery', 'underscore', 'backbone', 'views/ConversationView'], ($, _, Backbone, ConversationView) ->
        $ ->
            conversationView = new ConversationView()
            conversationView.render()