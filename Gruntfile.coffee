pkg       = require './package.json'
cakepop   = require 'cakepop'
utils     = cakepop.utils

module.exports = (grunt) ->

  # Add plugins.
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-recess'

  #############################################################################
  # Config.
  #############################################################################
  grunt.initConfig
    pkg: '<json:package.json>'

    recess:
      bootstrap:
        src: [
          "_less/bootstrap.less"
        ]
        dest: "media/css/vendor/bootstrap.css"
        options:
          compile:  true
          compress: true
      site:
        src: [
          "_less/default.less"
        ]
        dest: "media/css/default.css"
        options:
          compile:  true
          compress: true

    watch:
      recess:
        files: [
          "<config:recess.bootstrap.src>"
          "<config:recess.site.src>"
          "_less/vendor/**"
          "_less/bootstrap-variables.less"
        ]
        tasks: ["recess", "dev:site"]
      site:
        files: [
          "<config:recess.bootstrap.src>"
          "<config:recess.site.src>"
          "_includes/**"
          "_layouts/**"
          "_posts/**"
          "media/**"
          "*.md"
          "*.xml"
          "*.yml"
        ]
        tasks: "dev:site"

  grunt.registerTask "dev:site", "Build dev. website", ->
    utils.spawn "jekyll", ["--base-url", "/", "--limit", "3"], @async()

  grunt.registerTask "dev:full", "Build full dev. website", ->
    utils.spawn "jekyll", ["--base-url", "/"], @async()

  grunt.registerTask "dev:server", "Build dev. website", ->
    args = ["--base-url", "/", "--limit", "3", "--server", "4000"]
    utils.spawn "jekyll", args, @async()

  #############################################################################
  # Aliases.
  #############################################################################
  grunt.registerTask "build-all",
                     "Build all source files.",
                     ["recess"]

  grunt.registerTask "watch-all",
                     "Watch and build all source/dev files.",
                     ["build-all", "watch"]
