global.requirejs = require "requirejs"
jsdom = require("jsdom")
global.window = window = jsdom.jsdom().createWindow("<html><body></body></html>")

require '../../bootstrap'
global.jQuery = window.jQuery = window.$ = global.$ = requirejs 'jquery'