---
layout: post
title: Sunny.js Presentation and Demo Server
description: My presentation on the Sunny.js cloud library for the DC Node.js
 October meetup. Also includes a simple web proxy server (backed by a cloud
 datastore) for gluing together cloud and HTTP web requests.
date: 2011-10-20 16:00:00 UTC
tags: ['sunny', 'node.js', 'heroku', 'cloud', 'amazon', 'aws', 's3',
       'google storage']
---
{% capture sunny_prezi %}http://prezi.com/tlaj11poclwg/sunnyjs/{% endcapture %}

## Sunny.js Presentation

I gave a lightning talk at last night's [Node.js Meetup][meetup] introducing
[Sunny.js][sunny_www], a multi-cloud library for [Node.js][node]. For more
background on Sunny, see my previous [blog post][sunny_post] to get started
with the library.

Instead of the usual PowerPoint deck, I used [Prezi][prezi], which I have
been wanting to try out for some time. Here is the
[Sunny.js prezi][sunny_prezi] I gave at the meetup:

<div class="prezi-player">
  <style type="text/css" media="screen">
    .prezi-player {
      width: 500px;
      margin-left: auto;
      margin-right: auto;
    }
    .prezi-title {
      margin-top: 10px;
      font-size: 1.25em;
      text-align: center;
    }
  </style>
  <object id="prezi_tlaj11poclwg" name="prezi_tlaj11poclwg" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="500" height="350">
    <param name="movie" value="http://prezi.com/bin/preziloader.swf"/>
    <param name="allowfullscreen" value="true"/>
    <param name="allowscriptaccess" value="always"/>
    <param name="bgcolor" value="#ffffff"/>
    <param name="flashvars" value="prezi_id=tlaj11poclwg&amp;lock_to_path=0&amp;color=ffffff&amp;autoplay=no&amp;autohide_ctrls=0"/>
    <embed id="preziEmbed_tlaj11poclwg" name="preziEmbed_tlaj11poclwg" src="http://prezi.com/bin/preziloader.swf" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="500" height="350" bgcolor="#ffffff" flashvars="prezi_id=tlaj11poclwg&amp;lock_to_path=0&amp;color=ffffff&amp;autoplay=no&amp;autohide_ctrls=0"/>
  </object>
  <div class="prezi-title">
    <a href="{{ sunny_prezi }}">Sunny.js Meetup Presentation</a>
  </div>
</div>

Although the Prezi took some time to put together (especially being my first
time using the service), I was very happy with the appearance and flow of the
presentation.

## Simple Cloud/Web Proxy Server

As part of my presentation, I demo'ed a simple proxy service using Sunny and
Node. I took the v0.0.1 HTML documentation for Sunny, and uploaded all of it
to an Amazon [S3][s3] bucket, being careful to preserve paths from the original
documentation files when naming S3 keys. (Actually, this wasn't hard at all --
I just used the reliable [CyberDuck][cyberduck] S3 client).

I then wrote a really simple 40-line web server. It basically takes credentials
from the process environment, checks if a specified container exists, and
then translates web request GET paths to blob names in the container I set
up. The result is that I could serve my entire documentation site straight
from by Amazon S3 bucket!

The source for the project, [sunny-proxy][sunny_proxy], is available on GitHub,
and is fairly straightforward to setup for yourself using the Readme
instructions.

<!-- more start -->

For the impatient, here's the entire relevant code for the web server:

{% highlight javascript %}
var http = require('http'),
  mime = require('mime'),
  sunny = require('sunny'),
  conn = sunny.Configuration.fromEnv().connection,
  ADDR = process.env.ADDRESS || "0.0.0.0",
  PORT = process.env.PORT || 2000,
  CONTAINER = process.env.SUNNY_PROXY_CONTAINER;

// Get our container and create server inside to get blobs.
conn.getContainer(CONTAINER, { validate: true })
  .on('error', function (err) {
    console.log(err);
    throw err;
  })
  .on('end', function (results) {
    // We have a valid container, so let's create the server now.
    http.createServer(function (req, res) {
      var path = req.url.replace(/\/$/, "/index.html").replace(/^\/*/, ""),
        status = 200,
        logResult = function () {
          console.log("[%s] %s", status, path); },
        stream;

      // Header based on MIME type (re-write on error).
      res.writeHead(status, { 'content-type': mime.lookup(path) });

      // Get blob and pass through error or pipe to response.
      stream = results.container.getBlob(path);
      stream.on('error', function (err) {
        status = err.statusCode || 500;
        res.writeHead(status, { 'content-type': "text/html" });
        res.end("<h1>" + status + ": " + err.message + "</h1>");
        logResult();
      });
      stream.on('end', logResult);
      stream.pipe(res);
      stream.end();
    }).listen(PORT, ADDR);
    console.log("Server running at http://%s:%s/", ADDR, PORT);
  })
  .end();
{% endhighlight %}

We use the magic of ``stream.pipe(res)`` to handle all of the transfer details
of passing through our blob data chunks to the HTTP response.

I even took it a step further and set up a simple [Heroku][heroku] app to run
the application. All it took was a quick review of the
[Node app instructions][heroku_node] and a "Procfile" file (mine is available
in the GitHub repo) and I was able to get my node proxy server up and running
on the web in under a half hour! Moreover, I was pleasantly surprised at
how fast the web application was running -- especially considering the web
server doesn't use any caching logic or any intelligent optimizations that
a real web server would.

The Sunny-based proxy server certainly isn't anything amazing or
revolutionary -- it just serves blobs as if they were static files for a
web server -- but it does show just how easily Node.js and libraries like
Sunny can glue cloud / service-based components together for fast and
scalable applications.

[cyberduck]: http://cyberduck.ch/
[heroku]: http://www.heroku.com/
[heroku_node]: http://devcenter.heroku.com/articles/node-js
[meetup]: http://nodedc-october-eorg.eventbrite.com/
[node]: http://nodejs.org
[prezi]: http://prezi.com
[s3]: http://aws.amazon.com/s3/
[sunny_post]: http://loose-bits.com/2011/10/16/node-sunny-cloud-library.html
[sunny_prezi]: {{ sunny_prezi }}
[sunny_proxy]: https://github.com/ryan-roemer/sunny-proxy
[sunny_www]: http://sunnyjs.org

<!-- more end -->
