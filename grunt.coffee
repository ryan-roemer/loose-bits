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
      bootstrap:
        src:  [
          "_less/bootstrap.less"
        ]
        dest: "media/css/vendor/bootstrap.css"
        options:
          compress: true
      site:
        src:  [
          "_less/default.less"
        ]
        dest: "media/css/default.css"
        options:
          compress: true

    watch:
      less:
        files: [
          "<config:less.bootstrap.src>"
          "<config:less.site.src>"
          "_less/vendor/**"
          "_less/bootstrap-variables.less"
        ]
        tasks: "less dev:site"
      404:
        files: [
          "404.md"
        ]
        tasks: "build:404"
      site:
        files: [
          "<config:less.bootstrap.src>"
          "<config:less.site.src>"
          "_includes/**"
          "_layouts/**"
          "_posts/**"
          "media/**"
          "*.md"
          "*.xml"
          "*.yml"
        ]
        tasks: "dev:site"

  grunt.registerTask "build:404", "Build 404 page", ->
    utils.exec "rake gen:not_found", @async()

  grunt.registerTask "dev:site", "Build dev. website", ->
    utils.spawn "jekyll", ["--base-url", "/", "--limit", "3"], @async()

  grunt.registerTask "dev:server", "Build dev. website", ->
    utils.exec "mkdir -p _site &&
                cd _site &&
                python -m SimpleHTTPServer 4000", @async()

  #############################################################################
  # Aliases.
  #############################################################################
  grunt.registerTask "build-all",
                     "Build all source files.",
                     "build:404 less"

  grunt.registerTask "watch-all",
                     "Watch and build all source/dev files.",
                     "build-all dev:site watch"
