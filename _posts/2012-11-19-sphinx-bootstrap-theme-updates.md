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

Almost a year ago, I created the [Sphinx Bootstrap Theme][sbt_gh] project to
bring together two of my favorite open source technologies - Sphinx and Twitter
Bootstrap. [Sphinx][sphinx] is a widely-used [Python][python]-based authoring
tool for creating static websites and API documentation. [Twitter][twitter]
[Bootstrap][bootstrap] is a frontend JavaScript / CSS framework that offers a
consistent UI experience, typography, grid systems, navigation / button / etc.
components, and responsive features for mobile design.

Since its introduction, I now use Sphinx with the Bootstrap Theme
for my open source Python projects and we use the theme for all internal
technical documentation at work. Coming up on the project's anniversary, it
seemed appropriate to add some tweaks and enhancements to increase the usability
and extensibility of the theme.

Improvements now available in version 0.1.0 include:

* Upgraded the Bootstrap libraries to version 2.2.1.
* Added new theme options to control UI appearance and behavior.
* Navigation bar menus now have hierarchical sub-menus for a more intuitive
  experience.
* Reworked the underlying layout code to support fully responsive design,
  allowing any site to look great on mobile devices like an iPhone or iPad.
* Created a PyPI package entry to permit installation via
  `pip install sphinx_bootstrap_theme` (in addition to the traditional method
  of downloading a theme zip file).

So let's see how everything looks and works with the new v0.1.0 theme.

## Theme Options

The theme as several new options that you can set in the "conf.py"
configuration file.

### Bootstrap Theme Demo Site

Let's start with the Bootstrap Theme's own
[demonstration website][sbt_demo_readme].

[![Sphinx Bootstrap Theme Desktop View][img_sbt_desk]][img_sbt_desk]
[img_sbt_desk]: {{ img_dir }}/sbt_desk.png

<!-- more start -->

The demo site has the following theme option settings in
"[conf.py][sbt_demo_cfg]":

{% highlight python %}
html_theme_options = {
    # HTML navbar class (Default: "navbar") to attach to <div>.
    # For black navbar, do "navbar navbar-inverse"
    'navbar_class': "navbar navbar-inverse",

    # Fix navigation bar to top of page?
    # Values: "true" (default) or "false"
    'navbar_fixed_top': "true",

    # Location of link to source.
    # Options are "nav" (default), "footer".
    'source_link_position': "nav",
}
{% endhighlight %}

Notably, this gives us a dark navigation bar that is fixed to the top
of the page during any scrolling.

### Django Cloud Browser

[Django Cloud Browser][cb_gh] is a reusable [Django][django] application for
browsing and downloading files stored in various cloud datastores (e.g., Amazon
Web Services S3, Rackspace Cloud Files). The [API documentation][cb_site]
uses the Bootstrap Theme with (mostly) the default options.

[![Django Cloud Browser][img_sbt_cb]][img_sbt_cb]
[img_sbt_cb]: {{ img_dir }}/sbt_cb.png

The only real tweak is setting `'source_link_position': "footer"` to move
the documentation source code link down from the navigation bar to the bottom
of each page.

## Navigation Menu Dropdowns

The navigation bar menus are now hierarchically arranged into dropdowns and
sub-menus for easier navigation. This looks a lot better than the previous
theme incarnations (which just used hacked-up CSS whitespace padding).

[![Navbar Menu Dropdowns][img_sbt_nav_dropdown_hl]][img_sbt_nav_dropdown_hl]
[img_sbt_nav_dropdown]: {{ img_dir }}/sbt_nav_dropdown.png
[img_sbt_nav_dropdown_hl]: {{ img_dir }}/sbt_nav_dropdown_hl.png

## Mobile UI Support

One of the most popular aspects of the Bootstrap library is its great support
for [responsive mobile design][bootstrap_resp]. These responsive features are
integrated into version 0.1.0 of the theme.

