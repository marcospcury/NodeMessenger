require ['bootstrap'], ->
    require ['jquery', 'underscore', 'backbone', 'support/webSocket', 'views/appMessengerView', 'models/contacts'], ($, _, Backbone, WebSocket, AppMessengerView, Contacts) ->
        $ ->

          contacts = new Contacts()
          contacts.add id: 1, name: "Charlos", status: "status-online"
          contacts.add id: 2, name: "Daniela", status: "status-online"
          currentUser = new Backbone.Model id: 10, name: "Marcos"
          appMessenger = new AppMessengerView(websocket: new WebSocket(), contacts: contacts, currentUser: currentUser)
          appMessenger.render()
