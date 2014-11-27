---
layout: post
title:  Writing a Technical Book, Part 3 - Publication
description:
  In the third post in my series on writing a technical book, I reflect on all
  of the work after the book was written to actually getting the book on
  real and virtual shelves and out to the public at large.
tags: ['writing', 'book', 'javascript', 'backbone.js', 'testing']
---

## Publishing a Book

At long last, this is the third post in a series on my experiences writing
**[Backbone.js Testing][book_packt]**, published in July, 2013. In this post,
I'll dive into the publication process for my book and expand on the
following takeaway points:

* There is a good amount of boring, necessary work on your book to turn
  final drafts into correctly laid-out, ready-for-printing pages.
* You need to keep a keen eye to _everything_ about your book, including the
  cover / marketing language and especially your publisher's book webpage.
* This is your last chance to catch both small and _extremely large_ errors.
* Working though the final mile of publication with your publisher can be
  frustrating...
* ... but it feels wonderful to actually have the book done, published and
  in a very literal sense, "shipped".


## You've Written a Book - Now What?

In my previous post on [authoring a book][book_post02], I recount writing the
individual chapters of the book, going through technical and editorial review,
and submitting the "final" draft for publication at the end of April, 2013.

After this final submission, I asked the publisher's project folks what to
expect from that point to actual publication and was told that the process for
each chapter was something along the lines of:

* Technical editing.
* Copy editing
* Indexing key terms
* Layout adjustments for actual, rendered book pages
* Proofreading
* "Prefinal" submission for the author's final review
* Finalization and clubbing

Each of those steps was forecast to take 1-2 days and run in parallel for all
the chapters.

It was at that time that I also reminded Packt (my publisher) that we still
needed to formally update the book's title from "Backbone Testing" to
"Backbone.js Testing" in all of the materials, something Packt repeatedly told
me was easy to do throughout the process.

<!-- more start -->


## A Break + How Hard Can a Title Change Be?

As my publisher had pushed me quite hard the entire time I was writing my
chapters to get everything done as fast as possible, I was surprised to hear
mostly radio silence for around twenty days. Finally, I started poking around
Packt's website to see if they had started any pre-publication activity, and to
my pleasant surprise, they had -- putting up a web page for my book.

_Unfortunately_, they somehow managed to screw up my title change request and
renamed the book to "Testing Backbone.js". Issues aside about the difficulty
of getting two simple words right and in the correct order, I was extremely
disappointed -- a publishing house should be able to correctly assign a book
title. And, Packt had submitted the incorrect title for pre-publication book
pages on Amazon, Barnes & Noble, and other online book retailers.

Somehow making things worse, the page that Packt put up for pre-publication was
nonsensically worded in its description of the book and why prospective readers
should buy it -- with repeatedly copy-and-pasted sentences and gems like "Test
your web applications using backbone's tried and tested techniques and industry
best practices". (For those not familiar with Backbone.js, just trust me that
the last statement is pure technical gibberish).

So, I emailed my commissioning editor, only to find out that they had been on
break for some time (which probably explained the lack of editorial activity). I
finally tracked down my previous commissioning editor and roped them in to
fixing the mess.

It turns out that Packt had just been more or less guessing at the marketing and
book cover metadata -- bullet points about why to purchase the book, the title
tagline, etc. So, I undertook reviewing all the book metadata and online content
and provided my publishers with new content for all of it. Although time
consuming, I really wanted something that would make sense from the point of
view of an actual prospective reader, and hopefully make the book seem like a
good purchase.

Through all of this mess, there were some actual silver linings. I got to
actually choose a picture for the book cover, which I chose from one of my
wife's photographs from nearby our house. Here's the cover again for
reference:

<div class="pull-center">
  <a href="http://www.packtpub.com/backbonejs-testing/book">
    <img class="bordered"
         style="width: 65%; max-width: 350px;"
         alt="Backbone.js Testing"
         title="Backbone.js Testing"
         src="{{ site.url }}{{ site.baseurl }}media/img/2013/06/13/book-cover.jpg" />
  </a>
  <p />
</div>

And, I did learn about _all_ of the details of the book cover and website
marketing content because I was so paranoid about something else inaccurate or
nonsensical being written on my behalf about the book.


## Prefinal and Final Editing

After the diversion of the book title / marketing material, Packt finally
got the first chapters back to me for prefinal review on May 30th, supposedly
targeting a "to the printers" date of June 10th. When I asked about the delay
and impending deadline, the publisher responded that they had actually been
short-staffed the entire time after I submitted my final drafts. We jointly
agreed to push back the actual final deadline.

The prefinal and final editing process was mostly boring but important work. I
was sent PDFs of what would be close to the final layout and look for the
chapters to review, with comments and suggestions from the publisher. The
technical editors and proofreaders didn't find many issues and sometimes
mis-identified correct writing as errors. But, they did ultimately find a number
of real errors we were able to correct.

It was also a good opportunity for me to re-read my chapters after about a
month's break. At that point, I didn't really have a chance to make substantive
changes (which would dramatically affect the layout work), but I was able to
gauge the readability and substantive arch of the book as a whole. And, I also
found a few bugs and errors on my own in the process.

Packt and I went back and forth either one or two times per chapter, circling
around a narrowing group of sentences and words to discuss, and then finally
arrived at the "good enough!" point. On July 3rd, I sent over the final approval
of all the remaining chapters. And, on July 12th, I received confirmation that
the book was uploaded to the printers and thus officially published / available
for purchase.


## It's Published! Now What?

I will post a final article on the post-publication / marketing experience with
my book, but the short version is that I did feel a huge relief actually getting
the book out the door and curiosity as to what would happen next.

Up until that point, I didn't really have a lot of time for reflection along the
way as to how good or bad the book was, or whether or not folks would actually
buy it once it went on sale. But after publication, and especially when I was
helping marketing the book, I did feel some degree of nervousness and
anticipation as to what developers out in the wild would think of something that
I had dedicated a good chunk of the past half year writing.

*But, more on that in the last post in this series...*

[backbone]: http://backbonejs.org/
[packtpub]: http://www.packtpub.com/
[book_repo]: https://github.com/ryan-roemer/backbone-testing/
[book_site]: http://backbone-testing.com/
[book_packt]: http://www.packtpub.com/backbonejs-testing/book
[book_post01]: {{ site.url }}{{ site.baseurl }}2013/08/04/writing-a-technical-book-part-1.html
[book_post02]: {{ site.url }}{{ site.baseurl }}2013/11/25/writing-a-technical-book-part-2.html
[sinon]: http://sinonjs.org/
[mocha]: http://mochajs.org/
[chai]: http://chaijs.com/

<!-- more end -->
