module.exports = (grunt) ->

  # Add plugins.
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-recess"
  grunt.loadNpmTasks "grunt-shell-spawn"
  grunt.loadNpmTasks "grunt-concurrent"

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
        options:
          spawn:    false
          atBegin:  true
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
      "site-dev":
        command: "jekyll serve --baseurl / --watch --limit 3"
        options:
          stdout: true
          aync:   true
      "site-full":
        command: "jekyll serve --baseurl /"
        options:
          stdout: true
          aync:   true

    concurrent:
      options:
        logConcurrentOutput: true
      all: [
        "watch:recess"
        "shell:site-dev"
      ]


  grunt.registerTask "dev:site", "Build dev. website", ["shell:site-dev"]

  grunt.registerTask "dev:full", "Build full dev. website", ["shell:site-full"]

  #############################################################################
  # Aliases.
  #############################################################################
  grunt.registerTask "build", "Build all source files.", ["recess"]
  grunt.registerTask "default", "Watch all source files.", ["concurrent:all"]
