---
layout: post
title:  5 Things I Like About CoffeeScript
description: CoffeeScript is programming language that compiles to JavaScript.
  I gave a short survey talk about a few CoffeeScript features that I really
  like to the August 15, 2012 Node.DC meetup.
date: 2012-08-16 11:30:00 UTC
tags: ['node.js', 'coffeescript', 'javascript', 'meetup']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

## CoffeeScript

[CoffeeScript][cs] is self-described as "a little language that compiles into
JavaScript". CoffeeScript implements a subset of the full JavaScript language
and adds a little bit of common boilerplate code to take out some of the
less savory parts of JavaScript. CoffeeScript works both in [Node.js][nodejs]
on the backend, as well as in the browser.

I gave a short survey talk at the August 15, 2012 [Node.DC][node_dc] meetup,
"5 Things I Like About CoffeeScript".

[![CoffeeScript Talk][img_talk]][cs_talk]
[img_talk]: {{ img_dir }}/nodedc-coffeescript.png

The talk's [source][cs_source] is available on GitHub, and uses the
awesome [deck.js][deck] presentation framework with the
[CodeMirror plugin][deck_cm] to enable editable and runnable code samples. I
further hacked up the CodeMirror plugin to additionally make the CoffeeScript
code examples executable (CodeMirror only does JavaScript by default).

<!-- more start -->

## Five Cool Things in CoffeeScript

For the impatient, the five topics I covered are:

1. Syntax
2. Functions
3. Classes
4. Existential Operator
5. Loops, Comprehensions

The talk just skims the surface of the powerful (yet slim) CoffeeScript
language. For further reading / real introductory tutorials, I would suggest:

* [CoffeeScript Documentation][cs]: The official API.
* [The CoffeeScript Cookbook][cs_cook]: Lots of "recipes" for common
  programming problems and projects.
* [Smooth Coffeescript][smooth]: Interactive online eBook with live
  code execution and editing.

[cs]: http://coffeescript.org/
[cs_cook]: http://coffeescriptcookbook.com/
[cs_talk]: http://ryan-roemer.github.com/nodedc-coffeescript-talk/
[cs_source]: https://github.com/ryan-roemer/nodedc-coffeescript-talk/
[deck]: http://imakewebthings.com/deck.js/
[deck_cm]: https://github.com/iros/deck.js-codemirror
[node_dc]: http://www.meetup.com/node-dc/events/73746422/
[nodejs]: http://nodejs.org
[smooth]: http://autotelicum.github.com/Smooth-CoffeeScript/

<!-- more end -->
