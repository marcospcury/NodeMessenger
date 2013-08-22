requirejs.config
  paths:
    jquery: 'lib/jquery/jquery'
    underscore: 'lib/underscore/underscore'
    backbone: 'lib/backbone/backbone'
    handlebars: 'lib/handlebars/index'
    text: 'lib/requirejs-text/text'
    jqueryui: '//code.jquery.com/ui/1.10.3/jquery-ui'
    sinon: 'lib/sinon/lib/sinon'
    socketio: '../../socket.io/socket.io'
    jqueryAlert: '//raw.github.com/marcospcury/JSLib/master/jquery.titlealert.min'
    Qunit: 'lib/qunit/qunit/qunit.js'
  shim:
    'jquery':
      exports: '$'
    'jqueryui':
      deps: ['jquery']
    'jqueryAlert':
      deps: ['jquery']
    'underscore':
      exports: '_'
    'backbone':
      deps: ['jquery', 'underscore']
      exports: 'Backbone'
    'Qunit':
      exports: 'Qunit'
      init: ->
        Qunit.config.autoload = false
        Qunit.config.autostart = false