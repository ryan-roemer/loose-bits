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
      site:
        src:  [
          "_less/default.less"
        ]
        dest: "media/css/default.css"
        options:
          compress: true

    watch:
      site:
        files: [
          "_includes/**"
          "_layouts/**"
          "_posts/**"
          "media/**"
          "*.md"
          "*.xml"
          "*.yml"
        ]
        tasks: "build:site"
      less:
        files: [
          "<config:less.site.src>"
        ]
        tasks: "less"

      # TODO 404
      # TODO less

  grunt.registerTask "build:site", "Build dev. website", ->
    utils.spawn "jekyll", ["--base-url", "/"], @async()

  grunt.registerTask "dev:server", "Build dev. website", ->
    utils.exec "mkdir -p _site &&
                cd _site &&
                python -m SimpleHTTPServer 4000", @async()

  #############################################################################
  # Aliases.
  #############################################################################
  grunt.registerTask "watch-all",
                     "Watch and build all source files.",
                     "build:site less watch"
