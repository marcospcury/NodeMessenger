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
      main:
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

    mochacov:
      options:
        require: ['public/javascripts/test/support/runnerSetup.js']
        reporter: 'spec'
      client: ['public/javascripts/test/unit/**/*.js']

    'curl-dir':
      long:
        src: [
              'http://raw.github.com/marcospcury/JSLib/master/jquery.titlealert.min.js', 
              'http://code.jquery.com/ui/1.10.3/jquery-ui.js'
            ]
        dest: 'public/javascripts/lib'

    bower:
      install:
        options:
          target: 'public/javascripts/lib'
          copy: false
    clean:
      js:
        dirs: ['dist/models/', 'dist/routes/', 'dist/test/unit', 'dist/test/', 'dist/views/', 'dist/']

    'clean-pattern':
      scripts:
        path: 'public/javascripts/'
        pattern: '[a-z].js'
      scriptsModels:
        path: 'public/javascripts/models'
        pattern: '[a-z].js'
      scriptsViews:
        path: 'public/javascripts/views'
        pattern: '[a-z].js'
      scriptsSupport:
        path: 'public/javascripts/support'
        pattern: '[a-z].js'

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-qunit'
  grunt.loadNpmTasks 'grunt-cleanx'
  grunt.loadNpmTasks 'clean-pattern'
  grunt.loadNpmTasks 'grunt-mocha-cov'
  grunt.loadNpmTasks 'grunt-curl'

  grunt.registerTask 'default', ['coffee', 'copy', 'express']
  grunt.registerTask 'test', ['coffee:public', 'mochacov:client']
  grunt.registerTask 'test:travis', ['coffee:public', 'curl-dir', 'mochacov:client']
  grunt.registerTask 'install', ['coffee', 'bower', 'copy']
  grunt.registerTask 'cleanBuild', ['clean', 'clean-pattern']
  grunt.registerTask 'production', ['express:prod']