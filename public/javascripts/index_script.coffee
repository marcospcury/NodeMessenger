require ['bootstrap'], ->
    require ['jquery', 'underscore', 'backbone', 'views/ConversationView'], ($, _, Backbone, ConversationView) ->
        $ ->
            $("#botao-novo").click ->
              conversationView = new ConversationView()
              conversationView.render()