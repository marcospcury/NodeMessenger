define ['jquery', 'underscore', 'backbone', 'models/contact'], 
  ($, _, Backbone, Contact) ->
    class contacts extends Backbone.Collection
      model: Contact
        

    contacts