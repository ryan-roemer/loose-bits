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
data binding abstractions for Node.js are [streams][streams].

Streams are an abstract interface for data objects in Node.js which can be
readable and/or writable. And, they can be hooked from one to another, in
a similar style to Unix pipes -- in fact, the stream operation we'll mostly
focus on here is the not-coincidentally-named `pipe()`. Some of the advantages
of streams over callback-style bindings include:

* Often much less code for the actual binding (can just push into a `pipe()`).
* Streams can handle pausing / resuming of data flows.
* Can immediately process data and re-emit it to another stream (unless the
  data requires having **all** of it first, in which case you can't avoid
  buffering).
* Works well with a lot of the Node.js core library that already implements
  streams, including HTTP, HTTPS, and file and process I/O.

For a brief example, say we create a download client to retrieve
a web page and write it to a file, our code (ignoring error-handling) could
look something like this:

{% highlight javascript %}
// Get Google's home page.
require('http').get("http://www.google.com/", function(response) {
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

<!-- more start -->

The Node.js [streams][streams] documentation gives the full rundown of
implementing streams, but we'll go for an abbreviated version here to get
going.

### Readable Streams

[Readable Streams][read_stream] must emit "`data`" events whenever they have
data to be read and "`end`" when the data stream is finished. The implementing
constructor should also set `this.readable = true`. The interface
additionally provides a lot more implementer flexibility for things like
pausing and resuming a stream, as well as resource management and cleanup.

### Writable Streams

[Writable Streams][write_stream] must implement the `write()` method to
accept new data chunks into the stream and the `end()` method to instruct the
stream to close up. The implementing constructor should also set
`this.writable = true`.

### Putting it Together

Let's take a look at a simple example of a custom-implemented readable and
writable stream that simply passes through data -- data written is simply
emitted straight out.

{% highlight javascript %}
// Set both readable and writable in constructor.
var NopStream = function () {
  this.readable = true;
  this.writable = true;
};

// Inherit from base stream class.
require('util').inherits(NopStream, require('stream'));

// Extract args to `write` and emit as `data` event.
NopStream.prototype.write = function () {
  args = Array.prototype.slice.call(arguments, 0);
  this.emit.apply(this, ['data'].concat(args))
};

// Extract args to `end` and emit as `end` event.
NopStream.prototype.end = function () {
  args = Array.prototype.slice.call(arguments, 0);
  this.emit.apply(this, ['end'].concat(args))
};
{% endhighlight %}

This is essentially the bare minimum for a readable and writable stream class.
Not too much work! And for more complicated streams, we can simply augment
`write`/`data` and `end`/`end` to do whatever data transformations we want.

We can now take the web scraping example from above and add the passthrough
stream in the middle with the same effect -- we still get a file written to
output.

{% highlight javascript %}
// Download the same page again, but with the NOP stream
// in the middle.
require('http').get("http://www.google.com/", function(response) {
  var outStream = require('fs').createWriteStream("out.txt");

  response
    .pipe(new NopStream())
    .pipe(outStream);
});
{% endhighlight %}

And in fact, we could even reuse the passthrough stream multiple times to
illustrate repeated `pipe()` data flows (although there's absolutely no
practical sense to the following):

{% highlight javascript %}
response
  // Wow, that's a lot of nop's!
  .pipe(new NopStream())
  .pipe(new NopStream())
  .pipe(new NopStream())
  .pipe(new NopStream())
  // OK, finally write out to file.
  .pipe(outStream);
{% endhighlight %}

So that's the basics. Let's look at creating something a tad more useful.

## A Custom Stream Example

**TODO HERE**

- Upper Stream.
- Conclusion and parting thoughts.


## Conclusion

Streams provide a great means of binding together lots of data in a sane and
manageable way. Beyond the core library documents, there are a lot of great
stream introductions for further reference:

- ["Why Node.js Streams are Awesome"][art_awesome]
- ["How to Use stream.pipe"][art_howto]
- ["Streams, Pipes and Mega Pipes"][art_mega]
- ["Node Streams: How do they work?"][art_how]

[streams]: http://nodejs.org/api/stream.html
[nodejs]: http://nodejs.org
[art_awesome]:http://blog.dump.ly/post/19819897856/why-node-js-streams-are-awesome
[art_howto]:http://docs.jit.su/articles/advanced/streams/how-to-use-stream-pipe
[art_mega]:http://felixge.s3.amazonaws.com/11/nodejs-streams.pdf
[art_how]:http://maxogden.com/node-streams
[read_stream]: http://nodejs.org/api/stream.html#stream_readable_stream
[write_stream]: http://nodejs.org/api/stream.html#stream_writable_stream

<!-- more end -->
