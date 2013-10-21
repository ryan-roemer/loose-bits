---
layout: post
title:  Writing a Technical Book, Part 2 - Authoring
description:
  In the second post in my series on writing a technical book, I walk through
  my experiences writing the six chapters that would eventually comprise
  Backbone.js Testing. I discuss the ups and downs of working with a
  time-sensitive publisher, finding the time and motivation to write, and
  honing the material down into an actual book.
tags: ['writing', 'book', 'javascript', 'backbone.js', 'testing']
---

## Writing a Book

This post is the second in a series on my experiences writing my first
technical book, **[Backbone.js Testing][book_packt]**, published in July, 2013.
In this point, I will walk through authoring the core of the book from writing
the first pages to finishing off the last round of technical edits and ending
up with something (pretty close) to a real book.

## Where we Left Off

In my previous post on [starting a book project][book_post01], I discussed how I
got roped into writing a technical book and the process from initial contact
from the publisher to signing a book contract. As part of the negotiations, we
agreed on the following ultimate chapter outline (with estimated page count and
due dates):

1. Setting up a Test Infrastructure (10 pages) - Jan. 8, 2013
2. Creating a Backbone.js Application Test Plan (8 pages) - Jan. 16, 2013
3. Test Assertions, Specs, and Suites (20 pages) - Jan. 28, 2013
4. Test Spies (7 pages) - Feb. 4, 2013
5. Test Stubs and Mocks (15 pages) - Feb. 11, 2013
6. Headless Web Testing (12 pages) - Feb. 19, 2013
7. Appendix A: Other JavaScript Test Frameworks (8 pages) - Feb. 25, 2013

As a spoiler for the rest of this post - I came nowhere near making most of
the chapter deadlines.

## Starting on the Book

After signing the contract in mid-December, I found that I suddenly had my first
chapter due Jan. 8 and subsequent chapters following quickly after that. Shortly
thereafter, I dug in and started getting my authoring and coding tools set up,
enhancing my book outline, and dove into writing the first chapter.

### Nuts and Bolts - Storage and Backups

As a purely logistical matter, my book chapters were to be authored as Microsoft
Word documents and have images in the PNG format. The source code examples are
in HTML, JavaScript, and CSS. And, being a consummate techie, I knew that I
needed a reliable and flexible digital storage system. My main goals for this
setup were:

1. Provide a disaster recovery solution if my laptop dies.
2. Provide "checkpoints" to go back to earlier versions of my work to find
   cut text and alternative previous drafts.

The source code samples were going to be released as an open source
project and were pure, usable source code, so the storage and backup solution
was quite obvious - Git and [GitHub](http://github.com). You can find the
code samples ultimate home at the book's [GitHub repository][book_repo].

For the book's textual sources however, Microsoft Word documents typically don't
play well with Git, and I the book's text as an open source project.
Nonetheless, after reviewing a lot of alternative storage systems (Dropbox,
Amazon S3, etc.), I decided to go ahead and use Git with a private repository.
My rationale was that Git still provided checkpoints to early MS Word document
drafts, even if I couldn't use all of the normal Git tools with the documents.

I cannot emphasize enough the importance of backups when writing a book, and
preferably something that checkpoints drafts. There are a variety of bad things
that can happen to both your computer (crashes, etc.) and documents (like MS
Word files becoming corrupted). In my case, I had my laptop stolen in May during
the middle of the authoring process - I didn't lose any of my book progress
(code or text) as I was able to easily restore my existing work on another
computer with just a few downloads.

### Planning and Outlining

Turning to the substantive end of kicking off the book, I began reworking and
expanding on my detailed book outline that I had begun as as part of the book
scoping and negotiation process with Packt.

The original outline had about a page of bullet points per chapter. I turned
this into a series of sections and sub-sections for Chapter 1. Then, I filled in
as many substantive bullet points as I could for each section and sub-section to
essentially write the structure and outline content for all of the first chapter
before diving in and actually writing text.

I strongly recommend detailed outlines for any large writing project as it
forces you to collect your thoughts, hone the overall message and protect you
from writing lots of text in directions that will later be cut in the editorial
process. Or, putting in software development terms, you don't start a large
web application by writing code top-to-bottom - instead, you create a general
design and architecture first (say, model-view-controller or something), and
then you plan and implement the parts. The same goes for writing, if you want
your end result to be cogent and well-crafted.

This was also a chance for me to revisit the vision for the book as a whole,
as the first chapter will really start limiting and focus the world for the
book. My book was about using testing technologies (frameworks, assertions,
and fakes) for a specific web framework (with models, views, controllers,
and other framework components). The big decision made in the original outline
was to split chapters by different test technology, and *not* by web framework
component.

* TODO: Writing the Notes App, planning this, and weaving throughout.






* PLAN: Have a sample application and use it as a vehicle for the chapter organizations.
  * Was some question as to how to organize - Backbone.js topics vs. testing topics?

* FORMAT: MS Word. Would have liked Markdown or even LaTeX.
* TIP: Do OS for examples. Source licensing: do OS on GH in addition to publisher's server.

* LOGISTICS:
  * Git Source: BitBucket, GitHub for public samples.
  * MS word went into git as well.

* SUBMISSION / STORY: Editors in different time zones. Packt




<div>
  <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
</div>

## Some Unexpected Surprises

* LOGISTICS: Backup
  * TAKEAWAY: Have some regular, reliable backup strategy. I got my computer stolen.

* TIP: Time commitments. And negotiating life events and deadline slippage. And factoring in revision time (after reviews).
  * STORY: Cross-country move.


## Cranking out the Pages

* TODO: Writing the bulk of the chapters.

* STORY: Page count creep and escalation.

* STORY: Original contract dates vs. my draft dates vs. publication slippage dates.
* TIP/STORY: Time commitments.
  * The schedule will slip (unless not aggressive).
  * You will push into weekends, nights, mornings if you have a full time job.
  * Everything will take longer than you think. Maybe a factor of two.


## Heading in to the Home Stretch

* STORY: Cutting the appendix.
  * A lot of work and research for a minimal payoff (not directly subject-focused).


## Some Other Observations

* TAKEAWAY: Personality attributes that are helpful.
  * Writing fast.
  * Reviewing fast.
  * Don't get bored easily (and you will get bored of your own writing)

* TIP: Editing - Print out a hard copy, get a red pen, and go to town.

<div>
  <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
</div>




<!-- more start -->

[backbone]: http://backbonejs.org/
[packtpub]: http://www.packtpub.com/
[book_repo]: https://github.com/ryan-roemer/backbone-testing/
[book_site]: http://backbone-testing.com/
[book_packt]: http://www.packtpub.com/backbonejs-testing/book
[book_post01]: /2013/08/04/writing-a-technical-book-part-1.html
[sinon]: http://sinonjs.org/
[mocha]: http://visionmedia.github.io/mocha/
[chai]: http://chaijs.com/

<!-- more end -->
