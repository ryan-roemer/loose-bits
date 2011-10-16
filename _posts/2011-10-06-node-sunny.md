---
layout: post
title: Sunny.js, a Cloud Library for Node.js
description: Sunny.js is a cloud datastore client for Node.js that provides
  an event-based interface to various cloud stores (AWS S3, Google Storage) for
  fast, cloud-agnostic programming. It includes Node.js niceties such as a
  Read/WriteStream implementation, and offers cloud features like arbitrary
  metadata / request headers and SSL support.
date: 2011-10-06 16:00:00 UTC
tags: ['sunny', 'node.js', 'cloud', 's3', 'aws', 'google storage']
---

## Sunny.js

[Node.js][node] provides a great environment for cloud applications and
development. Node's asynchronous design and great HTTP/REST support provide
the building blocks for architecting non-blocking and scalable applications
in the cloud.

There are a lot of great Node cloud clients out there for cloud datastores.
Amazon Web Services [S3][s3] has: [knox][knox], [node-sissy][node-sissy],
[node-s3][node-s3], [Node.js-Amazon-S3][Node.js-Amazon-S3],
And, Rackspace [Cloud Files][cf] has: [node-cloudfiles][node-cloudfiles].

After reviewing these libraries, I found a few features variously lacking that
I would like in an ideal cloud datastore client:

* Able to create / delete containers (buckets).
* "One-shot" requests wherever possible.
* Configurable request headers, cloud options and metadata.
* SSL support.
* Event-based interface.

Additionally, it would be nice to have a library that worked across multiple
clouds like [jclouds][jclouds] for Java and [Libcloud][libcloud] for Python.

With these goals in mind, I put together a basic multi-cloud datastore client
called [Sunny.js][sunny_www]. Sunny initially supports
[Amazon Web Service][aws]'s [Simple Storage Service][s3] (S3) and
[Google Storage for Developers][gsfd] ([version 1][gs_v1]).

Here are some basic resources to get started with Sunny, which we'll dive into
a little deeper in the subsequent sections of this post:

* [Sunny.js Documentation][sunny_www]: Guides and API documentation.
* [Sunny.js GitHub Page][sunny_gh]: Source repository and issue tracker.
* [Sunny.js NPM Page][sunny_npm]: NPM page and history.

<!-- more start -->

## Getting Started

First, install sunny from [npm][sunny_npm]:

{% highlight bash %}
$ npm install sunny
{% endhighlight %}

Once Sunny is installed, we need to set up some configuration information for
our Node program. We can provide cloud account and option information to
Sunny either via the process environment or a JavaScript object / file.
For simplicity, we'll just export some environment variables (see the
[user guide][sunny_guide] for more on configuration and using files).

{% highlight bash %}
$ export SUNNY_PROVIDER=("aws"|"google")
$ export SUNNY_ACCOUNT="ACCOUNT_NAME"
$ export SUNNY_SECRET_KEY="ACCOUNT_SECRET_KEY"
$ export SUNNY_SSL=("true"|"false")
{% endhighlight %}

From here, we can create our Node program, and get a live cloud datastore
[connection][sunny_conn] as follows:

{% highlight javascript %}
var sunny = require("sunny"),
  conn = sunny.Configuration.fromEnv().connection;
{% endhighlight %}

## Cloud Operations

Now that we have our cloud connection object (``conn``), we can perform all of
our cloud operations on containers and blobs. For those used to Amazon Web
Services parlance, a Sunny container is equivalent to an S3 "bucket", and a
Sunny blob is an S3 "key".

Sunny cloud operations are asynchronous and event-based. The cloud methods
return either a request or a stream object, that is then used to set
listeners and callbacks on, before calling ``end()`` and starting the
underlying real cloud network operation.

### Requests

Sunny request objects are not true Node request objects, but approximate
a subset of a Node HTTP request object events. The most common request events
are:

* **"error"**: The underlying real cloud operation failed.
* **"end"**: The operation finished and we have results.
* **"data"**: A GET request returned a data chunk.

Let's perform a basic asynchronous operation to get a container named
"sunny" from our cloud store.

