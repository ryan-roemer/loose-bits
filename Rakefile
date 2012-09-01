require 'jekyll'
require 'jekyll/site'

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
end

