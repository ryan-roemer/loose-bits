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
called [Sunny.js][sunny_www]. Sunny initially supports Amazon [S3][s3] and
[Google Storage for Developers][gsfd] (the [version 1][gs_v1] "legacy"
interface).

Here are some basic resources to get started with Sunny, which we'll dive into
a little deeper in the subsequent sections of this post:

* [Sunny.js Documentation][sunny_www]: Guides and API documentation.
* [Sunny.js GitHub Page][sunny_gh]: Source repository and issue tracker.
* [Sunny.js NPM Page][sunny_npm]: NPM page and history.

<!-- more start -->

## Installation

Sunny can be installed directly from [npm][sunny_npm]:

{% highlight bash %}
$ npm install sunny
{% endhighlight %}

or from the [GitHub][sunny_gh] repository:

{% highlight bash %}
$ git clone git@github.com:ryan-roemer/node-sunny.git
$ npm install ./node-sunny
{% endhighlight %}

## Cloud Operations

### Getting Started

### Other Operations

## Error Handling

## Stream Interface

## Sunny.js Development

## Conclusion / Future

[node]: http://nodejs.org
[knox]: https://github.com/LearnBoost/knox
[node-sissy]: https://github.com/tricknik/node-sissy
[node-s3]: https://github.com/grippy/node-s3
[Node.js-Amazon-S3]: https://github.com/nuxusr/Node.js---Amazon-S3
[node-cloudfiles]: https://github.com/nodejitsu/node-cloudfiles
[jclouds]: http://www.jclouds.org/
[libcloud]: http://libcloud.apache.org/
[s3]: http://aws.amazon.com/s3/
[gsfd]: http://code.google.com/apis/storage/
[gs_v1]: http://code.google.com/apis/storage/docs/reference/v1/apiversion1.html
[cf]: http://www.rackspacecloud.com/cloud_hosting_products/files/
[os]: http://openstack.org/projects/storage/
[sunny_www]: http://sunnyjs.org
[sunny_gh]: http://github.com/ryan-roemer/node-sunny
[sunny_npm]: http://search.npmjs.org/#/sunny

<!-- more end -->
