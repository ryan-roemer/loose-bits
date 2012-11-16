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

The [source][amd_source] for the presentation is available on GitHub. The
repository further includes all of the demonstation code I used to create
a shared JavaScript library and then expose it via the frontend (as straight
JavaScript) and the backend (as a REST service).

<!-- more start -->


[amd]: https://github.com/amdjs/amdjs-api/wiki/AMD
[cjs]: http://www.commonjs.org/
[amd_talk]: http://ryan-roemer.github.com/nodedc-requirejs-talk/
[amd_source]: https://github.com/ryan-roemer/nodedc-requirejs-talk/
[node_dc]: http://www.meetup.com/node-dc/events/89233812/
[nodejs]: http://nodejs.org

<!-- more end -->