{% highlight javascript %}
var request = conn.getContainer("sunnyjs", { validate: true });
request.on('error', function (err) {
  console.log("We received error: %s", err);
});
request.on('end', function (results, meta) {
  var container = results.container;
  console.log("Retrieved container \"%s\".", container.name);
});
request.end();
{% endhighlight %}

which gives us the output:

{% highlight text %}
Retrieved container "sunnyjs".
{% endhighlight %}

Breaking the code down, we call ``getContainer`` with the container name
and the option ``validate: true``. The validate option means we actually
perform a cloud request to check the container exists before continuing.
This is a good check to start with before launching in to other code. But,
Sunny allows the programmer to choose to not validate, and wait for the first
blob request to actually perform any network operation, which is faster.

The ``getContainer`` method returns a ``request`` object, which we then set
our listeners on for "error" and "end" (when we have results). Finally, the
call to ``request.end()`` initiates the actual network operation.

Our "end" callback takes a ``results`` parameter which contains a
``container`` method for further use with blob methods, and a ``meta`` object
with information from the actual cloud call (metadata, HTTP headers, etc.)
See the [``getContainer``][sunny_getContainer] documentation for more options,
results and uses.

The other request-based Sunny methods work in a similar fashion, and include
the following:

* **Connection**: Get a list of containers. Get/create/delete a single
  container.
* **Container**: Get/create/delete a single container. Get a list of blobs.
  Head/delete a single blob. Get/put blob to/from a file.
* **Blob**: Head/delete a single blob. Get/put blob to/from a file.

See the [API][sunny_api] for full method details.

### Streams

Sunny returns stream objects for data-based cloud operations (PUT or GET),
which are real implementations of Node [streams][node_streams]. A GET blob
method returns a [Readable Stream][node_rs] object, and a PUT blob method
returns a [Writable Stream][node_ws] object.





* TODO: GetBlob operation (maybe start with PutBlob).
* TODO: Mention ``pipe()``'s and why they're nice.
* TODO: What can we do with streams? Answer: sunny-proxy

API:

    getBlob(name, options): Create blob object and GET data.
    getBlobToFile(name, filePath, options): Create blob object and GET data to file.
    putBlob(name, options): Create blob object and PUT data.
    putBlobFromFile(name, filePath, options): Create blob object and PUT data from file.

## Error Handling

* TODO: Testing isNotFound(), etc. Abstracts away error codes.

## Conclusion / Future

* TODO: More cloud providers.
* TODO: Development help is welcome.


[aws]: http://aws.amazon.com/
[cf]: http://www.rackspacecloud.com/cloud_hosting_products/files/
[gsfd]: http://code.google.com/apis/storage/
[gs_v1]: http://code.google.com/apis/storage/docs/reference/v1/apiversion1.html
[jclouds]: http://www.jclouds.org/
[knox]: https://github.com/LearnBoost/knox
[libcloud]: http://libcloud.apache.org/
[node-cloudfiles]: https://github.com/nodejitsu/node-cloudfiles
[node-s3]: https://github.com/grippy/node-s3
[node-sissy]: https://github.com/tricknik/node-sissy
[Node.js-Amazon-S3]: https://github.com/nuxusr/Node.js---Amazon-S3
[node]: http://nodejs.org
[node_rs]: http://nodejs.org/docs/v0.4.9/api/streams.html#readable_Stream
[node_streams]: http://nodejs.org/docs/v0.4.9/api/streams.html
[node_ws]: http://nodejs.org/docs/v0.4.9/api/streams.html#writable_Stream
[os]: http://openstack.org/projects/storage/
[s3]: http://aws.amazon.com/s3/
[sunny_api]: http://sunnyjs.org/api/index.html
[sunny_conn]: http://sunnyjs.org/api/symbols/base.Connection.html
[sunny_getContainer]: http://sunnyjs.org/api/symbols/base.Connection.html#getContainer
[sunny_gh]: http://github.com/ryan-roemer/node-sunny
[sunny_guide]: http://sunnyjs.org/guide.html
[sunny_npm]: http://search.npmjs.org/#/sunny
[sunny_www]: http://sunnyjs.org

<!-- more end -->
