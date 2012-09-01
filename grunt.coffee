module.exports = (grunt) ->

  # Add plugins.
  grunt.loadNpmTasks 'grunt-less'

  #############################################################################
  # Config.
  #############################################################################
  grunt.initConfig
    pkg: '<json:package.json>'

    less:
      app:
        src:  ["_less/default.less"]
        dest: "media/css/default.css"
        options:
          compress: true
