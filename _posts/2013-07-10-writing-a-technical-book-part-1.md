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

The short answer is that I liked the proposed topic, I was already
interested in writing, and Packt Publishing had some fortuitous timing in
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

My first contact with Packt was from an "author relationship executive", which
I think is something like an author recruiter. The tentative project outline
Packt proposed was for a 90-page book with five chapters covering Backbone.js
application testing concepts and tools.

Once I expressed some interest, the author relationship executive passed me on
to a "commissioning editor", who is the main editor for the book. I would
later find out that there are various editor roles, as well as many different
people iterating through those roles during the course of writing the book.

The commissioning editor answered my initial queries and communicated the
basic logistics of the book - drafts are written in Microsoft Word,
the loose drafting and editorial process, etc. The expected page count got
ramped down to 80 pages, which Packt considers a "mini" book - a short,
concise book on a specific topic.

The editor then sent me a helper "outline kit" for me to put together a target
outline for the book, which added up to 60 pages of content. The goal was to
fill in a per-chapter outline for each of the five proposed chapters. I did
this, then proposed an additional chapter (on automated web testing) and
an appendix. The Packt team liked the outline and my suggested additions, and
bumped the allowed page count to 80 pages.

After a bit more back and forth, I finished a final draft of the book outline,
which Packt approved, and then we moved forward to the contract stage. The
takeaway from the proposal process was that we ironed out the chapter structure
and length, which would then constrain the writing process and define what parts
were going to be due.

## The Book Contract

After approving the book proposal, Packt sent me a book contract for review.
The contract most entailed expected details of obligations for the author in
writing the book, what happens if the author fails to deliver chapters or
stop working on the book, etc.

### The legalese

Although sometimes scary and written in abstruse legalese, a contract is
essentially a negotiation in paper form. An important thing to remember that
any point is up for grabs, modifiable or removable. With that in mind, I dove
into the contract and started dissecting some of the points that might need
changes.

One of the biggest issues with the contract was that Packt put in a clause
titled "Option on future Works", which basically obligated me to give Packt the
first right to publish my *next two books* after the one we were discussing.

> The Author shall give the Publisher the first opportunity to read and consider
> for publication the next 2 works on any computer-related subject that the
> Author seeks to have published.

To me, this clause was clearly ridiculous - it is one thing to agree to a book
contract when I've never written one before nor worked with Packt before, but
it's quite another to say the first **three** books I would write would be at
Packt's publishing discretion. So, I asked Packt to remove the clause
entirely.

A separate issue that wasn't directly addressed in the contract was the
licensing of the code samples that accompanied the book. The code samples
technically fall under the copyrights of the book generally. However, I
wanted to release all of the code samples as an open source project, so that
I could easily publish the code, get community improvements and bug fixes,
and get the code out earlier than the book. So, I asked that Packt allow all
of the code samples to be separately published to GitHub as an open source
project under the MIT license (the most common license for the components
I was using).

Packt agreed to both changes without any further issue or push back.

### The time frame

Packt set up an incredibly aggressive time frame for completing the first
drafts of the book - something short of two months. As I was going on
vacation, I was pushed back a little bit and got the following schedule
(assuming a starting date of January) for my chapter drafts:

1. Setting up a Test Infrastructure - Jan. 8, 2013
2. Creating a Backbone.js Application Test Plan - Jan. 16, 2013
3. Test Assertions, Specs, and Suites - Jan. 28, 2013
4. Test Spies - Feb. 4, 2013
5. Test Stubs and Mocks - Feb. 11, 2013
6. Headless Web Testing - Feb. 19, 2013
7. Appendix A: Other JavaScript Test Frameworks - Feb. 25, 2013

In retrospect, this schedule was **insane** and in no way was feasible given
that I had a full time job and was expecting to write on nights and weekends.
But, the story of the how all of the deadlines (both mine and my publisher's)
slipped over the course of the book is for another post.

Suffice to say that I should have massively padded the draft chapter due dates
in the contract by at least a factor of 1.5 from what I have here. And, as a
first time author, I really should have erred on the side of further deadlines.








TODO - Link to contract discussion.
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
