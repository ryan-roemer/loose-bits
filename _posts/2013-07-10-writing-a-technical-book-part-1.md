---
layout: post
title:  Writing a Technical Book, Part 1
description:
  In a series of posts, I walk through my adventure in writing my first
  technical book, Backbone.js Testing. My first post discusses the process
  of connecting with a publisher, planning the book, signing the contract
  and starting work.
date: 2013-07-10 11:30:00 UTC
tags: ['writing', 'book', 'javascript', 'backbone.js', 'testing']
---

## Finding and Starting a Book Project

This is the first in a series of posts describing my adventures and
tribulations in the course of writing my first technical book,
**[Backbone.js Testing][book_packt]**. In this post, I will look back on how
I got roped into becoming an author, planning and scoping a prospective book
outline, and signing a contract to begin work on the book.

## Why Write a Book?

Writing a book is an enormous time commitment, puts pressure on your personal
and work obligations, and has little or no chance of being financially a
worthwhile endeavor. So, why do it?

The quick answer for me is that I was very curious about the authorship
experience and when Packt pitched me the book idea, it turned out to be for
a subject I am deeply interested in - frontend web application testing.

### Writing Tendencies

By way of a bit more background, software engineering is my second career.
Before becoming a full-time geek, I was an intellectual property attorney,
practicing with a large firm and focusing on mostly computer software and
hardware matters.

For those unfamiliar with life in a big firm, as a junior associate, you spend
nearly all of your time reading and writing legal documents of some type or
another. Public speaking skills are several orders of magnitude less important
than writing skills given the percentage time you will spend using each.

In my case, I probably spent about 5 hours total speaking in court for over
two and a half years in practice. Nearly the entirety of the rest of the time
was spent reading and writing.
By the end of my practice days, I spent most of my time writing
patent applications or related legal documents. As it turns out, patent
writing is essentially technical writing, with a bit of a legal bent.

So, coming back to my current life as a software engineer, I now spend most
of my days coding, but still keep a deep appreciation for technical writing
and authorship generally. Just not so much as to want to do that for my full
time job.

### A Topic of Deep Interest

On the technical side of things, I have been interested in frontend web
application testing for quite some time.
Historically, testing JavaScript in web pages has been an arduous task, with
very few good options and enormous amount of pain in any solution. For example,
in 2011 I wrote [two][envjs_post01] [posts][envjs_post02] on testing frontend
JavaScript using Env.js and Rhino. My solution was unreliable and hacked
together, but at that point, at least it was *something*.

Fast-forward to today, and with the rapid rise of Node.js on the backend and a
whole host of new and exciting browser libraries, there are a lot more options
for frontend testing. At Curiosity Media, we had a large Backbone.js web
application that we were able to get a solid, modern test harness around using
Mocha, Chai and Sinon.JS.

### And, Good Timing

[Packt Publishing][packtpub] had the good timing to approach me with a book
proposal for testing Backbone.js applications in late October of 2012. I'm
not sure the process was particularly selective in my case, as Packt has a
reputation for somewhat aggressive recruitment strategies for book authors and
reviewers.

Fortunately, the subject matter and book size met up well with my interest
in frontend testing and ability to explore authorship with a small title.
So, after a few days of deliberation, I signed on and began the pre-writing
process and negotiations with Packt.

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

<!-- more end -->