The Bootstrap Theme now renders a collapsed, clickable navigation bar in
smaller viewports (like a mobile phone and some tablet orientations). Viewing
the theme demo site in an iPhone gives us a slightly more terse UI.

[![Mobile Phone View][img_sbt_ios_th]][img_sbt_ios]
[img_sbt_ios_th]: {{ img_dir }}/sbt_ios_th.png
[img_sbt_ios]: {{ img_dir }}/sbt_ios.png

Clicking on the right navigation bar button gives us a basic first-level
dropdown menu.

[![Mobile Phone Navbar][img_sbt_ios_nav_hl_th]][img_sbt_ios_hl_nav]
[img_sbt_ios_nav_th]: {{ img_dir }}/sbt_ios_nav_th.png
[img_sbt_ios_nav]: {{ img_dir }}/sbt_ios_nav.png
[img_sbt_ios_nav_hl_th]: {{ img_dir }}/sbt_ios_nav_hl_th.png
[img_sbt_ios_nav_hl]: {{ img_dir }}/sbt_ios_hl_nav.png

And we can further click through sub-menus to navigate to the desired section
or page of a website.

[![Mobile Phone Navbar Menu][img_sbt_ios_nav_dropdown_hl_th]][img_sbt_ios_nav_dropdown_hl]
[img_sbt_ios_nav_dropdown_th]: {{ img_dir }}/sbt_ios_nav_dropdown_th.png
[img_sbt_ios_nav_dropdown]: {{ img_dir }}/sbt_ios_nav_dropdown.png
[img_sbt_ios_nav_dropdown_hl_th]: {{ img_dir }}/sbt_ios_nav_dropdown_hl_th.png
[img_sbt_ios_nav_dropdown_hl]: {{ img_dir }}/sbt_ios_nav_dropdown_hl.png

With these and other responsive Bootstrap features, the Sphinx Bootstrap Theme
now gives your API documentation or website real usability for mobile devices.

## Installation

The Bootstrap Theme supports installation via [download][sbt_downloads] as
detailed in my [previous blog post][sbt_lb_post_install] and now adds full
[PyPI][sbt_pypi] installation support as a Python package.

To get the theme package from PyPI, use `pip` to install it:

{% highlight bash %}
$ pip install sphinx_bootstrap_theme
{% endhighlight %}

Then, in your Sphinx "conf.py" configuration file, import the theme module
at the top:

{% highlight python %}
import sphinx_bootstrap_theme
{% endhighlight %}

We then use the module to get values for `html_theme_path` when we configure
the HTML theme later in "conf.py":

{% highlight python %}
# Activate the theme.
html_theme = 'bootstrap'
html_theme_path = sphinx_bootstrap_theme.get_html_theme_path()
{% endhighlight %}

And, that's pretty much it. The theme should now be available to Sphinx for
documentation building.

## Conclusion

The Bootstrap Theme brings Twitter Bootstrap to Sphinx sites and with version
0.1.0 adds even more useful Bootstrap features and options. So try it out,
see if Bootstrap is right for your Sphinx website, and please pass on any
feedback ([issue reports][sbt_issues], [pull requests][sbt_pull], etc.).


[bootstrap]: http://twitter.github.com/bootstrap/
[bootstrap_resp]: http://twitter.github.com/bootstrap/scaffolding.html#responsive
[python]: http://python.org/
[django]: https://www.djangoproject.com/
[sphinx]: http://sphinx.pocoo.org/
[twitter]: https://twitter.com/
[cb_gh]: http://ryan-roemer.github.com/django-cloud-browser/
[cb_site]: https://github.com/ryan-roemer/django-cloud-browser/
[sbt_lb_post]: http://loose-bits.com/2011/12/09/sphinx-twitter-bootstrap-theme.html
[sbt_lb_post_install]: http://loose-bits.com/2011/12/09/sphinx-twitter-bootstrap-theme.html#installation
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
