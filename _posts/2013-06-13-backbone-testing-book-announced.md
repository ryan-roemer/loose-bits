---
layout: post
title:  Book Announcement - Backbone.js Testing
description: Backbone.js Testing is a forthcoming book that covers all aspects
  of test development for Backbone.js application with practical examples using
  the Mocha, Chai and Sinon.JS libraries. The book's current publication date
  is set for late June 2013.
date: 2013-06-13 11:30:00 UTC
tags: ['javascript', 'backbone.js', 'testing', 'mocha', 'chai', 'sinon']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

## Backbone.js Testing Book

I am very pleased to announce that I am in the last stages of publishing
**[Backbone.js Testing][packt]** - a book on [Backbone.js][backbone] test
architecture and development due in final form around the end of June.

<div class="pull-center">
  <a href="http://www.packtpub.com/backbonejs-testing/book">
    <img class="bordered"
         alt="Backbone.js Testing"
         title="Backbone.js Testing"
         src="{{ img_dir }}/book-cover.jpg" />
  </a>
  <p />
</div>

A brief abstract of the book's content is available from the
[Packt Publishing][packtpub] [website][packt]:

> Frontend web applications are soaring in popularity and the
> Backbone.js library is leading this charge with a modular,
> lightweight approach for organizing JavaScript web applications. At
> the same time, testing client-side JavaScript and Backbone.js
> programs remains a difficult and tedious undertaking.
>
> Backbone.js Testing brings sensible practices and current techniques
> to the challenges of Backbone.js test development. The book
> introduces fundamental testing concepts, comprehensive test
> infrastructure design, and practical exercises to easily and
> systematically test modern JavaScript web applications.
>
> The book progresses from Mocha test suites and Chai assertions to
> advanced test mocks and stubs with Sinon.JS. The requisite libraries
> and utilities are introduced with in-depth examples and best
> practices for integration with your applications. The book guides
> you through the test planning and implementation processes for your
> application models, views, routers, and other Backbone.js
> components.
>
> Backbone.js Testing gives you the tools, examples, and assistance to
> test your Backbone.js web applications thoroughly, quickly, and with
> confidence.

To provide a better idea of the book's structure, the tentative chapter titles
are as follows:

1. Setting up a Test Infrastructure
2. Creating a Backbone.js Application Test Plan
3. Test Assertions, Specs, and Suites
4. Test Spies
5. Test Stubs and Mocks
6. Automated Web Testing

All of the code examples in the book are provided online at the website
[backbone-testing.com](http://backbone-testing.com) and as an open source
[GitHub repository](https://github.com/ryan-roemer/backbone-testing).

<!-- more start -->

## The Road to my First Book

Application testing is difficult, and frontend JavaScript testing can often be
a downright nightmare. After years of working through difficulties in frontend
testing practices and technologies, I have gained a lot of experience through
the various trials and tribulations bringing me to my current role in
architecting (and testing) large Backbone.js applications.

[Packt Publishing][packtpub] approached me towards the end of last year about
authoring a book on the subject and I signed on. My hope with the project is
that I will be able to provide a resource to reduce the pain in frontend tests
with a structured programming guide and practical examples using
various (exciting and interesting) modern testing libraries.

It has been a stressful,
hectic, and wonderful experience writing the book, and I'm really looking
forward to completing the project. And, I will be happy to be able to reclaim
my nights and weekends that have been devoted to the book over the past
couple of months.

After the book is published, I plan on writing a series of posts about
authoring a technical book, with all of the ups and downs that the process
entails. In the meantime, I just have to proof each chapter one final time and
it should be off to the presses, so to speak!

[backbone]: http://backbonejs.org/
[packtpub]: http://www.packtpub.com/
[packt]: http://www.packtpub.com/backbonejs-testing/book

<!-- more end -->
