---
layout: post
title: Sphinx Bootstrap Theme Updates - Mobile, Dropdowns, and More
description: The "spinx-bootstrap-theme" plugin integrates Twitter
  Bootstrap with the Sphinx documentation tool. Version 0.1.0 adds new features
  including responsive (mobile-friendly) design, better dropdown navigation
  menu support, deployment from the PyPI repository and
  an upgrade to Twitter Bootstrap v2.2.1.
date: 2012-11-19 11:30:00 UTC
tags: ['python', 'sphinx', 'theme', 'twitter', 'bootstrap', 'mobile']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

## Sphinx Bootstrap Theme Updates!

Almost a year ago, I created the [Sphinx Bootstrap Theme][sbt_gh] project that
brings together two of my favorite open source technologies - Sphinx and Twitter
bootstrap. [Sphinx][sphinx] is a widely-used [Python][python]-based authoring
tool for creating static websites and API documentation. [Twitter][twitter]
[Bootstrap][bootstrap] is a frontend JavaScript / CSS framework that offers a
consistent UI experience, typography, grid systems, navigation / button / etc.
components, and responsive options for mobile design.

Since its introduction, I have regularly used Sphinx with the Bootstrap theme to
document my open source Python projects and we use the theme for all internal
technical documentation at work. Now coming up on the project's anniversary, it
seemed appropriate to add some tweaks and enhancements to increase the usability
and extensibility of the theme.

Improvements now available in version v0.1.0 include:

* Upgraded the Bootstrap libraries to version 2.2.1.
* Added several new theme options to control UI appearance and behavior.
* Navigation bar menus now have hierarchical sub-menus for a more intuitive
  experience.
* Reworked the underlying layout code to support fully responsive design,
  allowing any site to look great and actually be usable on mobile devices
  like an iPhone or iPad.
* Created a PyPI package entry to permit installation via a simple
  `pip install sphinx_bootstrap_theme` in addition to the traditional method
  of downloading a theme zip file.

So let's see how everything looks and works with the new v0.1.0 theme.

## Theme Options

The theme as several new options that you can set in the "conf.py"
configuration file.

### Bootstrap Theme Demo Site

Let's start with the Bootstrap theme's own
[demonstration website][sbt_demo_readme]:

[![Sphinx Bootstrap Theme Desktop View][img_sbt_desk]][img_sbt_desk]
[img_sbt_desk]: {{ img_dir }}/sbt_desk.png

<!-- more start -->

The demo site has the following theme option settings in
"[conf.py][sbt_demo_cfg]":

{% highlight python %}
html_theme_options = {
    # HTML navbar class (Default: "navbar") to attach to <div> element.
    # For black navbar, do "navbar navbar-inverse"
    'navbar_class': "navbar navbar-inverse",

    # Fix navigation bar to top of page?
    # Values: "true" (default) or "false"
    'navbar_fixed_top': "true",

    # Location of link to source.
    # Options are "nav" (default), "footer" or anything else to exclude.
    'source_link_position': "nav",
}
{% endhighlight %}

Notably, this gives us a dark black navigation bar that is fixed to the top
of the page during any scrolling.

### Django Cloud Browser

[Django Cloud Browser][cb_gh] is a reusable [Django][django] for browsing
and downloading files stored in various cloud datastores (like Amazon Web
Services S3, Rackspace Cloud Files, etc.). The [API documentation][cb_site]
uses the Bootstrap theme with (mostly) the default options:

[![Django Cloud Browser][img_sbt_cb]][img_sbt_cb]
[img_sbt_cb]: {{ img_dir }}/sbt_cb.png

The only real tweak is setting `'source_link_position': "footer"` to move
the documentation source code link to the bottom of each page.

## Navigation Menu Dropdowns

* Nav Dropdown

[![Navbar Menu Dropdowns][img_sbt_nav_dropdown_hl]][img_sbt_nav_dropdown_hl]
[img_sbt_nav_dropdown]: {{ img_dir }}/sbt_nav_dropdown.png
[img_sbt_nav_dropdown_hl]: {{ img_dir }}/sbt_nav_dropdown_hl.png

## Mobile UI Support

* Mobile Page
* Mobile Nav
* Mobile drop downs.

[![Mobile Phone View][img_sbt_ios_th]][img_sbt_ios]
[img_sbt_ios_th]: {{ img_dir }}/sbt_ios_th.png
[img_sbt_ios]: {{ img_dir }}/sbt_ios.png

[![Mobile Phone Navbar][img_sbt_ios_nav_th]][img_sbt_ios_nav]
[img_sbt_ios_nav_th]: {{ img_dir }}/sbt_ios_nav_th.png
[img_sbt_ios_nav]: {{ img_dir }}/sbt_ios_nav.png

[![Mobile Phone Navbar Menu][img_sbt_ios_nav_dropdown_hl_th]][img_sbt_ios_nav_dropdown_hl]
[img_sbt_ios_nav_dropdown_th]: {{ img_dir }}/sbt_ios_nav_dropdown_th.png
[img_sbt_ios_nav_dropdown]: {{ img_dir }}/sbt_ios_nav_dropdown.png
[img_sbt_ios_nav_dropdown_hl_th]: {{ img_dir }}/sbt_ios_nav_dropdown_hl_th.png
[img_sbt_ios_nav_dropdown_hl]: {{ img_dir }}/sbt_ios_nav_dropdown_hl.png

## Installation

* Existing zip file
* New PyPI.



[bootstrap]: http://twitter.github.com/bootstrap/
[python]: http://python.org/
[django]: https://www.djangoproject.com/
[sphinx]: http://sphinx.pocoo.org/
[twitter]: https://twitter.com/
[cb_gh]: http://ryan-roemer.github.com/django-cloud-browser/
[cb_site]: https://github.com/ryan-roemer/django-cloud-browser/
[sbt_lb_post]: http://loose-bits.com/2011/12/09/sphinx-twitter-bootstrap-theme.html
[sbt_demo]: http://ryan-roemer.github.com/sphinx-bootstrap-theme
[sbt_demo_cfg]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/blob/master/demo/source/conf.py
[sbt_demo_readme]: http://ryan-roemer.github.com/sphinx-bootstrap-theme/README.html
[sbt_downloads]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/downloads
[sbt_gh]: https://github.com/ryan-roemer/sphinx-bootstrap-theme
[sbt_issues]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/issues
[sbt_pull]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/pulls
[sbt_readme]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/blob/master/README.rst
[sbt_pypi]: http://pypi.python.org/pypi/sphinx-bootstrap-theme
[sbt_zip]: https://github.com/downloads/ryan-roemer/sphinx-bootstrap-theme/bootstrap.zip

<!-- more end -->
