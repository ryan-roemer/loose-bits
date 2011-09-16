---
layout: post
title: Rackspace Cloud Files and Pseudo-Directories
description: Discuss Rackspace Cloud Files implied or "pseudo-" directories
  for storage objects and different API programming options.
date: 2010-12-28 19:57:00 UTC
permalink: /2010/12/rackspace-cloud-files-and-pseudo.html
tags: ['azure', 'python', 's3', 'rackspace', 'cloud files']
---

## Cloud Providers and Listing Storage Objects

Rackspace's [Cloud Files][1] provide a basic distributed blob / file
abstraction.  Like [Amazon Web Services Simple Storage Service][2] (AWS S3)
and [Microsoft Azure Blobs][3], Cloud Files are organized into a two level
hierarchy consisting of:

* **Containers**: A collection of file objects. In AWS S3 parlance this is
  called a "bucket".  For all three cloud providers, a container is a single
  collection unit that cannot be further subdivided.
* **Storage Objects**: A single file object.  In AWS S3, this is an "object",
  while in Azure this is a "blob".  A storage object for all the providers
  similarly cannot be further nested / subdivided.

Thus, there are no further levels of hierarchy than container, then object,
and for all three providers, the storage object namespace is completely flat.

As most of the world is used to nested file hierarchies much deeper than this,
cloud providers allow wide leeway in naming storage objects, most notably
allowing characters like a slash ("/").  To provide the illusion of a nested
hierarchy, [AWS S3][4] and [Azure Blobs][5] provide listing operations that
take a delimiter character to treat as a nested directory delimiter. In this
manner, calls to the list objects API will return results as if there are
intermediate directories in the (really) flat storage object namespace.

## The Old Way - Rackspace Cloud Files and Dummy Directory Objects

To much frustration, Rackspace Cloud Files did not originally provide a
delimiter query API for treating a delimiter as a nested directory organizer.
Instead of delimiter queries, Rackspace required that clients upload a storage
object of type "application/directory" at each level in which a nested pseudo-
directory was desired. Only then would the results start to resemble those
from AWS / Azure with delimiter queries.

<!-- more start -->

Here's a quick example showing how the dummy directory objects work. First
let's create a container:

{% highlight python %}
>>> import cloudfiles
>>> conn = cloudfiles.get_connection(ACCOUNT, SECRET_KEY)
>>> cont = conn.create_container("my_test_container")
>>> cont.list_objects()
[]
{% endhighlight %}

Now, put in some objects with internal slashes, and list all.

{% highlight python %}
>>> cont.create_object("foo/bar/file1.txt").write("some text.")
>>> cont.create_object("foo/bar/file2.txt").write("some text.")
>>> cont.create_object("foo/diff/file3.txt").write("some text.")
>>> cont.create_object("baz/file4.txt").write("some text.")
>>> cont.list_objects()
['baz/file4.txt',
 'foo/bar/file1.txt',
 'foo/bar/file2.txt',
 'foo/diff/file3.txt']
{% endhighlight %}

We can use the "prefix" parameter to limit files to only "foo", but the
internal pseudo-directories are not inferred.

{% highlight python %}
>>> cont.list_objects(prefix="foo")
['foo/bar/file1.txt',
 'foo/bar/file2.txt',
 'foo/diff/file3.txt']
{% endhighlight %}

The "path" parameter will infer directories, but not without internal dummy
directory objects.

{% highlight python %}
>>> cont.list_objects(path="foo")
[]
{% endhighlight %}

So, let's create the dummy objects for "foo".

{% highlight python %}
>>> dummy = cont.create_object("foo")
>>> dummy.content_type = "application/directory"
>>> dummy.sync_metadata()
>>> dummy.write("")

>>> dummy = cont.create_object("foo/bar")
>>> dummy.content_type = "application/directory"
>>> dummy.sync_metadata()
>>> dummy.write("")

>>> dummy = cont.create_object("foo/diff")
>>> dummy.content_type = "application/directory"
>>> dummy.sync_metadata()
>>> dummy.write("")
{% endhighlight %}

