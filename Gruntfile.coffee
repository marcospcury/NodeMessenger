module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      app:
        expand:true
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'dist'
        ext: '.js'
        options:
          bare:true
 
    copy:
      main :
        files: [{
          expand: true
          cwd: 'src/'
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

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.registerTask 'default', ['coffee', 'copy', 'express']