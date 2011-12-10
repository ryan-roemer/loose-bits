---
layout: post
title: Twitter Bootstrap Theme for Sphinx
description: The "spinx-bootstrap-theme" plugin brings the awesomeness of the
  Twitter Bootstrap CSS/JS framework to the Sphinx documentation tool as an
  easy-to-install plugin.
date: 2011-12-09 16:00:00 UTC
tags: ['python', 'sphinx', 'theme', 'twitter', 'bootstrap', 'github']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

## Bringing Twitter Bootstrap to Sphinx

[Bootstrap][bootstrap] is an open source CSS/JS framework from the folks at
[Twitter][twitter] that provides base typography, layout (grids), forms / form
inputs, tables and navigation, and has been gaining wide popularity among
developers. In my personal experience with a couple of sites and projects,
Bootstrap really provides a great starting point for a frontend that provides
good extensibility over time.

[Sphinx][sphinx] is the most popular [Python][python] documentation generator
tool. It has fantastic Python module docstring / comment parsing in addition
to a sensible static pages framework, providing a great final web site built
from both inline code documentation and outside web pages.

In the process of starting up a number of new Sphinx projects, I decided that
I would really like to use Bootstrap as the underlying UI framework.
Fortunately, Sphinx supports custom theme plugins, so I spent a couple of days
hacking, and created a [Sphinx Bootstrap Theme][sbt_gh], which is now
available on GitHub.

To show all of the coolness of Bootstrap and Sphinx, I've put up a simple
[demo][sbt_demo], which provides a skeleton Sphinx site with the project
[README][sbt_demo_readme] file rendered as content. Here is a screenshot:

[![Sphinx Bootstrap Theme Demo][img_sbt_teaser_th]][img_sbt_teaser]
[img_sbt_teaser_th]: {{ img_dir }}/sbt_teaser_thumb.png
[img_sbt_teaser]: {{ img_dir }}/sbt_teaser.png

<!-- more start -->

## Installation

Sphinx themes can be installed either as a directory of files or a zip file.
For simplicity's sake, we'll go with a pre-packaged zip file installation here.

First, set up a themes directory, which typically is something like
"_themes" located in your Sphinx source directory:

{% highlight bash %}
$ cd /path/to/source
$ mkdir -p _themes
{% endhighlight %}

Next, download the most current "[bootstrap.zip][sbt_zip]" archive from
GitHub. Note that older zipped theme files are available at the
[downloads][sbt_downloads] page, with git hash suffixes.

{% highlight bash %}
$ cd /path/to/source/_themes
$ wget https://github.com/downloads/ryan-roemer/sphinx-bootstrap-theme/bootstrap.zip
{% endhighlight %}

As an alternative, you can just clone the theme repository, and place the
"bootstrap" directory in your themes directory. The "bootstrap.zip" file
should be the most up-to-date version, but getting the directory from source
will remain the authoritative current version.

Finally, add the themes directory path and theme name to your source Sphinx
"conf.py" file:

{% highlight python %}
# Activate the theme.
sys.path.append(os.path.abspath('_themes'))
html_theme_path = ['_themes']
html_theme = 'bootstrap'

# Optional. Use a shorter name to conserve nav. bar space.
html_short_title = 'Demo'
{% endhighlight %}

Rebuild your Sphinx documentation, and you should now have the Bootstrap theme
up and running! See the [README][sbt_readme] for more information on
customizing and hacking on the theme.

## Brief Tour

The Bootstrap Sphinx theme basically rolls up the site-wide / page-level
table of contents, page navigation, and search form into the main navigation
top bar.

### Site Navigation

The first dropdown tab is the "Site" button (expanded and highlighted below).
Internally this wraps up the ``globaltoc`` template using the ``toctree``
directive.

[![Site Navigation][img_sbt_nav_site_th]][img_sbt_nav_site]
[img_sbt_nav_site_th]: {{ img_dir }}/sbt_nav_site_thumb.png
[img_sbt_nav_site]: {{ img_dir }}/sbt_nav_site.png

For both the site and page navigation dropdowns, the Bootstrap theme uses
JavaScript hackery to unpack the internal list structure and convert it to
an ordered flat list with hierarchy displayed using extra left padding
corresponding to levels. The natural levels of table of content displayed
normally by Sphinx should be preserved in the dropdown menus.

### Page Navigation

The second dropdown tab is the "Page" navigation for table of contents link
within a single page. This wraps the ``localtoc`` template using the ``toc``
directive.

[![Page Navigation][img_sbt_nav_page_th]][img_sbt_nav_page]
[img_sbt_nav_page_th]: {{ img_dir }}/sbt_nav_page_thumb.png
[img_sbt_nav_page]: {{ img_dir }}/sbt_nav_page.png

### Search

The right "Search" box in the navigation top bar connects to the built-in,
client-side search that Sphinx provides. Here we search for the term
"bootstrap":

[![Search Navigation][img_sbt_nav_search_th]][img_sbt_nav_search]
[img_sbt_nav_search_th]: {{ img_dir }}/sbt_nav_search_thumb.png
[img_sbt_nav_search]: {{ img_dir }}/sbt_nav_search.png

... which gives us the following page matches:

[![Search Results][img_sbt_search_th]][img_sbt_search]
[img_sbt_search_th]: {{ img_dir }}/sbt_search_thumb.png
[img_sbt_search]: {{ img_dir }}/sbt_search.png

### Final Thoughts

The Bootstrap Theme provides an easy means for Twitter Bootstrap integration
for my current Sphinx sites. But, as I've just put together the theme this
week, it is probably still rough around the edges. Any
[issue reports][sbt_issues], [pull requests][sbt_pull], and feedback are most
welcome.

[bootstrap]: http://twitter.github.com/bootstrap/
[python]: http://python.org/
[sbt_demo]: http://ryan-roemer.github.com/sphinx-bootstrap-theme
[sbt_demo_readme]: http://ryan-roemer.github.com/sphinx-bootstrap-theme/README.html
[sbt_downloads]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/downloads
[sbt_gh]: https://github.com/ryan-roemer/sphinx-bootstrap-theme
[sbt_issues]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/issues
[sbt_pull]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/pulls
[sbt_readme]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/blob/master/README.rst
[sbt_zip]: https://github.com/downloads/ryan-roemer/sphinx-bootstrap-theme/bootstrap.zip
[sphinx]: http://sphinx.pocoo.org/
[twitter]: https://twitter.com/

<!-- more end -->
