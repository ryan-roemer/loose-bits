---
layout: post
title:  Shared JavaScript Code with AMD/RequireJS
description: The advent of JavaScript on the backend (with Node.js) has made
  fullstack JavaScript applications increasingly popular. RequireJS is
  dependency management framework that simplifies frontend asset management,
  as well as provides hooks for shared frontend (browser) and backend
  (Node.js) code. In my presentation to the November 11, 2012 Node.DC meetup,
  I introduce how to develop shared JavaScript libraries with
  AMD/RequireJS.
date: 2012-11-15 11:30:00 UTC
tags: ['node.js', 'amd', 'requirejs', 'javascript', 'meetup']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

## AMD/RequireJS

The [Asynchronous Module Definition][amd] (*AMD*) guidelines provide a
definition framework for predictable loading of JavaScript modules and
dependencies. AMD is an extension of (and possible transport for) the
[CommonJS][cjs] specification.

The [RequireJS][requirejs] library implements AMD with loading, bundling and
other functionality, so that frontend JavaScript now has sensible imports
(with `define` and `require`), instead of script includes into the global
namespace. Interestingly, as [Node.js][nodejs] implements CommonJS-style
`require`'s, there are also support modules to bring Node.js code under AMD
as well.

Take both of things together, and we have the real potential for shared
JavaScript code across the browser and server. As we use this exact approach
at work for our new Backbone.js frontend / Express Node.js backend web
application, I created a short talk that I presented at the  November 11, 2012
[Node.DC][node_dc] meetup, entitled "Shared Code with AMD/RequireJS".

[![AMD/RequireJS Talk][img_talk]][amd_talk]
[img_talk]: {{ img_dir }}/nodedc-requirejs.png

<!-- more start -->

## Source Code and Demo

The [source][amd_source] for the presentation is available on GitHub. The
repository further includes all of the [demonstation code][demo] I used to
create a shared JavaScript library and then expose it via the frontend (as
straight JavaScript) and the backend (as a REST service).

The talk and the source give a good overview and runthrough of how to implement
simple shared code, but give a better sense of the final result, here is a
RequireJS-compliant code module (for shuffling elements in a string) that has
an [underscore][underscore] dependency, as works in both browser JavaScript
and as a standard module in Node.js:

{% highlight javascript %}
// Node.js hook boilerplate.
// This adds the `define` function to Node.
if (typeof define !== 'function') {
  var define = require('amdefine')(module);
}

// Define wrapper gives us `require`
define(function(require) {
  // Looks like a normal `require` for Node.js.
  // Note: Both browser and Node.js should use
  // the **same** version of libraries.
  var _ = require('underscore');

  // Slice a string into a list of items
  // and return the shuffled values.
  var shuffle = function (val) {
    val = val || "";
    return _.shuffle(val.split(/[\s,]+/));
  };

  // Export our shuffle function by returning.
  return shuffle;
});
{% endhighlight %}

We add some boilerplate at the top of the library for Node.js, then use
the `define` function to get a `require` import function that both the browser
and Node.js can use, and we're off!

AMD, RequireJS, and shared code are topics that have a lot more depth,
features, and challenges. Hopefully this provides the start to a journey into
better JavaScript dependency management and more extensible fullstack web
application development.

[amd]: https://github.com/amdjs/amdjs-api/wiki/AMD
[cjs]: http://www.commonjs.org/
[amd_talk]: http://ryan-roemer.github.com/nodedc-requirejs-talk/
[amd_source]: https://github.com/ryan-roemer/nodedc-requirejs-talk/
[amd_demo]: https://github.com/ryan-roemer/nodedc-requirejs-talk/tree/master/demo
[node_dc]: http://www.meetup.com/node-dc/events/89233812/
[nodejs]: http://nodejs.org
[underscore]: http://underscorejs.org/

<!-- more end -->
