---
layout: post
title:  Deck.js Starter
description: Deck.js is a framework for creating modern HTML presentations
  using JavaScript and CSS, with a rich theme and plugin ecosystem. Deck.js
  Starter is a collection of some various extensions and enhancements that I
  use for various slide decks.
date: 2012-11-05 10:00:00 UTC
tags: ['css', 'javascript', 'web', 'deck.js', 'design']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}


## Deck.js Starter

TODO - Outline

* Starter

  * Simple workflow
  * Easy templating with Jade, Markdown
  * Executable JS, CS
  * Extensible presentation platform.

* Deck.js introduction.

  * Demo
  * Docs
  * Core
  * Extensions
  * Themes

* Samples: NovaNode Cloud, Node.DC CoffeeScript used a precursor to this
  framework.

  * Publish to GitHub and host there (static site).

* New screenshot of DS demo screen (with link).

* Starter

  * Jade templates, with markdown filter.
    * Include build, watch, etc.
  * CodeMirror
    * JavaScript
    * CoffeeScript extensions

* Future
  * I plan to enhance this starter kit as I write future presentations.
  * More themes.

{% highlight javascript %}
// Set both readable and writable in constructor.
var NopStream = function () {
  this.readable = true;
  this.writable = true;
};

// Inherit from base stream class.
require('util').inherits(NopStream, require('stream'));

// Extract args to `write` and emit as `data` event.
NopStream.prototype.write = function () {
  args = Array.prototype.slice.call(arguments, 0);
  this.emit.apply(this, ['data'].concat(args))
};

// Extract args to `end` and emit as `end` event.
NopStream.prototype.end = function () {
  args = Array.prototype.slice.call(arguments, 0);
  this.emit.apply(this, ['end'].concat(args))
};
{% endhighlight %}


## Images

[![Deck.js Starter][img_ds_demo]][ds_demo]
[img_ds_demo]: {{ img_dir }}/deck_slides.png


<!-- more start -->

[deckjs]: http://imakewebthings.com/deck.js/
[deckjs_docs]: http://imakewebthings.com/deck.js/docs/
[deckjs_intro]: http://imakewebthings.com/deck.js/introduction
[ds_repo]: https://github.com/ryan-roemer/deck.js-starter
[ds_demo]: http://ryan-roemer.github.com/deck.js-starter

<!-- more end -->
