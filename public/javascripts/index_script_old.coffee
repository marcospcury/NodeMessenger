require ['jquery', 'socketio', 'emoticons', 'jqueryui', 'jqueryAlert'], ($, io, Emoticons) ->
  $ -> 
    socket = io.connect()
    socket.on 'news', (data) -> show(data)

    emoticons = new Emoticons()
    emoticons.renderGrid($("#emoticons-container"))

    $(document).tooltip()
  #---------------------------------- 
    $("#dialog-conversa").dialog
      width: 400
      resizable: yes
  #----------------------------------
    $("#dialog-emoticon").dialog
      width: 700
      height: 400
      resizable: no
      autoOpen: no
      modal: yes
  #----------------------------------
    $("#botao-emoticon")
    .button
      icons:
        primary: "ui-icon-person"
    .click ->
      $("#dialog-emoticon").dialog "open"
  #----------------------------------
    $(".click-emoticon").click ->
      $("#msg").val($("#msg").val() + " " + dictSmile[$(@).attr "param"].text) 
      $("#dialog-emoticon").dialog "close"
  #----------------------------------
    $('#msg').keypress (event) ->
      if event.which == 13 and not event.shiftKey
        dispararMensagem()
        event.preventDefault()
  #---------------------------------- 
    $('#botao-enviar')
    .button
      icons:
        primary: "ui-icon-mail-closed"
    .click ->
      dispararMensagem()
  #---------------------------------- 
    dispararMensagem = ->
      inputmsg = $('#msg')
      msg = inputmsg.val()
      inputmsg.val ''
      socket.emit 'message', mensagem: msg, author: $("#autor").val(), cor: $("#cor-texto").val()
  #---------------------------------- 
  show = (data) ->
    textoMensagem = data.mensagem
    textoMensagem = replaceAll textoMensagem, " ", "&nbsp;"
    textoMensagem = replaceAll textoMensagem, "\n", "<br />&nbsp;&nbsp;"
    textoMensagem = replaceAll(textoMensagem, item.text, item.image) for item in dictSmile 

    $('#dialog-historico').append "<span>#{data.author}:<br /><span style='color: #{data.cor};'>&nbsp;&nbsp;#{textoMensagem}</span></span><br />"
    $('#dialog-historico').animate 
      scrollTop: $('#dialog-historico').prop("scrollHeight"), 
      500
    $.titleAlert "#*#*#*#*#*#*#",
      requireBlur: yes
      stopOnFocus: yes
      interval: 700
  #---------------------------------- 

  replaceAll = (string, token, newtoken) ->
    string = string.replace(token, newtoken) while string.indexOf(token) isnt -1
    string