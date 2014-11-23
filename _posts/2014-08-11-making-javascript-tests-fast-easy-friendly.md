---
layout: post
title: Making JavaScript Tests Fast, Easy, &amp; Friendly
description:
  <em>Making JavaScript Tests Fast, Easy, &amp; Friendly</em> is a presentation
  I gave at CascasdiaJS 2014 that focuses on creating processes and environments
  that help developers actually write and run application tests.
tags: ['cacasdiajs', 'talks', 'javascript', 'testing']
---

*Cross-posted from the
[Formidable Labs blog](http://formidablelabs.com/blog/2014/08/11/making-javascript-tests-fast-easy-friendly/)*.

A few weeks ago, I presented a talk on
"[Making JavaScript Tests Fast, Easy, &amp; Friendly][talk_site]" at the
[CascasdiaJS 2014][cjs14] conference in Portland, OR.
The talk looks beyond the traditional technical details of wiring up
test frameworks and focuses on creating processes and environments that help
developers actually **write** and **run** application tests.

## Making the Tests Faster, Easier, Friendlier

The motivation for the talk comes from our work with developer teams of various
sizes at Formidable Labs, where we have observed the challenges, successes, and
failures of test development as a part of the overall development workflow.
Essentially, these experiences can be culled down to the following:

* If tests aren't **easy to write**, then developers won't *write* them.
* If tests aren't **fast to run**, then developers won't *run* them.
* If the organizational culture isn't test-**friendly**, then developers won't
  write *or* run the tests (and they'll probably be unhappy to boot).

The talk dives into some tips and tricks to address these three broad goals
as follows:

<!-- more start -->

* **Easy**
    1. **Set a Foundation**: Build an infrastructure everyone can use.
    2. **Lower Barriers to Entry**: Help new developers get acclimated with
       code and mentorship.
    3. **Write it Down**: Document everything test-related and keep things
       up-to-date.
    4. **Teach &amp; Learn**: Provide onboarding and small, introductory
       test assignments.

* **Fast**
    1. **Know What to Look For**: Focus on the application behaviors most
       likely to be slowing down your tests (e.g., network and waits).
    2. **Find the Slow Pokes**: Use your test tools to identify *what* is
       slow during tests.
    3. **Fake It**: Programmatically "fake" the parts of your application that
       are slow during the tests.
    4. **Offer Shortcuts**: Provide developers with subsets of tests to run
       when the whole thing is too slow to regularly run.

* **Friendly**
    1. **Find Champions**: Encourage and promote developers who are considered
       project-wide testing leads.
    2. **Win the Higher-Ups Over**: Learn to speak your managers' language to
       get top-down support in your organization for developer time spent
       writing and running tests.

These are just some of the tips that we've found useful for making testing
better in our client projects at Formidable Labs. But, there are surely other
good techniques for building a strong culture of testing in other
organizations. (And, we'd love to hear your experiences in our comments below!)

## Media

The full [video][talk_video] of my talk is available from [YouTube][talk_video].
As an aside, the [CascadiaJS YouTube Channel][cjs_youtube] has videos from the
other (fantastic) talks at this year's conference.


<div class="embed embed-video">
  <iframe width="560" height="315"
        src="//www.youtube.com/embed/BK3dQUjwo9Q?list=UUIP244iNzbn4iEkDOgczvcQ"
        frameborder="0" allowfullscreen></iframe>
</div>

For those just looking for the slides, you can try the
[presentation website][talk_site] (with live executable code samples!) or the
more traditional [SlideShare site][talk_slides], where the final PDF resides.

<div class="embed embed-slides">
  <iframe src="//www.slideshare.net/slideshow/embed_code/37707398"
        class="slideshare"
        width="512" height="421" frameborder="0" marginwidth="0" marginheight="0"
        scrolling="no"
        allowfullscreen></iframe>
</div>

[talk_site]: http://cascadiajs2014.formidablelabs.com/
[talk_video]: http://youtu.be/BK3dQUjwo9Q?list=UUIP244iNzbn4iEkDOgczvcQ
[talk_slides]: https://www.slideshare.net/RyanRoemer/cascadiajs-2014-making-javascript-tests-fast-easy-friendly
[cjs14]: http://2014.cascadiajs.com/
[cjs_youtube]: https://www.youtube.com/user/cascadiajs/videos

<!-- more end -->