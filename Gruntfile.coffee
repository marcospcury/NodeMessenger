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

    qunit:
      all: ["dist/test/unit.html"]


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-contrib-qunit'

  grunt.registerTask 'default', ['coffee', 'copy', 'express']
  grunt.registerTask 'test', ['coffee', 'copy', 'qunit']