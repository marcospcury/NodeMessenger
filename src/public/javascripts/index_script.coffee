$ ->
  socket = io.connect()
  socket.on 'news', (data) -> show(data)
  montarEmoticons()
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

montarEmoticons = ->
  htmlIcons = []
  htmlIcons.push "<table class=\"emoticons\"><tr>"
  contaEmoticons = 0
  for item in dictSmile
    if contaEmoticons % 12 is 0
      htmlIcons.push "</tr><tr>"

    htmlIcons.push "<td class=\"click-emoticon\" param=\"#{contaEmoticons}\" title=\"#{item.text}\">#{item.image}</td>"
    contaEmoticons++

  htmlIcons.push "</table>"
  $("#emoticons-container").html htmlIcons.join ''
  false

#---------------------------------- 

replaceAll = (string, token, newtoken) ->
  string = string.replace(token, newtoken) while string.indexOf(token) isnt -1
  string

dictSmile = []
dictSmile.push text: ":)" , image: "<img src='/images/emoticons/smile1.gif'>"
dictSmile.push text: ":smile:" , image: "<img src='/images/emoticons/smile2.gif'>"
dictSmile.push text: ":D" , image: "<img src='/images/emoticons/grin.gif'>"
dictSmile.push text: ":w00t:" , image: "<img src='/images/emoticons/w00t.gif'>"
dictSmile.push text: ":P" , image: "<img src='/images/emoticons/tongue.gif'>"
dictSmile.push text: ";)" , image: "<img src='/images/emoticons/wink.gif'>"
dictSmile.push text: ":|" , image: "<img src='/images/emoticons/noexpression.gif'>"
dictSmile.push text: ":/" , image: "<img src='/images/emoticons/confused.gif'>"
dictSmile.push text: ":(" , image: "<img src='/images/emoticons/sad.gif'>"
dictSmile.push text: ":'(" , image: "<img src='/images/emoticons/cry.gif'>"
dictSmile.push text: ":O" , image: "<img src='/images/emoticons/ohmy.gif'>"
dictSmile.push text: "zzzz" , image: "<img src='/images/emoticons/sleeping.gif'>"
dictSmile.push text: ":innocent:" , image: "<img src='/images/emoticons/innocent.gif'>"
dictSmile.push text: ":closedeyes:" , image: "<img src='/images/emoticons/closedeyes.gif'>"
dictSmile.push text: ":cool:" , image: "<img src='/images/emoticons/cool2.gif'>"
dictSmile.push text: ":thumbsdown:" , image: "<img src='/images/emoticons/thumbsdown.gif'>"
dictSmile.push text: ":blush:" , image: "<img src='/images/emoticons/blush.gif'>"
dictSmile.push text: ":yes:" , image: "<img src='/images/emoticons/yes.gif'>"
dictSmile.push text: ":no:" , image: "<img src='/images/emoticons/no.gif'>"
dictSmile.push text: "inlove" , image: "<img src='/images/emoticons/love.gif'>"
dictSmile.push text: "(L)" , image: "<img src='/images/emoticons/heart.gif'>"
dictSmile.push text: ":?:" , image: "<img src='/images/emoticons/question.gif'>"
dictSmile.push text: ":!:" , image: "<img src='/images/emoticons/excl.gif'>"
dictSmile.push text: ":idea:" , image: "<img src='/images/emoticons/idea.gif'>"
dictSmile.push text: ":arrow:" , image: "<img src='/images/emoticons/arrow.gif'>"
dictSmile.push text: ":arrow2:" , image: "<img src='/images/emoticons/arrow2.gif'>"
dictSmile.push text: ":hmm:" , image: "<img src='/images/emoticons/hmm.gif'>"
dictSmile.push text: ":hmmm:" , image: "<img src='/images/emoticons/hmmm.gif'>"
dictSmile.push text: ":huh:" , image: "<img src='/images/emoticons/huh.gif'>"
dictSmile.push text: ":rolleyes:" , image: "<img src='/images/emoticons/rolleyes.gif'>"
dictSmile.push text: ":kiss:" , image: "<img src='/images/emoticons/kiss.gif'>"
dictSmile.push text: ":shifty:" , image: "<img src='/images/emoticons/shifty.gif'>" 
dictSmile.push text: "flowers" , image: "<img src='/images/emoticons/0032.gif'>" 
dictSmile.push text: "suadoo" , image: "<img src='/images/emoticons/0067.gif'>" 
dictSmile.push text: "026" , image: "<img src='/images/emoticons/026.gif'>" 
dictSmile.push text: "wub" , image: "<img src='/images/emoticons/0098.gif'>" 
dictSmile.push text: "hug" , image: "<img src='/images/emoticons/0035.gif'>" 

dictSmile.push text: "kisss" , image: "<img src='/images/emoticons/020.gif'>"
dictSmile.push text: "consoll" , image: "<img src='/images/emoticons/021.gif'>"
dictSmile.push text: "blinkk" , image: "<img src='/images/emoticons/022.gif'>"
dictSmile.push text: "unsure" , image: "<img src='/images/emoticons/023.gif'>"
dictSmile.push text: "dryy" , image: "<img src='/images/emoticons/024.gif'>"
dictSmile.push text: "afrow" , image: "<img src='/images/emoticons/025.gif'>"
dictSmile.push text: "coldd" , image: "<img src='/images/emoticons/027.gif'>"
dictSmile.push text: "nonono" , image: "<img src='/images/emoticons/028.gif'>"
dictSmile.push text: "bye2" , image: "<img src='/images/emoticons/029.gif'>"
dictSmile.push text: "blehh" , image: "<img src='/images/emoticons/030.gif'>"
dictSmile.push text: "batmann" , image: "<img src='/images/emoticons/031.gif'>"
dictSmile.push text: "bounce" , image: "<img src='/images/emoticons/032.gif'>"
dictSmile.push text: "musik" , image: "<img src='/images/emoticons/033.gif'>"
dictSmile.push text: "happyy" , image: "<img src='/images/emoticons/034.gif'>"
dictSmile.push text: "yawn" , image: "<img src='/images/emoticons/035.gif'>"
dictSmile.push text: "crybaby" , image: "<img src='/images/emoticons/036.gif'>"
dictSmile.push text: "drool" , image: "<img src='/images/emoticons/037.gif'>"

