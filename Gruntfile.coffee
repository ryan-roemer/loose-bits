pkg       = require './package.json'

module.exports = (grunt) ->

  # Add plugins.
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-recess'
  grunt.loadNpmTasks 'grunt-shell-spawn'

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
        tasks: ["recess"]
      # site:
      #   files: [
      #     "<config:recess.bootstrap.src>"
      #     "<config:recess.site.src>"
      #     "_includes/**"
      #     "_layouts/**"
      #     "_posts/**"
      #     "media/**"
      #     "*.md"
      #     "*.xml"
      #     "*.yml"
      #   ]
      #   tasks: "dev:site"

    shell:
      devSite:
        command: "jekyll serve --baseurl / --limit 3"
        options:
          stdout: true,
          aync:   true
      devFull:
        command: "jekyll serve --baseurl /"
        options:
          stdout: true,
          aync:   true


  grunt.registerTask "dev:site", "Build dev. website", ["shell:devSite"]

  grunt.registerTask "dev:full", "Build full dev. website", ["shell:devFull"]

  #############################################################################
  # Aliases.
  #############################################################################
  grunt.registerTask "build-all",
                     "Build all source files.",
                     ["recess"]

  grunt.registerTask "watch-all",
                     "Watch and build all source/dev files.",
                     ["build-all", "watch"]
