---
layout: post
title: Twitter Bootstrap Theme for Sphinx
description: The "spinx-bootstrap-theme" plugin brings the awesomeness of the
  Twitter Bootstrap CSS/JS framework to the Sphinx documentation tool as an
  easy-to-install plugin. Sphinx document navigation is rolled up into menu
  bar dropdown lists.
date: 2011-12-09 16:00:00 UTC
tags: ['python', 'sphinx', 'theme', 'twitter', 'bootstrap', 'github']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

## Bringing Twitter Bootstrap to Sphinx

[Bootstrap][bootstrap] is a CSS/JS framework that provides base typography,
layout (grids), forms / form inputs, tables and navigation, and has been
gaining wide popularity among developers. In my personal experience with a
couple of sites and projects, [Bootstrap][bootstrap] really provides a great
starting point for a frontend that provides good extensibility over time.

[Sphinx][sphinx] is the most popular [Python][python] documentation generator
tool. It has fantastic Python module docstring / comment parsing in addition
to a sensible static pages framework, providing a great final web site built
from both inline code documentation and outside web pages.

In the process of starting up a number of new Sphinx projects, I decided that
I would really like to use Bootstrap as the underlying UI framework.
Fortunately, Sphinx supports custom theme plugins, so spent a couple of days
hacking, and created the "[bootstrap][sbt_gh]" Sphinx theme, which is now
available on GitHub.

To show all of the coolness of bootstrap and Sphinx, I've put up a simple
[demo][sbt_demo] as well, which is just a skeleton site with the readme file
rendered as content. Here is a sample:

[![Sphinx Bootstrap Theme Demo][img_sbt_teaser_th]][img_sbt_teaser]
[img_sbt_teaser_th]: {{ img_dir }}/sbt_teaser_thumb.png
[img_sbt_teaser]: {{ img_dir }}/sbt_teaser.png

<!-- more start -->

## Installation

Sphinx themes can be installed either as a directory of files or a zip file.
To start, set up the themes directory, which typically is something like
"_themes" located in your source files directory.

{% highlight bash %}
$ cd /path/to/source
$ mkdir -p _themes
{% endhighlight %}

Next, download the most current "[bootstrap.zip][sbt_zip]" them zip file from
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
"conf.py file:

{% highlight python %}
# Activate the theme.
sys.path.append(os.path.abspath('_themes'))
html_theme_path = ['_themes']
html_theme = 'bootstrap'

# Optional. Use a shorter name to conserve nav. bar space.
html_short_title = 'Demo'
{% endhighlight %}

Rebuild your Sphinx documentation, and you should now have the Bootstrap theme
up and running! See the [readme][sbt_readme] for more information on
customizing and hacking on the theme.

## Brief Tour

TODO: HERE

* Site nav.
* Page nav.
* Search

[![Site Navigation][img_sbt_nav_site_th]][img_sbt_nav_site]
[img_sbt_nav_site_th]: {{ img_dir }}/sbt_nav_site_thumb.png
[img_sbt_nav_site]: {{ img_dir }}/sbt_nav_site.png

[![Page Navigation][img_sbt_nav_page_th]][img_sbt_nav_page]
[img_sbt_nav_page_th]: {{ img_dir }}/sbt_nav_page_thumb.png
[img_sbt_nav_page]: {{ img_dir }}/sbt_nav_page.png

[![Search Navigation][img_sbt_nav_search_th]][img_sbt_nav_search]
[img_sbt_nav_search_th]: {{ img_dir }}/sbt_nav_search_thumb.png
[img_sbt_nav_search]: {{ img_dir }}/sbt_nav_search.png

[![Search Results][img_sbt_search_th]][img_sbt_search]
[img_sbt_search_th]: {{ img_dir }}/sbt_search_thumb.png
[img_sbt_search]: {{ img_dir }}/sbt_search.png



[bootstrap]: http://twitter.github.com/bootstrap/
[sphinx]: http://sphinx.pocoo.org/
[python]: http://python.org/
[sbt_gh]: https://github.com/ryan-roemer/sphinx-bootstrap-theme
[sbt_demo]: http://ryan-roemer.github.com/sphinx-bootstrap-theme
[sbt_downloads]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/downloads
[sbt_readme]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/blob/master/README.rst
[sbt_zip]: https://github.com/downloads/ryan-roemer/sphinx-bootstrap-theme/bootstrap.zip

<!-- more end -->
