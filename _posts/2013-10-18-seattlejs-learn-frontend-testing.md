---
layout: post
title:  Learn Frontend Testing
description: I lead an Oct. 16, 2013 workshop on testing frontend JavaScript
  applications for the SeattleJS meetup. My presentation covered the basics
  of test development and architecture using Mocha, Chai, Sinon.JS and
  PhantomJS.
tags: ['testing', 'seattlejs', 'javascript', 'meetup']
---

## Learn Frontend Testing

As a part of [Formidable Labs'][fmd] series of development education events, I
led a "[Learn Frontend Testing][meetup_event]" workshop on Oct. 16, 2013 for
the [SeattleJS][meetup] meetup group. My slides are available at the following
locations:

* [**Web Presentation**](http://formidablelabs.github.com/learn-frontend-testing/): A live,
  navigable [reveal.js](https://github.com/hakimel/reveal.js/) website.
  (*Note*: use the space bar to advance slides and arrow keys to navigate.)
* [**PDF**](http://formidablelabs.github.com/learn-frontend-testing/learn-frontend-testing.pdf):
  A download-able PDF.

And, here's an embedded format:

<div class="embed">
  <iframe src="http://www.slideshare.net/slideshow/embed_code/27309486" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" allowfullscreen="allowfullscreen" webkitallowfullscreen="webkitallowfullscreen" mozallowfullscreen="mozallowfullscreen">&nbsp;</iframe>
</div>

<!-- more start -->

## Workshop Topics

My presentation walks through testing some very basic JavaScript application
code in the following steps:

* Install all of the necessary test libraries and create a test driver HTML page
  to hook up the application libraries and run the whole test harness.
* Create Mocha suites and tests.
* Write assertions to verify application behavior with Chai.
* Spy and stub out application behavior with Sinon.JS.
* Automate all of our tests with PhantomJS to run them from the command line
  without a web browser.

The test stack the presentation uses is:

* **[Mocha](http://visionmedia.github.com/mocha/)**: Test framework for
  organizing and running our tests.
* **[Chai](http://chaijs.com/)**: Natural language-focused test assertion
  library.
* **[Sinon.JS](http://sinonjs.org/)**: Test fake library providing spies
  and stubs for observing and mutating application behavior during tests.

The test concepts and technology stack is the same one I use in my book,
**[Backbone.js Testing][book_packt]**. You can see the additional test samples
beyond those contained in the presentation at:
[http://backbone-testing.com/](http://backbone-testing.com/).

## Try it Out!

All of the source code for the presentation (include our finished tests) is
available at the workshop's
[GitHub repo](https://github.com/FormidableLabs/learn-frontend-testing)
and can be installed using git:

{% highlight text %}
$ git clone https://github.com/FormidableLabs/learn-frontend-testing.git
{% endhighlight %}

[fmd]: http://formidablelabs.com/
[meetup]: http://www.meetup.com/seattlejs/
[meetup_event]: http://www.meetup.com/seattlejs/events/139993642/
[book_packt]: http://www.packtpub.com/backbonejs-testing/book

<!-- more end -->
