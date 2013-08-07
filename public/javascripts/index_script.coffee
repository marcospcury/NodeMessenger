require ['bootstrap'], ->
    require ['jquery', 'underscore', 'backbone', 'views/conversationView'], ($, _, Backbone, ConversationView) ->
        $ ->
            $("#botao-novo").click ->
              conversationView = new ConversationView()
              conversationView.render()