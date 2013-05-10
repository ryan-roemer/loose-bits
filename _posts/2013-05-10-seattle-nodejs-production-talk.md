---
layout: post
title:  Node.js in Production
description: Curiosity Media runs the world’s largest Spanish learning website,
  SpanishDict.com, backed by many Node.js applications. In a presentation to
  the May 8, 2013 Seattle Node.js meetup, I discuss the the good, the bad, and
  the ugly technical details of running Node.js services for over a year
  in production.
date: 2013-05-10 11:30:00 UTC
tags: ['node.js', 'production', 'seattle node.js', 'javascript', 'meetup']
---

## Node.js in Production

Curiosity Media runs the world’s largest Spanish learning website,
[SpanishDict.com](http://spanishdict.com), backed by many different
[Node.js][nodejs] applications. Since rolling out our first Node.js
applications over a year ago, we have collected a fair amount of good and
bad operational experiences.

I created a talk about our journey with Node.js for the
[Seattle Node.js Meetup][meetup] group's [May 8th, 2013 event][meetup_event].
My slides are available at the following locations:

* [**GitHub Site**](http://ryan-roemer.github.io/seanode-prod-talk/): A live,
  navigable [reveal.js](https://github.com/hakimel/reveal.js/) website.
  (*Note*: use the space bar to advance slides and arrow keys to navigate.)
* [**SlideShare**](http://www.slideshare.net/RyanRoemer/seanode-prodtalk): More
  traditional format, with download (PDF) links.

And, here's an embedded format:

<div class="embed">
  <iframe src="http://www.slideshare.net/slideshow/embed_code/20880870" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" allowfullscreen="allowfullscreen" webkitallowfullscreen="webkitallowfullscreen" mozallowfullscreen="mozallowfullscreen">&nbsp;</iframe>
</div>

<!-- more start -->

## Five Node.js Production Tips

My talk discussed the following five topics:

* **Know when to Node**: *Should* you use Node.js?
* **Keep up with Node**: Stay up to date with Node.js and libraries.
* **Design for failure**: Fail and recover at *multiple levels*.
* **Isolate services**: Separate *resource* and *failure* classes.
* **Analyze everything**: Data drives *problem discovery* and *action*.

There is, of course, much more to running Node.js in production, but hopefully
my talk and slides provide a bit of insight into some of the considerations
to keep in mind when taking a Node.js application to production.

[meetup]: http://www.meetup.com/Seattle-Node-js/
[meetup_event]: http://www.meetup.com/Seattle-Node-js/events/115959992/
[nodejs]: http://nodejs.org

<!-- more end -->
