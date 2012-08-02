---
layout: post
title:  Better Data Slinging with Node.js Readable/Writable Streams
description: Node.js streams offer efficient and programmer-friendly means
  of binding together data inputs and outputs. Writing your own readable
  and/or writable streams can provide an enormous amount of flexibility and
  power over normal callback-style data wrangling, and all without too much
  extra programming effort.
date: 2012-08-02 12:00:00 UTC
tags: ['node.js', 'javascript', 'streams']
---

## Node.js Streams

[Node.js][nodejs] provides a solid, efficient runtime for web servers,
proxies and middle-tier services, among other things. Common use cases include
binding and transforming data in one form (e.g., a database or cloud store) to
another (e.g., an HTML or JSON page).

Everyone is familiar with the callback-style of hooking together various
JavaScript data components in a Node.js program, but one of the most powerful
abstractions for data slinging are Node.js [streams][streams].

Streams are an abstract interface for data objects in Node.js which can be
readable and/or writable. Some examples of implementing classes in the Node.js
core library include HTTP, HTTPS, file I/O, and stdout. Some of the advantages
of streams over callback-style bindings include:

* Often much less code for the actual binding (can just push into a `pipe()`).
* Streams can handle pausing / resuming of data flows.
* Can immediately process data and re-emit it to another stream (unless the
  data requires having **all** of it first, in which case you can't avoid
  buffering).
* Works well with a lot of the Node.js core library that already implements
  streams.

For a brief example, say we create a download client to retrieve
a web page and write it to a file, our code (ignoring error-handling) could
look something like this:

{% highlight javascript %}
// Download a web page to a local file.
var http = require('http');

// Get Google's home page.
http.get("http://www.google.com/", function(response) {
  // The callback provides the response readable stream.
  // Then, we open our output text stream.
  var outStream = require('fs').createWriteStream("out.txt");

  // Pipe the input to the output, which writes the file.
  response.pipe(outStream);
});
{% endhighlight %}

We essentially have two stream objects: `response` and `outStream`. We hook
the output of `response` to the input of `outStream` with `pipe()`. More
importantly (as we'll get to below), we can add many more `pipe()` calls to
do other transformations / data-slinging inline to our single call here.
And, the example code above is quite terse, and more importantly, we don't
have to do any data buffering or storage, instead relying on the implemented
streams to do it themselves.

## The Stream Interfaces

So how do we do this for our own classes and objects?

The Node.js [streams][streams] documentation gives the full rundown of
implementing streams, but we'll go for an abbreviated version here to get
going.

### Readable Streams




- Reqs for read
- Reqs for write


## A Custom Stream Example

- Upper Stream.
- Conclusion and parting thoughts.


- Other reading
  - "Why Node.js Streams are Awesome" http://blog.dump.ly/post/19819897856/why-node-js-streams-are-awesome
  - "How to Use stream.pipe" http://docs.jit.su/articles/advanced/streams/how-to-use-stream-pipe
  - "Streams, Pipes and Mega Pipes" http://felixge.s3.amazonaws.com/11/nodejs-streams.pdf
  - "Node Streams: How do they work?" http://maxogden.com/node-streams

- TODO HERE -- Ogden -- Need return true also???

[streams]: http://nodejs.org/api/stream.html
[nodejs]: http://nodejs.org
