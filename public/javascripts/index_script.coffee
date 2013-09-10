require ['bootstrap'], ->
    require ['jquery', 'underscore', 'backbone', 'support/webSocket', 'views/appMessengerView', 'models/contacts'], ($, _, Backbone, WebSocket, AppMessengerView, Contacts) ->
        $ ->

          contacts = new Contacts()
          contacts.add id: 1, name: "Marcos"
          contacts.add id: 2, name: "Daniela"
          appMessenger = new AppMessengerView(websocket: new WebSocket(), contacts: contacts)
          appMessenger.render()