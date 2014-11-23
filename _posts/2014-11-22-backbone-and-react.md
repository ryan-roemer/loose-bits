---
layout: post
title: "Backbone.js with React Views"
description:
  <em>Making JavaScript Tests Fast, Easy, &amp; Friendly</em> is a presentation
  I gave at CascasdiaJS 2014 that focuses on creating processes and environments
  that help developers actually write and run application tests.
tags: ['react', 'backbone.js', 'javascript']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

*Cross-posted from the
[Formidable Labs blog](http://formidablelabs.com/blog/2014/11/21/backbone-and-react/)*.

On Nov. 18, 2014, I presented a talk on
"[Backbone.js with React Views][talk_site]" at the inaugural
[Seattle ReactJS Meetup][seattle_react].

<div class="post-media">
  <div class="post-media-grid">
    <img class="post-media-col-1-2" src="{{ img_dir }}/backbone-logo.png" alt="" />
    <img class="post-media-col-1-2" src="{{ img_dir }}/react-logo.png" alt="" />
  </div>
</div>

## Backbone.js

[Backbone.js][bb] powers some of the largest web applications on the Internet and
we use the framework extensively at Formidable Labs. It provides simple and
flexible abstractions that developers can use to organize and create large-scale applications.

At the same time, Backbone.js application development runs in to complexities
with issues such as:

* Heavy handed DOM wiping and reflows.
* Preventing memory leaks and dreaded "[Zombie Views][zombies]".
* Composing and aggregating child views correctly.

## React

Enter [React][react]. React is a UI (view) layer for web applications that uses
virtual DOM rendering and a modular architecture for creating reusable, web
components. It offers some exciting new possibilities as a replacement for
Backbone.js views, while keeping the rest of the framework pieces that
Backbone.js does very well.

## Backbone.js with React!

In my talk, I walk through a simple application, "[Notes][notes]" (_live demo_),
that uses Backbone.js with React views. The full source is available from one
of our [GitHub repos](https://github.com/FormidableLabs/notes-react-exoskeleton).

<!-- more start -->

The talk [slides][talk_site] go in to more detail, but some of the interesting
results we get with a React-based view layer include:

* A slimmer overall minified bundle. With React as the view layer, we can remove
  dependencies on jQuery and Underscore.js.
* Server-side rendering. This is a **huge** feature, and actually quite easy
  with React. Even better, if you have a single-page JavaScript application
  for your site, React can _bootstrap_ the HTML of the page server-side and then
  startup the app without re-rendering _any_ HTML!
* ... and some other pretty cool stuff!

To dive into the talk, hop on over to the [presentation website][talk_site].
Or, for the more traditional folks, the talk
[SlideShare deck][talk_slides] is available (with downloadable PDF).

<div class="embed embed-slides">
  <iframe src="//www.slideshare.net/slideshow/embed_code/41777786"
        class="slideshare"
        width="512" height="421" frameborder="0" marginwidth="0" marginheight="0"
        scrolling="no"
        allowfullscreen></iframe>
</div>

[talk_site]: http://slides.formidablelabs.com/201411-react-backbone.html
[talk_slides]: http://www.slideshare.net/RyanRoemer/backbonejs-with-react-views-server-rendering-virtual-dom-and-more
[seattle_react]: http://www.meetup.com/seattle-react-js/events/216736502/
[zombies]: http://lostechies.com/derickbailey/2011/09/15/zombies-run-managing-page-transitions-in-backbone-apps/
[bb]: http://backbonejs.org/
[react]: http://facebook.github.io/react/
[notes]: http://formidablelabs.github.io/notes-react-exoskeleton/app.html
[repo]: https://github.com/FormidableLabs/notes-react-exoskeleton

<!-- more end -->