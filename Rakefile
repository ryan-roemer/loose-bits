# Stylus
STYLUS_BIN = "./node_modules/stylus/bin/stylus"
STYLUS_COMPRESS = true
STYLUS_INPUT_DIR = "./_styl"
STYLUS_OUTPUT_DIR = "./media/css"

namespace :build do
  desc "Build Stylus CSS to media directory."
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

  desc "Build CSS to dev. media directory."
  task :css_dev => :css do
    sh "cp -r ./media _site/media"
  end

  desc "Build prod. documents to sites directory."
  task :docs => :css do
    sh "jekyll"
  end

  desc "Build dev. documents to sites directory."
  task :docs_dev => :css do
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
