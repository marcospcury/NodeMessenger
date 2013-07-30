requirejs.config
	paths:
		jquery: 'lib/jquery/jquery'
		underscore: 'lib/underscore/underscore'
		backbone: 'lib/backbone/backbone'
		handlebars: 'lib/handlebars/index'
		text: 'lib/requirejs-text/text'
		jqueryui: '//code.jquery.com/ui/1.10.3/jquery-ui'
		socketio: '../../socket.io/socket.io'
	shim:
		'jqueryui':
			deps: ['jquery']