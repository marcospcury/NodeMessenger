module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      app:
        expand:true
        cwd: 'app'
        src: ['**/*.coffee']
        dest: 'dist'
        ext: '.js'
        options:
          bare:true
      public:
        expand:true
        cwd: 'public'
        src: ['**/*.coffee', '!javascripts/lib/**/*']
        dest: 'public'
        ext: '.js'
        options:
          bare:true
 
    copy:
      main :
        files: [{
          expand: true
          cwd: 'app/'
          src: ['**/*.!(coffee)']
          dest: 'dist/'
          }]
 
    express:
      options:
        background: false
      main:
        options:
          script: 'server.coffee'
          node_env: 'development'
      prod:
        options:
          script: 'server.js'
          node_env: 'production'
          background: false

    qunit:
      all: ["dist/test/unit.html"]

    bower:
      install:
        options:
          target: 'public/javascripts/lib'
          copy: false

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-qunit'

  grunt.registerTask 'default', ['coffee', 'copy', 'express']
  grunt.registerTask 'test', ['coffee', 'bower', 'copy', 'qunit']
  grunt.registerTask 'install', ['coffee', 'bower', 'copy']
  grunt.registerTask 'production', ['express:prod']