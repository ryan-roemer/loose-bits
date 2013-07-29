---
layout: post
title:  Writing a Technical Book, Part 1 - Starting the Project
description:
  In a series of posts, I walk through my adventure in writing my first
  technical book, Backbone.js Testing. My first post discusses the process
  of connecting with a publisher, planning the book, signing the contract
  and starting work.
date: 2013-07-10 11:30:00 UTC
tags: ['writing', 'book', 'javascript', 'backbone.js', 'testing']
---

## Finding and Starting a Book Project

I published my first technical book, **[Backbone.js Testing][book_packt]**,
in July, 2013. Now that I am coming down off the high of actually getting the
book out to the world, I thought that I would take a little bit of time to
reflect on my journey and write a series of posts about the adventures and
tribulations of writing a technical book.

In this first post, I will look back on how I got roped into becoming an author,
planning and scoping a prospective book outline, and signing a contract to begin
work on the book.

## Why Write a Book?

Writing a book is an enormous time commitment, puts pressure on your personal
and work obligations, and has little or no chance of being financially a
worthwhile endeavor.

*So, why do it?*

The short answer is that (1) I liked the proposed topic, (2) I was already
interested in writing, and (3) Packt Publishing had some fortuitous timing in
pitching the project.

### A good, challenging topic

Frontend web application testing has been a topic of keen interest and
frustration for me for quite some time. Historically, testing JavaScript in web
pages has been an arduous task, with very few good options and enormous amount
of pain in any solution. At the same time, there is enormous need for this type
of testing as more and more logic is pushed from a traditional backend
application (e.g., a Django or Rails app) to the frontend.

In my day-to-day work over the past few years, I've noticed that the biggest
holes in application test coverage and sources of *most actual bugs* have been
in frontend JavaScript code. Accordingly, I have now spent a good amount of
time implementing and writing about testing on the client side. In 2011,
I wrote [two][envjs_post01] [posts][envjs_post02] on an early frontend testing
solution I came up with using Env.js and Rhino. The technologies were
unreliable and hacked together, but at that point, at least it was *something*.

Fast-forwarding to today, with the rapid rise of Node.js on the backend and a
whole host of new and exciting browser libraries, there are a lot more options
for frontend testing. At Curiosity Media, we had a large Backbone.js web
application that we were able to get a solid, modern test harness around using
[Mocha][mocha], [Chai][chai] and [Sinon.JS][sinon].

### I missed writing

By way of a bit more background, software engineering is my second career.
Before becoming a full-time geek, I was an intellectual property attorney,
focusing on mostly computer software and hardware matters.

While some folks think that the life of a lawyer mostly involves standing up
and arguing in court (e.g., "I object!"), the reality is that as a junior
associate attorney, you spend nearly all of your time reading and writing legal
documents of some type or another. Moreover, as a patent attorney, most of your
time is spent writing patent applications and related legal documents.
And, patent writing is essentially technical writing, albeit with a bit of a
legal bent.

So, coming back to my current life as a software engineer, while I occasionally
write blog posts and articles, it had been several years since any substantive
writing project. And, I kind of missed it.

### And, it seemed like the right time

With that background, [Packt Publishing][packtpub] had the good timing to
approach me with a book proposal for testing Backbone.js applications in late
October of 2012.

I'm not sure the process was particularly selective in my case, as Packt has a
reputation for somewhat aggressive recruitment strategies for book authors and
reviewers (e.g., they send a lot of emails). But, the subject matter was a good
fit for my frontend testing interests, and the book size seemed to make the
project tractable.

## The Book Proposal

My first contact with Packt was from an "Author Relationship Executive", which
I think is something like an author recruiter. The tentative project outline
Packt proposed was for a 90-page book with five chapters covering Backbone.js
application testing concepts and tools.

TODO - Talk with Advisor.
TODO - Handoff to Commissioning Editor.




TODO - Go through emails and take notes.


General - First Post
====================
* NOTE: Qualifier - My background is perhaps a little different than most tech. writers. A patent / litigation attorney is essentially a technical writer with a very arcane publishing goal.
* TAKEAWAY: Personality attributes that are helpful.
  * Writing fast.
  * Reviewing fast.
  * Don't get bored easily (and you will get bored of your own writing)

"Finding and Starting a Project"
================================
* STORY: I've been interested in frontend testing for a long time, since Env.js + Rhino and was now knee-deep in a large Backbone.js project that we had spent a significant amount of time building a test infrastructure around. Modern tools have made this all much easier, and I'd been learning off of blogs posts, and ad hoc sources.
* STORY: Outline
  * Original outline from Packt.
  * Switched Jasmine to Mocha / Chai.
  * Added automated testing / appendix (later cut).
* STORY: Contract
  * Scoped at 80, then 100 pages.
  * Remove the future works clause.
  * Link to other authors that removed more.
  * Open source for the code samples.
* TIP: Review and negotiate the contract. It's an open discussion, not a "take it or leave it" proposition.
* TIP: Don't do it for the money. And, don't ever try and calculate what your effective hourly rate is. Reasons to do it: (1) learn a new subject, (2) get your name out there in a (new) area.
  * http://authors.packtpub.com/content/royalties
    * "You get 16% of all revenue earned from your book"
    * Advance (basically nothing).
* TIP: Do OS for examples. Source licensing: do OS on GH in addition to publisher's server.
* TIP: Time commitments. And negotiating life events and deadline slippage. And factoring in revision time (after reviews).
  * STORY: Cross-country move.
* STORY: Editors in different time zones. Packt

* DISCUSS: "Why go with a real publisher (e.g., Packt) instead of self publishing (e.g., LeanPub)". Answers - have friend who wrote for Packt, access to technical reviewers, publicity, distribution, and they already wanted a book on the topic.


## TODO - Book description stuff.

I am very pleased to announce that I am in the last stages of publishing
**[Backbone.js Testing][book_packt]** - a book on [Backbone.js][backbone] test
architecture and development due in final form around the end of June.

A brief abstract of the book's content is available from the
[Packt Publishing][packtpub] [website][book_packt]:

<!-- more start -->

## TODO - STUFF HERE

[backbone-testing.com][book_site]
[GitHub repository][book_repo]
[Packt Publishing][packtpub]

[backbone]: http://backbonejs.org/
[packtpub]: http://www.packtpub.com/
[book_repo]: https://github.com/ryan-roemer/backbone-testing/
[book_site]: http://backbone-testing.com/
[book_packt]: http://www.packtpub.com/backbonejs-testing/book
[envjs_post01]: http://loose-bits.com/2011/02/browserless-ajax-testing-with-rhino-and.html
[envjs_post02]: http://loose-bits.com/2011/02/browserless-ajax-testing-with-rhino-and_16.html
[sinon]: http://sinonjs.org/
[mocha]: http://visionmedia.github.io/mocha/
[chai]: http://chaijs.com/

<!-- more end -->
