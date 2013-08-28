requirejs.config
  paths:
    jquery: 'lib/jquery/jquery'
    underscore: 'lib/underscore/underscore'
    backbone: 'lib/backbone/backbone'
    handlebars: 'lib/handlebars/index'
    text: 'lib/requirejs-text/text'
    jqueryui: 'lib/jquery-ui'
    sinon: 'lib/sinon/lib/sinon'
    socketio: 'test/support/mockWebsocket'
    jqueryAlert: 'lib/jquery.titlealert.min'
  shim:
    'jqueryui':
      deps: ['jquery']
      exports: 'jqueryui'
    'jqueryAlert':
      deps: ['jquery']
    'underscore':
      exports: '_'
    'backbone':
      deps: ['jquery', 'underscore']
      exports: 'Backbone'