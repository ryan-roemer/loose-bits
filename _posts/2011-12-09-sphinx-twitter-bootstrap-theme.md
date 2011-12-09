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
available on GitHub. To show all of the coolness of bootstrap and Sphinx, I've
put up a simple [demo][sbt_demo] as well, which is just a skeleton site with
the readme file rendered as content.

Here is a a sneak peek:

[![Sphinx Bootstrap Theme Demo][img_sbt_teaser_th]][img_sbt_teaser]
[img_sbt_teaser_th]: {{ img_dir }}/sbt_teaser_thumb.png
[img_sbt_teaser]: {{ img_dir }}/sbt_teaser.png

<!-- more start -->

## Installation



[bootstrap]: http://twitter.github.com/bootstrap/
[sphinx]: http://sphinx.pocoo.org/
[python]: http://python.org/
[sbt_gh]: https://github.com/ryan-roemer/sphinx-bootstrap-theme
[sbt_demo]: http://ryan-roemer.github.com/sphinx-bootstrap-theme

<!-- more end -->