And, now we get the pseudo-directory results we expect for "foo" and children
paths.

{% highlight python %}
>>> cont.list_objects(path="foo")
['foo/bar',
 'foo/diff']

>>> cont.list_objects(path="foo/bar")
['foo/bar/file1.txt',
 'foo/bar/file2.txt']

>>> cont.list_objects(path="foo/diff")
['foo/diff/file3.txt']
{% endhighlight %}

While the dummy objects technically make nested pseudo-directories possible,
the onus falls to the user to create and maintain all the dummy objects. This
really becomes a pain when creating new objects that might contain nested
delimiters for which there is not already a delimiter (say adding a nested
pseudo-directory). The user then has to either check / scrub all existing
files for missing dummy objects, or create duplicate dummy directory objects
on each new object creation.

## The New Way - Rackspace Cloud Files and Delimiter Queries

Fortunately, Rackspace [finally enabled][6] "real" delimiter queries in their
list storage objects API. I couldn't actually find the date that this was
added to REST API and added server side (as the current API PDF doesn't even
note the change, although I expect it soon will).

I first noticed the new query functionality when perusing commits on the
[Python API GitHub page][7].  On Dec. 3, 2010, a [change][8] was pushed that
added the "delimiter" parameter to object listing queries for the Python API.
The Python API was incremented to version 1.7.4 for the change, so make sure
to pull the proper version of the library to test the new feature out:

{% highlight text %}
$ pip install -U https://github.com/rackspace/python-cloudfiles/tarball/1.7.4
{% endhighlight %}

Interestingly, while the container list_objects() and list_objects_info()
methods picked up a delimiter parameter, the get_objects() method did not. At
any rate, this gets the job done, and we can remove our dummy objects now to
retry our examples:

{% highlight python %}
>>> cont.delete_object("foo")
>>> cont.delete_object("foo/bar")
>>> cont.delete_object("foo/diff")
{% endhighlight %}

Let's check we don't have the dummy objects anymore:

{% highlight python %}
>>> cont.list_objects()
['baz/file4.txt',
 'foo/bar/file1.txt',
 'foo/bar/file2.txt',
 'foo/diff/file3.txt']
{% endhighlight %}

And now, let's try equivalent queries using the prefix and delimiter
parameters. (Note that you must append an extra slash (e.g. "foo/", not "foo")
for the queries to work.)

{% highlight python %}
>>> cont.list_objects(prefix="foo/", delimiter="/")
['foo/bar/',
 'foo/diff/']

>>> cont.list_objects(prefix="foo/bar/", delimiter="/")
['foo/bar/file1.txt',
 'foo/bar/file2.txt']

>>> cont.list_objects(prefix="foo/diff/", delimiter="/")
['foo/diff/file3.txt']
{% endhighlight %}

... and we finally get the results we want without having to track or create
any extraneous objects.

At the time of this post, many clients do not take advantage of more
convenient / advanced object querying. The [CyberDuck][9] client currently
will only display pseudo-directories via the dummy directory objects method.
In fact, Rackspace's own control panel doesn't display any pseudo-directories
using either the old dummy directory or new delimiter methods. So, hopefully
with the new delimiter query API support, some folks out there will make some
New Year's resolutions to improve pseudo-directory support in Cloud Files
clients.

[1]: http://www.rackspacecloud.com/cloud_hosting_products/files/
[2]: http://aws.amazon.com/s3/
[3]: http://msdn.microsoft.com/en-us/library/dd135733.aspx
[4]: http://docs.amazonwebservices.com/AmazonS3/latest/API/index.html?RESTBucketGET.html
[5]: http://msdn.microsoft.com/en-us/library/dd135734.aspx
[6]: http://www.rackspacecloud.com/blog/2010/12/21/rackspace-cloud-files-a-look-back-at-2010/
[7]: https://github.com/rackspace/python-cloudfiles
[8]: https://github.com/rackspace/python-cloudfiles/commit/f37b51af1372f428918ac289e7062d7c4a9369b5
[9]: http://cyberduck.ch/

<!-- more end -->