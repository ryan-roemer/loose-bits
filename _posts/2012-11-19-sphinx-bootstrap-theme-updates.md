---
layout: post
title: Sphinx Bootstrap Theme Updates - Mobile, Dropdowns, and More
description: The "spinx-bootstrap-theme" plugin enables Twitter
  Bootstrap integration with Sphinx documentation. Version 0.1.0 adds an array
  of new features including responsive (mobile-friendly) design, better
  dropdown navigation menu support, deployment from the PyPI repository and
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
document my open source Python projects and we use theme for all internal
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

## New Theme Options

* Cloud Browser
* Basic Demo Site

[![Sphinx Bootstrap Theme Desktop View][img_sbt_desk]][img_sbt_desk]
[img_sbt_desk]: {{ img_dir }}/sbt_desk.png

[![Django Cloud Browser][img_sbt_cb]][img_sbt_cb]
[img_sbt_cb]: {{ img_dir }}/sbt_cb.png

<!-- more start -->

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
[sbt_lb_post]: http://loose-bits.com/2011/12/09/sphinx-twitter-bootstrap-theme.html
[sbt_demo]: http://ryan-roemer.github.com/sphinx-bootstrap-theme
[sbt_demo_readme]: http://ryan-roemer.github.com/sphinx-bootstrap-theme/README.html
[sbt_downloads]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/downloads
[sbt_gh]: https://github.com/ryan-roemer/sphinx-bootstrap-theme
[sbt_issues]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/issues
[sbt_pull]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/pulls
[sbt_readme]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/blob/master/README.rst
[sbt_pypi]: http://pypi.python.org/pypi/sphinx-bootstrap-theme
[sbt_zip]: https://github.com/downloads/ryan-roemer/sphinx-bootstrap-theme/bootstrap.zip
[sphinx]: http://sphinx.pocoo.org/
[twitter]: https://twitter.com/

<!-- more end -->
