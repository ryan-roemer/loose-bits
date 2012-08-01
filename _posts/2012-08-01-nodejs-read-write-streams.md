---
layout: post
title:  Node.js Readable/Writable Streams
description: TODO
date: 2012-08-01 00:00:00 UTC
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
core library include HTTP, HTTPS, file I/O, and stdout.

For a brief, pseudo-code example, say we create a download client to retrieve
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

The real beauty of streams come from the use of `pipe()`, which hooks the data
output of one stream to the input of the next. Our code above is extremely
terse, and more importantly, we don't have to do any data buffering or storage,
instead relying on the implemented streams to do it themselves.


- Reqs for read
- Reqs for write

[streams]: http://nodejs.org/api/stream.html
[nodejs]: http://nodejs.org
