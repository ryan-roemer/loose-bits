---
layout: post
title: Sphinx Bootstrap Theme 0.2.0 - Now with Bootswatch!
description: The "spinx-bootstrap-theme" integrates Twitter
  Bootstrap with Python Sphinx. New version 0.2.0 adds support for
  Bootswatch themes and customizations to the vanilla Bootstrap appearance.
date: 2013-04-10 11:30:00 UTC
tags: ['python', 'sphinx', 'theme', 'twitter', 'bootstrap', 'bootswatch']
---

## Theme Updates

The [Bootstrap Theme][sbt_gh] for [Sphinx][sphinx] document continues to
evolve, and I'm pleased to announce the v0.2.0 release. The theme integrates
[Twitter][twitter]'s [Bootstrap][bootstrap] library into Sphinx,
and v0.2.0 adds new support for [Bootswatch][bootswatch] CSS extensions, which
provide a lot of great new UI possibilities for your documentation. We've
also internally updated to Bootstrap 2.3.1.

The project's [demonstration site][sbt_demo_readme] now uses the
"[united](http://bootswatch.com/united/)" Bootswatch theme to give a clean
and well... *orange-ish*, feel to the site. Here is a screenshot of the
demonstration site in a desktop viewport:

**TODO IMAGE**

The project is available for download from [GitHub][sbt_gh] and
[PyPi][sbt_pypi] and you are encouraged to update and try out some Bootswatch
goodness!

<!-- more start -->

## Bootswatch

As a preliminary note, the use of Bootswatch themes is entirely optional, and
disabled by default - the project starts with a vanilla Bootstrap appearance,
which you can customize to your heart's content. To enable a specific
Bootswatch theme, you can set the following option in your
"[conf.py][sbt_demo_cfg]" file:

{% highlight python %}
html_theme_options = {
    # Bootswatch (http://bootswatch.com/) theme.
    #
    # Options are nothing with "" (default) or the name of a valid theme such
    # as "amelia" or "cosmo".
    #
    # Note that this is served off CDN, so won't be available offline.
    'bootswatch_theme': "united",
}
{% endhighlight %}

The list of Bootswatch themes you can now try out include:

* [`amelia`](http://bootswatch.com/amelia/)
* [`cerulean`](http://bootswatch.com/cerulean/)
* [`cosmo`](http://bootswatch.com/cosmo/)
* [`cyborg`](http://bootswatch.com/cyborg/)
* [`journal`](http://bootswatch.com/journal/)
* [`readable`](http://bootswatch.com/readable/)
* [`simplex`](http://bootswatch.com/simplex/)
* [`slate`](http://bootswatch.com/slate/)
* [`spacelab`](http://bootswatch.com/spacelab/)
* [`spruce`](http://bootswatch.com/spruce/)
* [`superhero`](http://bootswatch.com/superhero/)
* [`united`](http://bootswatch.com/united/)

As a final note, alluded to in a code comment above, the Bootstrap CSS files
are served off of CDN, which means that if you are offline, your site will
have a non-themed, vanilla Bootstrap appearance. We are considering refactoring
the Bootswatch code to be available offline as well.

Happy theming!

[bootstrap]: http://twitter.github.com/bootstrap/
[bootswatch]: http://bootswatch.com/
[python]: http://python.org/
[sphinx]: http://sphinx.pocoo.org/
[twitter]: https://twitter.com/
[sbt_demo]: http://ryan-roemer.github.com/sphinx-bootstrap-theme
[sbt_demo_cfg]: https://github.com/ryan-roemer/sphinx-bootstrap-theme/blob/master/demo/source/conf.py
[sbt_demo_readme]: http://ryan-roemer.github.com/sphinx-bootstrap-theme/README.html
[sbt_pypi]: http://pypi.python.org/pypi/sphinx-bootstrap-theme/0.2.0
[sbt_gh]: https://github.com/ryan-roemer/sphinx-bootstrap-theme

<!-- more end -->
