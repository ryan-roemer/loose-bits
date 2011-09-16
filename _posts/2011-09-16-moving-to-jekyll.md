---
layout: post
title: How I Learned to Stop Worrying and Love the Static Blog
description: Loose Bits' journey from Blogger to GitHub using Jekyll.
date: 2011-09-16 16:00:00 UTC
tags: ['jekyll', 'blog']
---

## Farewell Blogger...

Blogger provides an easy, integrated blogging service, but I have not been
posting with anywhere near the frequency I had hoped for, and have recently
started thinking of the reasons why this is. The list I cam up with includes:

* **Page load times**: To get syntax highlighting, a nice theme, etc., my
  posts have an incredible amount of download cruft.
* **Editing Interface**: While blogger's WYSIWYG editor is fairly intuitive
  and the HTML editor is the appropriate power tool, I don't like the fact
  I have to (1) be online, and (2) find a lot of situations where I want
  something in between a WYSIWYG and raw HTML.
* **Offline Editing**: Expanding on the above point, I travel a lot, and it
  would be great to be able to compose and view posts offline (like on a
  plane).
* **Versioning/Backups**: Blogger doesn't allow for easily versioning of
  posts, which would be nice.

I essentially run a programming blog, and as such, I don't need a lot of
frills, bells or whistles. What I really want is text-based, powerful
and configurable blog engine. Enter [Jekyll][jekyll].

[jekyll]: http://jekyllrb.com/

## Hello Jekyll and GitHub!

After a decent amount of research, I settled on [Jekyll][jekyll]. Jekyll is
a static website generator, written in Ruby, supporting
[Markdown](http://daringfireball.net/projects/markdown/),
[Liquid templates](http://liquidmarkup.org/), and custom
[Liquid extensions](https://github.com/mojombo/jekyll/wiki/liquid-extensions).

There are [many](http://www.google.com/search?q=moving+to+jekyll) stories of
folks moving successfully to Jekyll, and the feature set really hit my pain
points:

* **All Text**: All files are text, and either configuration, markdown,
  template language, or whatnot.
* **Versioned**: It's all source, so place your source under Git, and you're
  ready to go.
* **Offline**: The whole site can be generated or locally served without
  and internet connection.
* **Markdown**: There are other pre-processing options, but I just went with
  Markdown, and it's really nice and easy to write posts now without jumping
  back and forth from a WYSIWYG editor to straight HTML. I stay in Markdown
  and everything (mostly) ends up looking correct.
* **Syntax Highlighting**: Jekyll uses [Pygments](http://pygments.org/) for
  source code highlighting, which is mostly pre-processed, and not an
  after-the-fact JavaScript processing step (which had previously been slowing
  down by Blogger site).
* **GitHub Support**: GitHub's default document generator is Jekyll, and
  (separately) has full website support with CNAMEs. This provides an easy
  means of both site storage / versioning as well as the actual serving.

<!-- more start -->

However, this is not to say that a Jekyll site is everyone's cup of tea.
There are some drawbacks to this approach:

* **Static Site**: The generated site is static, which means no database or
  dynamic pages for things like comments, etc. All dynamic content has to come
  in via JavaScript / JavaScript-based services (like [Disqus][disqus] for
  comments). And, you have to implement a manual RSS feed, etc.
* **Manual CSS, HTML, etc.**: There are no built-in themes, etc., because you
  are crafting a site from scratch. Really, this isn't too bad because other
  Jekyll-site authors often publicly version their source with permissive /
  public domain licenses at GitHub, so you can pull source for examples.
  Also, there are a lot of starter kits for static CSS / HTML sites.
  For me, it's really a nice opportunity to get re-acquainted with site design.

[disqus]: http://disqus.com/

## Packing Up and Moving Out

### Posts

The first step to migrating my Blogger site was to simply download all of the
posts in a Jekyll-friendly format.  I used a very simple
[script](https://gist.github.com/1115810) that a good job of downloading
basic HTML from the Blogger feed URL.

I then took the HTML pages and further converted them to Markdown using
the handy [html2text](http://www.aaronsw.com/2002/html2text/) script.
From there, I had to manually edit the gremlins left in the conversion process,
including redoing anchor tags, removing Blogger-specific extras, and getting
local images into my source repository static media directory.

Jekyll has its own default (but customizable) format for blog post names. I
like it, but it is slightly different than Blogger, which all my existing
posts already use. Fortunately, each Jekyll post has a ``permalink`` attribute
allowing the post to escape the normal URL processing rules and use a one-time
path instead.

### Comments

After getting my posts ported over, the next step was to get my comments out
of Blogger and in to something that would work with the static Jekyll web site.
Enter [Disqus][disqus], which is inserted via JavaScript, and this is usable
for my new static website.

Making things easier, Disqus has
[Blogger support](http://loose-bits.disqus.com/admin/blogger/). So, I first
switched my Blogger site comments to Disqus, then used the Disqus blogger
import tool, available at:

    http://<DISQUS SHORT NAME>.disqus.com/admin/tools/import/platform/blogger/

I followed the instructions and started the Blogger comment import. I expected
the import to finish quickly, as I only have a handful of comments at the time
of the migration, but it ended up taking 6 or so hours. Searching the web,
there are reports of the Disqus comment import taking up to 2-3 days, so
the lesson is: be patient. Oh, and don't get freaked out when your comments
disappear entirely from Blogger in the meantime.

Once the import finished, I looked at my Blogger site and saw that all of the
comments had successfully been transitioned over to Disqus. I then set up
Disqus support on my post template using the Disqus
"[universal](http://docs.disqus.com/developers/universal/)" installation
guidelines.

Before fully transitioning over to my new Jekyll/GitHub site, I wanted to
make sure that everything was good to go with Disqus. Fortunately, Disqus
allows you to specify a "developer mode" to have comments pulled down, even
when running a localhost site. With these configuration variables in the Disqus
JavaScript block, I can view the comments for this post on my laptop at
localhost:

{% highlight javascript %}
// Live page URL.
var disqus_url = '{{ site.liveurl }}{{ page.url }}';

// Developer mode for localhost.
var disqus_developer = 1;
{% endhighlight %}

### RSS Feed

You have to specify your own "atom.xml" file for RSS feeds. Fortunately,
there are many examples from other Jekyll sites, including Tom Preston-Werner's
[site](https://github.com/mojombo/mojombo.github.com),
as well as a good Google Groups
[thread](http://groups.google.com/group/jekyll-rb/browse_thread/thread/5a8af8abb59ff9ac/914585f6e43e9b92).

Here is my finished [atom.xml]({{ site.github }}blob/master/atom.xml) for this
site for reference.

### Post Excerpts

My Blogger site displays a few recents post excerpts on the index page, which
I liked. However, there is no native "excerpt" functionality in Jekyll at
the moment. Fortunately, a very clever
[hack](http://kaspa.rs/2011/04/jekyll-hacks-html-excerpts/) enabled me to
add post excerpts of my most recent couple of articles to my new index page.

## And, We're Up!

And that finishes my journey from Blogger to Jekyll and GitHub. As a final
commentary Blogger does a great many things right and is a solid platform, but
my use cases favor power and extensibility over many of the conveniences that
Blogger provides.

Although it took some time to put my new site together, everything feels
"right" to me. Even writing this first post for the new site has been
considerably easier -- I've been both online and offline composing the post in
TextMate (which has Markdown syntax highlighting as well as spell check),
and it has never been as easy or fast to write up posts, so here's to hoping
for a more consistent stream of posts in the future!

<!-- more end -->