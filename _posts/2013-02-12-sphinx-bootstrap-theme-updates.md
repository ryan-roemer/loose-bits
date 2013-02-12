---
layout: post
title: Sphinx Bootstrap Theme 0.1.6 - Bootstrap and Other Updates
description: The "spinx-bootstrap-theme" plugin integrates Twitter
  Bootstrap with the Sphinx documentation tool. Version 0.1.6 is the latest
  upgrade with a new Bootstrap version, various fixes and many UI improvements.
date: 2013-02-12 11:30:00 UTC
tags: ['python', 'sphinx', 'theme', 'twitter', 'bootstrap']
---

## Sphinx Bootstrap Theme

The [Sphinx Bootstrap Theme][sbt_gh] is an extension for the [Sphinx][sphinx]
documentation tool, used for [Python][python]-based API documentation and
static website authoring. The theme integrates [Twitter][twitter]
[Bootstrap][bootstrap], which is a wildly popular frontend framework. The
[theme GitHub project][sbt_gh] provides a [demonstration site][sbt_demo_readme]
using the theme.

The theme project continues to move along, and as it has been a while since my
[last update post][sbt_lb_post], here are some of the changes in version
[0.1.6][sbt_pypi] (since 0.1.0):

* Update to Bootstrap v2.3.0.
* Enable configuration of the depth of the Global TOC ("Site" tab).
* Add footer divider and various other styling tweaks.
* Add Bootstrap styling for tables and inline code snippets

In addition, much of the underlying rendering JavaScript code has been
revised. For example, Twitter Bootstrap v2.3.0 handles behavior like dropdown
menu clicks in mobile much better than previous versions, enabling removal of
some hacks and patches in the theme.

<!-- more start -->

## Theme Options

Here is the current list of options you can set for the theme in the "conf.py"
configuration file, as used by the demo site in "[conf.py][sbt_demo_cfg]":

{% highlight python %}
html_theme_options = {
    # Global TOC depth for "site" navbar tab. (Default: 1)
    # Switching to -1 shows all levels.
    'globaltoc_depth': 2,

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

[bootstrap]: http://twitter.github.com/bootstrap/
[python]: http://python.org/
[sphinx]: http://sphinx.pocoo.org/
[twitter]: https://twitter.com/
[sbt_lb_post]: http://loose-bits.com/2012/11/19/sphinx-bootstrap-theme-updates.html
[sbt_demo]: http://ryan-roemer.github.com/sphinx-bootstrap-theme
[sbt_demo_cfg]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/blob/master/demo/source/conf.py
[sbt_demo_readme]: http://ryan-roemer.github.com/sphinx-bootstrap-theme/README.html
[sbt_pypi]: http://pypi.python.org/pypi/sphinx-bootstrap-theme/0.1.6
[sbt_gh]: https://github.com/ryan-roemer/sphinx-bootstrap-theme

<!-- more end -->
