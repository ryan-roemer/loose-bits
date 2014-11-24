---
layout: post
title: Getting Started with Node.js in the Cloud - Presentation
description: On March 20, 2012, we launched the NovaNode meetup with two talks.
  I gave a short talk on deploying Node.js applications to the cloud. I have
  now placed my presentation and demo source code online.
date: 2012-03-24 22:08:21 UTC
tags: ['node.js', 'cloud', 'heroku', 'nova node', 'meetup']
---
{% capture img_dir %}{{ site.url }}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

## Getting Started with Node.js in the Cloud

[NovaNode][meetup] had its [first meetup event][meetup_event] on March 20, 2012
at [SpanishDict][sd]'s offices. I gave a talk titled
"Getting Started with Node.js in the Cloud" covering Node.js application
development and deployment to the cloud.

[![Node.js cloud presentation][img_pres]][pres]
[img_pres]: {{ img_dir }}/nodejs-cloud.png

My talk goes through a first simple "hello world" application and builds up to
a realtime chat application using Redis and websockets. We deploy the
applications to [Heroku][heroku] and cover everything from logs and monitoring
to add-on services and scaling. The talk concludes with an assessment and use
cases for deploying on a Platform-as-a-Service provider like Heroku versus an
Infrastructure-as-a-Service provider like [Amazon Web Services][aws].

The [presentation][pres] is available live on GitHub, and uses the
[deck.js][deck] presentation framework. I have also posted the full demo
[source code][source] to GitHub, including the chat server that we used
during the meetup. Try it out!

[pres]: http://ryan-roemer.github.com/novanode-cloud-talk/
[deck]: http://imakewebthings.com/deck.js/
[heroku]: http://www.heroku.com/
[aws]: http://aws.amazon.com/
[sd]: http://spanishdict.com/
[nodejs]: http://nodejs.org/
[meetup_event]: http://www.meetup.com/Nova-Node/events/52749282/
[meetup]: http://www.meetup.com/Nova-Node
[source]: https://github.com/ryan-roemer/novanode-cloud-talk/
