requirejs.config
	paths:
		jquery: 'lib/jquery/jquery'
		underscore: 'lib/underscore/underscore'
		backbone: 'lib/backbone/backbone'
		handlebars: 'lib/handlebars/index'
		text: 'lib/requirejs-text/text'
		jqueryui: 'jquery-ui'
		socketio: '../../socket.io/socket.io'
	shim:
		'jqueryui':
			deps: ['jquery']