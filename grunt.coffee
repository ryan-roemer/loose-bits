pkg       = require './package.json'
cakepop   = require 'cakepop'
utils     = cakepop.utils

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

    watch:
      coffee:
        files: [
          "**/*.md"
        ]
        tasks: "build:site"

  grunt.registerTask "build:site", "Build website", ->
    utils.spawn "jekyll", [], @async()

  #############################################################################
  # Aliases.
  #############################################################################
  grunt.registerTask "watch-all",
                     "Watch and build all source files.",
                     "build:site less watch"
