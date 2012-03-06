---
layout: post
title: NovaNode Inaugural Meetup - Getting Started with Node.js in the Cloud
description: We're kicking off the new NovaNode - Northern Virginia Node.js -
  meetup on March 20 with two talks. My talk will focus on rapid application
  development and deployment to the cloud. Come learn how to create and scale
  your asynchronous web applications!
date: 2012-03-06 15:01:00 UTC
tags: ['node.js', 'nova node', 'cloud', 'meetup']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}
{% capture nova_node %}http://www.meetup.com/Nova-Node/{% endcapture %}

## Node.js in NoVA!

We recently launched the [NovaNode meetup][meetup] group focusing on the
[Node.js][nodejs] event-driven JavaScript framework. We have a great set
of talks lined up for our [inaugural meetup event][meetup_event] on March 20,
2012 at 6:30 pm. We're hosting things at [SpanishDict][sd]'s offices in
Arlington, VA near the Clarendon metro stop.

<div class="image">
  <a href="{{ nova_node }}"><img alt="Nova Node"
    src="{{ img_dir }}/nova_node.png" /></a>
</div>

Our talks are:

* **"Getting Started with Node.js in the Cloud"**, which I'll present.
* **"Everyauth: OAuth for Busy Nerds"** by Jason Bond Pratt, Co-founder of
  [Tixelated][tixelated]. OAuth is the standard interface for web services
  integration for user authentication, and is your starting point for linking
  an application to Google, Facebook, Twitter, etc. Jason's talk will take
  us through Everyauth's basic architecture and integration with other data
  stores like MongoDB.

## Getting Started with Node.js in the Cloud

Node.js provides a solid platform for scalable and responsive web applications.
Development in Node.js further has a lower learning curve compared to many
highly-concurrent / asynchronous frameworks as it uses JavaScript, which is
very familiar territory for web developers.

The cloud complements Node.js by providing the means to deploy applications
rapidly and scale up with no upfront investment costs. The "big" cloud
providers such as [Amazon Web Services][aws] and [Rackspace][rs] easily support
an infrastructures for hosting Node.js applications. Moreover, there has
been a burst of Platform-as-a-Service contenders that provide even easier
Node.js application hosting, including: [Heroku][heroku],
[NodeJitsu][nodejitsu] and even Microsoft's [Azure][azure] platform.

In my talk, I'll walk through a basic Node.js application that we develop,
deploy and then scale easily in the cloud. I'll discuss best practices and
what opportunities and pitfalls lie ahead when taking your Node.js applications
to the cloud.

[nodejitsu]: http://nodejitsu.com/
[heroku]: http://www.heroku.com/
[aws]: http://aws.amazon.com/
[rs]: http://www.rackspace.com/cloud/
[azure]: http://www.windowsazure.com/en-us/develop/nodejs/
[sd]: http://spanishdict.com/
[nodejs]: http://nodejs.org/
[meetup_event]: http://www.meetup.com/Nova-Node/events/52749282/
[tixelated]: http://launch.tixelated.com/
[meetup]: {{ nova_node }}
