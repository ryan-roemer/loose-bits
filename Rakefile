require 'jekyll'
require 'jekyll/site'

# Stylus  - TODO REMOVE
STYLUS_BIN = "./node_modules/stylus/bin/stylus"
STYLUS_COMPRESS = true
STYLUS_INPUT_DIR = "./_styl"
STYLUS_OUTPUT_DIR = "./media/css"

# Patch Jekyll with single writing method.
module Jekyll
  class Site
    def process_single(src)
      self.reset
      self.read_layouts
      name = File.basename(src)
      dir = File.dirname(src)
      single = Jekyll::Page.new(self, self.source, dir, name)
      single.render(self.layouts, site_payload)
      # Write back to root (not _sites) directory.
      single.write(self.source)
    end
  end
end

# Tasks
namespace :gen do
  desc "Generate 404 page to root directory."
  task :not_found do
    options = Jekyll.configuration({})
    site = Jekyll::Site.new(options)
    site.process_single("404.md")
  end

  desc "Build Stylus CSS to root media directory." # TODO REMOVE
  task :css do
    mkdir_p STYLUS_OUTPUT_DIR
    compress = STYLUS_COMPRESS ? " --compress " : " ";
    sh "#{STYLUS_BIN} --out #{STYLUS_OUTPUT_DIR} #{compress} "\
       "#{STYLUS_INPUT_DIR}"
  end

  desc "Build Stylus CSS syntax highlighting to media directory."
  task :css_syntax do
    mkdir_p "#{STYLUS_OUTPUT_DIR}/syntax"
    compress = STYLUS_COMPRESS ? " --compress " : " ";
    sh "#{STYLUS_BIN} --out #{STYLUS_OUTPUT_DIR}/syntax #{compress} "\
       "#{STYLUS_INPUT_DIR}/syntax"
  end

  desc "Build all generated, source files."
  task :all => [:not_found, :css, :css_syntax] do
  end
end

namespace :build do
  desc "Build CSS to dev. media directory."
  task :css_dev => "gen:css" do
    sh "cp -r ./media _site/media"
  end

  desc "Build prod. documents to sites directory."
  task :docs => "gen:css" do
    sh "jekyll"
  end

  desc "Build dev. documents to sites directory."
  task :docs_dev => ["gen:not_found", "gen:css"] do
    sh "jekyll --base-url '/'"
  end

  desc "Clean sites directory."
  task :clean do
    sh "rm -rf _site"
  end
end

namespace :dev do
  desc "Run development server."
  task :server do
    sh "jekyll --auto --server --base-url '/'"
  end
end
