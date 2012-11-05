---
layout: post
title:  Deck.js Starter
description: Deck.js is a framework for creating modern HTML presentations
  using JavaScript and CSS, with a rich theme and plugin ecosystem. Deck.js
  Starter is a collection of some various extensions and enhancements that I
  use for various slide decks.
date: 2012-11-05 10:00:00 UTC
tags: ['css', 'javascript', 'web', 'html', 'deck.js', 'presentation']
---
{% capture img_base %}{{ site.baseurl }}media/img/{% endcapture %}
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

## Deck.js Starter

[Deck.js][deckjs] is a modern presentation framework for creating interactive
HTML-based interactive slide decks. The framework provides:

* A basic boilerplate.
* CSS themes.
* Extensions including a menu, "go to" button, transitions, etc.

To create a presentation, simply edit the HTML files and host a static website
and you have an auto-magic slide deck, available to the world.

I have now done a couple of deck.js-based presentations, and find it
incredibly useful, but noticed I was re-implementing the same scaffolding
enhancements. I wrapped up these common enhancements in a GitHub project,
[Deck.js Starter][ds_repo]. The notable enhancements the starter kit has are:

* [Jade templates][jade] with [Markdown][md] support for faster slide authoring.
* Executable JavaScript code snippets using [CodeMirror][cm].
* Executable CoffeeScript code snippets via some specific tweaks I made to
  the [CodeMirror deck.js extension][cm_deck].

Essentially, you can download and install the starter kit, and just start
authoring new slides. The starting deck provides a short demo and is available
at:

[![Deck.js Starter][img_ds_demo]][ds_demo]
[img_ds_demo]: {{ img_dir }}/deck_slides.png

<!-- more start -->

## Deck.js Introduction

Getting up to speed [deck.js][deckjs] is pretty straightforward: check out
a [tutorial / exemplary demo][deckjs_intro] or dive right into the
[docs][deckjs_docs] or [wiki][deckjs_wiki]. After the basics are mastered,
there are plenty of avenues for further exploration / additions:

* **Themes**: Deck.js includes three by default and there are several more
  available as open source projects.
* **Extensions**: Deck.js includes a menu, navigation and other controls by
  default. There is a fantastic open source ecosystem around deck providing
  all manner of additional extensions. To review a few:

  * Remote control a presentation.
  * Add a laser pointer to the presentation online.
  * Easy "presenter" views.
  * ... and many more!

* **Tools**: Several open source projects offer meta-level enhancements like
  markdown support, etc.

## Working with Deck.js

I have used deck for two of my presentations to date. My basic workflow was to
fork the repository from GitHub, then make my edits and add in extensions.
Finally, I pushed the static web project to GitHub Pages for free hosting.

For a better sense of what the end products look like, here are the two live
presentation decks.

### Getting Started with Node.js in the Cloud

My talk to the Nova Node meetup on using Node.js in the cloud.

[![Node.js cloud presentation][img_pres]][cloud_talk]
[img_pres]: {{ img_base }}/2012/03/24/nodejs-cloud.png

### 5 Things I Like About CoffeeScript

A simple CoffeeScript survey I presented at the Node.DC meetup.

[![CoffeeScript Talk][img_talk]][cs_talk]
[img_talk]: {{ img_base }}/2012/08/16/nodedc-coffeescript.png

## A Starter Kit

After writing these presentations and looking to my next one, I realized I was
writing the same boilerplate again, and decided to finally wrap everything up
in a concise, opinionated starting point: [Deck.js Starter][ds_repo]

To get started, checkout the [online demo][ds_demo], and then review the
[README][ds_readme]. The "tl;dr" version is:

First, clone the repository:

    $ git clone https://github.com/ryan-roemer/deck.js-starter.git my-presentation

Next, make sure Node.js is installed, and install all the necessary support
packages.

    $ cd my-presentation
    $ npm install

Once you are ready to author, start the "watch" task that will automatically
build "[layout.jade][ds_layout]" and "[index.jade][ds_index]" into the
"index.html" static page. You can then preview your slide deck at "index.html":

    $ npm run-script watch

Authoring is pretty easy. To add themes, extensions, or extra scripts, edit
"layout.jade". For slides, edit "index.jade" and add `section.slide`
elements following the boilerplate as a guide. Make sure to take a look at
the following possibilities:

**Executable JavaScript**:

[![Deck.js Starter][img_js_demo]][ds_demo_js]
[img_js_demo]: {{ img_dir }}/deck_js.png

**Executable CoffeeScript**:

[![Deck.js Starter][img_cs_demo]][ds_demo_cs]
[img_cs_demo]: {{ img_dir }}/deck_cs.png

After exploring the basics of the starter kit, feel free to add in any other
Deck.js extensions or other useful components or tweaks. You'll end up with
an interactive, visually appealing presentation that you can easily author and
host online.

As a parting thought, the Deck.js Starter was written in a couple of hours over
the weekend. I do plan to enhance it as I author real presentations in the
future (particularly with an eye towards adding more themes). But any
feedback or enhancements are most welcome.

[cloud_talk]: http://ryan-roemer.github.com/novanode-cloud-talk/
[cs_talk]: http://ryan-roemer.github.com/nodedc-coffeescript-talk/
[cm]: http://codemirror.net/
[cm_deck]: https://github.com/iros/deck.js-codemirror
[deckjs]: http://imakewebthings.com/deck.js/
[deckjs_docs]: http://imakewebthings.com/deck.js/docs/
[deckjs_intro]: http://imakewebthings.com/deck.js/introduction
[deckjs_wiki]: https://github.com/imakewebthings/deck.js/wiki
[ds_repo]: https://github.com/ryan-roemer/deck.js-starter
[ds_demo]: http://ryan-roemer.github.com/deck.js-starter
[ds_demo_js]: http://ryan-roemer.github.com/deck.js-starter/#js
[ds_demo_cs]: http://ryan-roemer.github.com/deck.js-starter/#cs
[ds_readme]: https://github.com/ryan-roemer/deck.js-starter/blob/master/README.md
[ds_index]: https://github.com/ryan-roemer/deck.js-starter/blob/master/index.jade
[ds_layout]: https://github.com/ryan-roemer/deck.js-starter/blob/master/layout.jade
[jade]: http://jade-lang.com
[md]: http://daringfireball.net/projects/markdown/

<!-- more end -->
