---
layout: post
title: Async.js Presentation for Joint Node.DC / DC jQuery Meetup
description: Async.js is a control flow library for Node.js and the browser.
  I gave the following presentation to the Feb. 20, 2012 joint meetup for
  Node.DC and DC jQuery.
date: 2012-02-21 20:54:38 UTC
tags: ['node.js', 'async.js', 'javascript', 'control flow', 'concurrency']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

## Async.js, a JavaScript Control Flow Library

On February 20, 2012, I gave a talk on [Async.js][asyncjs] to the joint
meetup of [Node.DC][node_dc] and [DC jQuery][dcjq].

Async.js is a control flow library that provides great abstractions for writing
serial, parallel, and combined asynchronous code without ending up in the
dreaded trenches of nested callback insanity.

[![Async.js presentation][img_pres]][pres]
[img_pres]: {{ img_dir }}/async-talk.png

My [presentation][pres] is available live on GitHub, and uses
[Impress.js][impress] for [Prezi][prezi]-like functionality in the browser.
As a consequence, it might not render in older browsers and IE. My talk covers
the basic abstractions:

* Series
* Waterfalls
* Parallel
* Collections

and more, so check it out and feel free to ping me with any questions or
comments!

[asyncjs]: https://github.com/caolan/async
[node_dc]: http://www.meetup.com/node-dc/events/49905452/
[dcjq]: http://www.meetup.com/DC-jQuery-Users-Group/events/51798912/
[pres]: http://ryan-roemer.github.com/nodedc-async-talk/#/title
[impress]: http://bartaz.github.com/impress.js
[presi]: http://prezi.com/
