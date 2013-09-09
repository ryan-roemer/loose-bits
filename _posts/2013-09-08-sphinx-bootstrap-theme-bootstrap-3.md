---
layout: post
title: Sphinx Bootstrap Theme 0.3.0 - Bootstrap v3 and more!
description: The "spinx-bootstrap-theme" integrates Twitter
  Bootstrap with Python Sphinx. Version 0.3.0 adds support for
  Bootstrap 3 and many new other additions.
date: 2013-09-08 11:30:00 UTC
tags: ['python', 'sphinx', 'theme', 'twitter', 'bootstrap']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

## Bootstrap v3 comes to Sphinx

The [Bootstrap Theme][sbt_gh] for [Sphinx][sphinx] has hit a new milestone with
version 0.3.0, bringing in version 3.0.0 of the [Twitter][twitter]
[Bootstrap][bootstrap] library.

A lot has changed since the last [v0.2.0 blog post][v0.2.0_post], the most
conspicuous being that you can now specify to use either Bootstrap v2.3.2
or v3.0.0 via the theme options:

{% highlight python %}
html_theme_options: {
    # Choose Bootstrap version.
    # Values: "3" (default) or "2" (in quotes)
    'bootstrap_version': "3",
}
{% endhighlight %}

Thanks to the awesome work by [MiCHiLU](https://github.com/MiCHiLU), the
Sphinx Bootstrap Theme can easily switch between Bootstrap v2.x and v3.x
with full support for all of the features, including
[Bootswatch][bootswatch] CSS extensions!

<!-- more start -->

## Changes: v0.2.0 - v0.3.0

It's been a while since I have posted updates to the theme, so here is the
laundry list of all of the goodness added to the theme since my last blog
post.

### v0.3.0
* Add Bootstrap v3.0.0 with legacy option for v2.3.2. ([@MiCHiLU][@MiCHiLU])

### v0.2.9
* Add `navbar_links` theme option. ([@newgene][@newgene])
* Add `navbarextra` block in "layout.html". ([@grncdr][@grncdr])

### v0.2.8
* Sphinx compatible Sidebars. ([@russell][@russell])
* Topnav sidebarrel can now be disabled. ([@russell][@russell])
* Topnav page nav menu can now be disabled. ([@russell][@russell])

### v0.2.7
* Add custom nav bar links. ([@russell][@russell])
* Fix wrapping of line numbers in code includes. ([@russell][@russell])
* Truncate long page titles in navigation bar. ([@aababilov][@aababilov])

### v0.2.6
* Use network path for Bootswatch ([@nail][@nail])
* Switch from distribute to setuptools. (Suggested by [@thedrow][@thedrow])

### v0.2.5
* Search page styling. ([@russell][@russell])

### v0.2.4
* Adjust the max width of field lists. ([@russell][@russell])
* Update to Bootstrap v2.3.2.
* Navbar search box now uses bootstrap search-query class. ([@russell][@russell])
* Field-list tables now have an inherited width. ([@russell][@russell])

### v0.2.3
* Put navbar within a `container`. ([@inducer][@inducer])
* Add `navbar_site_name` for renaming site nav. tab. (Suggested by [@inducer][@inducer])

### v0.2.2
* Better literal markup handling for Bootstrap code formatting. ([@russell][@russell])
* Scroll window when jumping to an anchor. ([@russell][@russell])

### v0.2.1
* Fix code styling collision for cross references and inline code blocks.
  ([@russell][@russell])

## Happy Theming

I've been humbled and excited by all of the great community work on the theme,
adding much needed functionality and flexibility for adding Bootstrap's
awesomeness to your Sphinx documentation. Please keep the
[pull requests](https://github.com/ryan-roemer/sphinx-bootstrap-theme/pulls)
coming and help us continue to develop the friendship between Bootstrap
and Sphinx!

[bootstrap]: http://twitter.github.com/bootstrap/
[bootswatch]: http://bootswatch.com/
[python]: http://python.org/
[sphinx]: http://sphinx.pocoo.org/
[twitter]: https://twitter.com/
[sbt_demo]: http://ryan-roemer.github.com/sphinx-bootstrap-theme
[sbt_demo_cfg]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/blob/master/demo/source/conf.py
[sbt_demo_readme]: http://ryan-roemer.github.com/sphinx-bootstrap-theme/README.html
[sbt_pypi]: http://pypi.python.org/pypi/sphinx-bootstrap-theme/0.2.0
[sbt_gh]: https://github.com/ryan-roemer/sphinx-bootstrap-theme
[v0.2.0_post]: /2013/04/10/sphinx-bootstrap-theme-bootswatch.html

[@aababilov]: https://github.com/aababilov
[@grncdr]: https://github.com/grncdr
[@inducer]: https://github.com/inducer
[@MiCHiLU]: https://github.com/MiCHiLU
[@nail]: https://github.com/nail
[@newgene]: https://github.com/newgene
[@oscarcp]: https://github.com/oscarcp
[@russell]: https://github.com/russell
[@thedrow]: https://github.com/thedrow
[@zyga]: https://github.com/zyga

<!-- more end -->
