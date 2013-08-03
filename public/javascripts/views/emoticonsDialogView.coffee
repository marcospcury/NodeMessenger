define [
        'jquery', 
        'underscore', 
        'backbone',
        'emoticonsDictionary', 
        'jqueryui'
    ], ($, _, Backbone, emoticonsDictionary) ->
      class EmoticonsDialogView extends Backbone.View
        el: "#dialog-emoticon"

        initialize: ->
          _.bindAll @, "show", "render"

        events: ->
          "click .click-emoticon" : "addEmoticon"

        addEmoticon: (e) ->
          selectedItem = $(e.currentTarget.outerHTML).attr "param"
          @trigger "emoticonSelected", emoticonsDictionary[selectedItem].text
          @$el.dialog "close"

        render: ->
          emoticonsTable = @createEmoticonsTable()
          @$el.html emoticonsTable
          @createDialog()

        show: ->
          @$el.dialog "open"

        createEmoticonsTable: ->
          htmlEmoticonsBuffer = []
          htmlEmoticonsBuffer.push "<table class=\"emoticons\"><tr>"
          contaEmoticons = 0
          for item in emoticonsDictionary
            if contaEmoticons % 12 is 0
              htmlEmoticonsBuffer.push "</tr><tr>"
            htmlEmoticonsBuffer.push "<td class=\"click-emoticon\" param=\"#{contaEmoticons}\" title=\"#{item.text}\">#{item.image}</td>"
            contaEmoticons++
          htmlEmoticonsBuffer.push "</table>"
          htmlEmoticonsBuffer.join ''

        createDialog: ->
          @$el.dialog
            width: 700
            height: 400
            resizable: no
            autoOpen: no
            modal: yes

      EmoticonsDialogView
