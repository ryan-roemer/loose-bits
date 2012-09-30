---
layout: post
title:  Responsive Web Design with Twitter Bootstrap
description: Bootstrap is a front-end web framework for fast, intuitive and
  consistent web design. Loose Bits recently transitioned over to Bootstrap
  from an ad-hoc collection of frameworks and utilities, and now has a unified,
  responsive experience on web, tablet and mobile platforms.
date: 2012-09-30 18:37:07 UTC
tags: ['css', 'javascript', 'web', 'mobile', 'bootstrap']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

## Bootstrap

Twitter's [Bootstrap][bootstrap] libraries is one of the most popular front-end
frameworks, with an amazing adoption rate by various web sites, from small
to large.  Bootstrap provides:

* **Responsive Features**: Enables seamless transitions between desktop, tablet,
  and mobile view sizes, with intuitive look-and-feel switching and custom
  single-view overrides.
* **Layout Support**: Fixed and fluid grid systems for web design.
* **Style Components**: Really nice looking form helpers, fonts, tables, etc.
* **UI Components**: Dropdown menus, buttons, accordions, alerts, progress bars
  and more, with JavaScript support.

Essentially, Bootstrap makes it easy to design a responsive website (that looks
good in desktop or mobile views) and add user interface components that keep
with the overall user experience.

## Moving Loose Bits to Bootstrap

Loose Bits (this blog) previously had a non-responsive design -- the main
heading bar was far too wide when viewed on a mobile phone (like my iPhone).
I had been itching to make this site mobile-friendly, and finally decided to
bite the bullet and intergrate Bootstrap.

I downloaded the [full bootstrap build][build] from source, so that I could
customize parts of the framework and only add in what I needed. As this blog
is hosted as an open source project on [GitHub][github], you can actually
view / download all of the work at my [loose-bits][lb_repo].

<!-- more start -->

While I did customize some colors and variables for Bootstrap and did spend
some time insert Bootstrap-compatible CSS classes in my HTML layout, I have
to say the overall experience was quite easy, and I'm pleased with the
final results.

You can view the different layout effects for different viewports simply by
resizing your browser window (assuming you are on a desktop). But, the gist
of the big changes are that in desktop view, here is the main header and an
article title:

<div class="pull-center">
  <img class="bordered" src="{{ img_dir }}/desktop.png" />
  <p />
</div>

I've used the basic "inverse" (dark) theme and use the fantastic
[Font Awesome][font_awesome] icons for each navigation bar menu item.

## Loose Bits on Mobile!

Getting on to the "mobile" aspect, if you resize the page, then the menu will
adjust the look and feel and change into a mobile mode. So, resizing the window
down to mobile phone size (or if you are already viewing the site on a mobile
phone), we get:

<div class="pull-center">
  <img class="bordered" src="{{ img_dir }}/mobile.png" />
  <p />
</div>

I've used the simple navigation collapse feature to have a clickable menu of
all of the previous navigation bar items, so as to more effectively use the
reduced real estate in a mobile view:

<div class="pull-center">
  <img class="bordered" src="{{ img_dir }}/mobile-menu.png" />
  <p />
</div>

The rest of the site has a few other adjustments in mobile view mode. Overall,
Bootstrap, mostly just works in the different views and I'm pretty happy with
the end result.

However, like any web framework under active development, there are still a few
kinks that I'm working out (mostly in JavaScript land - like buttons
disappearing), and you do sacrifice some browser compatibility. Ultimately, for
anyone looking at the fastest path to reliable and intuitive responsive web
site, I would definitely recommend looking at Twitter Bootstrap.



[bootstrap]: http://twitter.github.com/bootstrap/
[build]: https://github.com/twitter/bootstrap
[github]: http://github.com
[lb_repo]: https://github.com/ryan-roemer/loose-bits
[font_awesome]: http://fortawesome.github.com/Font-Awesome/

<!-- more end -->
