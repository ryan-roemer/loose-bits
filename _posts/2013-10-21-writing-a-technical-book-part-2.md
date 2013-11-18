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

This post is the second in a series on my experiences writing my first technical
book, **[Backbone.js Testing][book_packt]**, published in July, 2013. In this
point, I will walk through authoring the core of the book from writing the first
pages to finishing off the last round of technical edits and submission
of the full draft of the book to my publisher.

An overview of the main points we'll cover includes:

* Make sure to have a reliable backup of your work - expect to lose all your
  files (and your computer).
* Before writing anything, plan and outline everything.
* The writing process will take much longer than you think it will.
* The writing process is also tiring, stressful, and boring.
* Technical review will bruise your ego and leave you with a much better book.
* Once you get most of the way through the drafting process, you (the author)
  hold the power in your relationship with your publisher.


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

<!-- more start -->

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

This was also a chance for me to revisit the vision for the book as a whole, as
the first chapter will really start limiting and focus the world for the book.
My book was about using testing technologies (frameworks, assertions, and fakes)
for a specific web framework, Backbone.js (with models, views, controllers, and
other framework components). The big decision made in the original outline was
to split chapters by different test technology, and *not* by web framework
component.

At the same time, I needed to weave each testing lesson *back* to the
Backbone.js framework (the book title is, after all, **Backbone.js** Testing),
so I decided to create a reasonably complex Backbone.js sample application to
use throughout the book. The application is a simple
note-taking web page, named Notes, and I tested different parts of Notes in
each chapter using the specific chapter's test technology.

I think this approach was ultimately successful in unifying the test concepts
with Backbone.js application fundamentals, but it also required a lot of
upfront work, as the Notes sample application essentially needed to be coded
and tested very early on, before most of the chapters were written.


## And Off We Go (The First Chapter)

With my Chapter 1 outline prepared and my Git repositories ready to go, I
started writing the first chapter, "Setting up a Test Infrastructure". The
chapter essentially comprised downloading all of the libraries needed to run and
execute the book samples and create a "Hello World"-ish test infrastructure.

Chapter 1 came together reasonably easily on a fairly relaxed scheduled, as
it wasn't due until the first week of January. I had time to create the example
application and tests that would be used throughout the entire book. I had
a little bit of acclimating to formatting the document per required guidelines
and generating acceptable screenshot image files, but it wasn't too bad.

I turned in the chapter draft on the scheduled due date, and thus started my
first milestone for actually *writing* a book!


## Digging In (The Other Chapters)

**TODO: Review and rework this section.**


## Some Other Observations

* TAKEAWAY: Personality attributes that are helpful.
  * Writing fast.
  * Reviewing fast.
  * Don't get bored easily (and you will get bored of your own writing)

* TIP: Editing - Print out a hard copy, get a red pen, and go to town.

* END: Final submission of the draft.





Delivering the first draft of Chapter 1 on time and in reasonably good shape
did feel like an accomplishment. However, even at that point I realized that
the original negotiated schedule was going to end up being far too aggressive
in light of having a (more than) full time "day job" and trying to keep some
semblance of a life outside of technical-related matters.

As it turns out, an outside factor then ended up blowing the schedule away.
During the time I was writing the first chapter and after signing on to the book
project, my wife interviewed for, and accepted, a new position in Seattle. When
everything was finalized, I suddenly was faced with a cross-country move from
Washington, DC to Seattle, WA in mid-February.

I raised the issue with my publisher upon turning in my first chapter, and we
agreed on a revised schedule, effectively spreading out the due dates for
chapters 2 and 3 through the end of February. We left the rest of the chapter
deadlines as more of a "cross that bridge when we come to it"-type thing.

Over the next few months, I dug in and cranked out the chapters in my nights
and weekends (with a generous interruption for moving to Seattle). The writing
was relatively straightforward in terms of subject matter and getting it
down on paper, but the process itself was quite difficult and taxing. A
non-exhaustive list of the rough parts of writing most of the book includes
the following:

* **Exhaustion**:
  I was pretty tired when writing. I started working on the book many nights
  after 10:00 pm or before 4:00 am. It's hard to think when you're tired, and
  harder to write.
