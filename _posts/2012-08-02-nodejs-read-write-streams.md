---
layout: post
title:  Better Data Slinging with Node.js Readable/Writable Streams
description: Node.js streams offer efficient and programmer-friendly means
  of binding together data inputs and outputs. Writing your own readable
  and/or writable streams can provide an enormous amount of flexibility and
  power over normal callback-style data wrangling, and all without too much
  extra programming effort.
date: 2012-08-02 14:00:00 UTC
tags: ['node.js', 'javascript', 'streams', 'data']
---

## Node.js Streams

[Node.js][nodejs] provides a solid, efficient platform for web servers,
proxies and middle-tier services, among other things. Common use cases include
binding and transforming data in one form (e.g., a database or cloud store) to
another (e.g., an HTML or JSON page).

Everyone is familiar with the callback-style of hooking together various
JavaScript data components in a Node.js program, but one of the most powerful
data binding abstraction for Node.js is the [stream][streams] class.

Streams are an abstract interface for data objects in Node.js which can be
readable and/or writable. And, they can be hooked from one to another, in
a similar style to Unix pipes -- in fact, the stream operation we'll mostly
focus on here is the not-coincidentally-named `pipe()`. Some of the advantages
of streams over callback-style bindings include:

* Often much less code for the actual binding (can just push into a `pipe()`).
* Streams can handle pausing / resuming of data flows.
* Can avoid buffering by processing data and re-emitting it directly to another
  stream (unless all of the data is required before transformations).
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

We can now take the web scraping example from above and add the pass-through
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

Checking the output file ("out.txt"), we can see the download results are the
same as our original example.

And in fact, we could even reuse the pass-through stream multiple times to
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

Here is a custom stream class that takes a data source (in string or `Buffer`
format) and converts the string data into upper case letters. Not ultimately
that useful or extensible, but it's definitely a data transformation that can
illustrate the ease of creation and use of a custom stream.

We mostly take our simple pass-through stream above and add a custom
`_transform` helper method to transform the data in either a `write()` or
`end()` call, then re-emit the upper-cased data in a `data` event.

{% highlight javascript %}
/**
 * A simple upper-case stream converter.
 */
var UpperCaseStream = function () {
  this.readable = true;
  this.writable = true;
};

require("util").inherits(UpperCaseStream, require("stream"));

/**
 * Handle various params and upper-case string data.
 *
 * Signature can be in format of:
 *  - string, [encoding]
 *  - buffer
 *
 * Our example implementation hacks the data into a simpler
 # (string) form -- real implementations would need more.
 */
UpperCaseStream.prototype._transform = function (data) {
  // Here, we'll just shortcut to a string.
  data = data ? data.toString() : "";

  // Upper-case the string and emit data event with transformed data.
  this.emit("data", data.toUpperCase());
};

/**
 * Stream write (override).
 */
UpperCaseStream.prototype.write = function () {
  this._transform.apply(this, arguments);
};

/**
 * Stream end (override).
 */
UpperCaseStream.prototype.end = function () {
  this._transform.apply(this, arguments);
  this.emit("end");
};
{% endhighlight %}

To test things out, we can take an input file ("input.txt"), read it in,
upper case all text, then write it out to "out.txt" using three streams.

{% highlight javascript %}
var fs = require("fs"),
  input = fs.createReadStream("input.txt"),
  output = fs.createWriteStream("out.txt"),
  upperCase = new UpperCaseStream();

// Open our read input, uppercase it, then write out.
input
  .pipe(upperCase)
  .pipe(output);
{% endhighlight %}

The resulting output file is now uppercased! All in all, not that amazing,
but considering the ease of our implementation, other (more useful)
read/write stream applications could include:

* CXML to JSON conversion.
* Unzipping zipped data.
* Image resizing.
* ... any other transformations you'd like to use with your existing streams.

## Conclusion

Streams provide a great means of binding together lots of data in a sane and
manageable way. Beyond the core library documents, there are a lot of great
stream introductions for further reference:

* ["Why Node.js Streams are Awesome"][art_awesome]
* ["How to Use stream.pipe"][art_howto]
* ["Streams, Pipes and Mega Pipes"][art_mega]
* ["Node Streams: How do they work?"][art_how]

[streams]: http://nodejs.org/api/stream.html
[nodejs]: http://nodejs.org
[art_awesome]:http://blog.dump.ly/post/19819897856/why-node-js-streams-are-awesome
[art_howto]:http://docs.jit.su/articles/advanced/streams/how-to-use-stream-pipe
[art_mega]:http://felixge.s3.amazonaws.com/11/nodejs-streams.pdf
[art_how]:http://maxogden.com/node-streams
[read_stream]: http://nodejs.org/api/stream.html#stream_readable_stream
[write_stream]: http://nodejs.org/api/stream.html#stream_writable_stream

<!-- more end -->