* **Scope Creep**:
  The chapters ended up being longer than originally anticipated, making the
  work take longer. I tried to keep to the proposed outline's estimates, but
  there were some topics that just couldn't be covered in the expected
  number of pages.
* **Reviewing Work**:
  Authoring a first draft is not the end of your work. After a chapter
  submission, the publisher would forward the chapter draft to the technical
  reviewers, who added comments or made suggested changes. Then, the publisher
  would present their work back to me for chapter revisions. There was no
  real schedule for this, and it wasn't factored into the underlying schedule
  of chapter first drafts, yet ended up being a significant portion of work.
* **Time Zones**:
  The majority of the publisher's editorial staff was based out of India,
  meaning that communication almost always took a full day and was a half
  day out of sync.


## Technical Review

One of the benefits of working with a publisher, as opposed to self-publishing
or the like, was the recruitment of some very capable and smart technical
reviewers. Packt found two software developers well known in the community for
Backbone.js and frontend testing generally.

After I submitted each first draft chapter to Packt, they would assign the
chapters to the technical reviewers to add comments and make suggested text
changes. Then, I would receive the in-draft and separate comments from the
reviewers and rework each chapter into the second draft.

Going through technical review is a humbling process - not only did my reviewers
point out all of the errors in the chapter text, they also gave qualitative
ratings for each chapter, many of which were quite low for my first drafts. One
reviewer in particular was often quite critical in overall assessment and the
numerous comments he would pepper my drafts with. Yet, I couldn't have been more
happy with all of the ego-bruising / "this is horrible"-type criticism -- the
feedback was invaluable for correcting errors, getting a sense of my overall
message, and knowing that at least two highly intelligent developers had worked
through the text.

As far as work went, simple errors and omissions pointed out by the technical
editors were easy to correct. However, some were quite extensive to revise. For
example, a reviewer suggested that I should re-organize the entirety of my
example code's file structure. Evaluating the comment, I realized that he was
right, and spent a good deal of time retooling everything in the code and in the
book examples and text. I think the book ended up much better overall for the
change, but at the time it was really a pain to change.


## Getting Through the Editorial Process

I managed to get drafts of the first four chapters submitted by mid-March.
After my submission of Chapter 4, my publisher notified my that my editor was
changing roles in the company and that I would be assigned a new editor.

Right out of the gate, the new editor notified me that my chapters had deviated
from the estimates in the outline and that I would have to cut down my previous
chapters. The new editor presumably reviewed all the chapters submitted up until
that point and figured it was time for house cleaning.

I replied rather strongly that to try and go back and retrofit already
completed work at that time would be time-consuming, difficult, and likely
make the overall book worse for the changes. At the time I was writing Chapter
5, and the notion of stopping everything to go back to old chapters was just
dreadful.

As an aside here, it's worth mentioning the power dynamics of the author and
publisher. In my situation, Packt essentially provided no money upfront, a
quite meager advance on the completion of the entire book, and was essentially
relying on my good graces to finish the thing. Although technically they could
take my partially finished work and have another author pick it up mid-stream
if our relationship truly went south, the practical logistics of them being
able to actually go through with that would have been very difficult.

My intuition is that many book projects similarly set up to mine fail midway
through the process due to external constraints or pressures. Put another way,
if something came up on my end, there was really no way for my publisher to
force me to finish. And, once I was over halfway through my first draft of the
book, the publisher had strong incentives to see me complete it.

So, when I pushed back on the new editor's extensive rewrite proposal, Packt
was quite amenable and the editor backed down pretty easily.

To help with the overall size of the book, I proposed that we cut the planned
Appendix (a survey of related technologies to by book's core subject matter)
instead of revising existing chapters. The Appendix was already going to be a
pain to research and write, and figured offering it up as a "sacrifice" to
reclaim page count would be the best way to speed things along.


## Submission!

I submitted the final drafts of all chapters at the end of April 2013. I also
finished and submitted meta-level drafts of things like my biography and the
preface to the book.

As a foreshadowing event, I also reminded my editors that they had agreed to
change the title of the book from "Backbone Testing" to "Backbone.js Testing"
(just adding the three characters ".js").

The editors accepted my submission and gave me a rough outline of the process
that would unfold from there on out to actually publish the book, a story that
we will dive into in next post in this series.


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
