---
layout: post
title: Rackspace Cloud Files and Servicenet
description: Examine tips, tricks and best practices with Rackspace's
  "servicenet" Cloud Files API option for free bandwidth to Cloud Servers in
  the same datacenter.
date: 2010-10-18 00:01:00 UTC
permalink: /2010/10/rackspace-cloud-files-and-servicenet.html
tags: ['cloud', 'python', 'cloud servers', 'rackspace', 'cloud files']
---

## Cloud Files, Cloud Servers

At work, we use [Rackspace][1] [Cloud Files][2] for bulk blob storage of large
sets of documents (in our case, patents).  We use a farm of Rackspace [Cloud
Servers][3] to process and serve blobs from Cloud Files.  Rackspace's offering
has been very solid to date (modulo some idiosyncrasies of their particular
APIs) and quite interestingly, the underlying software is being [released][4]
as an open source project, [OpenStack][5].

One of the nice things building a solution on Rackspace is that bandwidth is
free between Cloud Servers and Cloud Files, if properly configured.  However,
as our recent experience bears out, there are some pitfalls and caveats
towards getting everything set up correctly.

<!-- more start -->

## Public, Private Interfaces and Servicenet

Rackspace Cloud Servers are essentially Xen VMs that come with two network
interfaces: (1) a public interface on eth0 with a world-routable IP address,
and (2) a "private" interface on eth1 with an [RFC 1918][6] address.  (The
private interface isn't really "private" in the sense that any other VMs on
the same network can route to your VM, so security-wise, it should be treated
as a public, internet-facing interface).  For more details, Rackspace has
published a good [article][7] on the public and private interfaces.

For billing purposes, bandwidth between Cloud Files and a Cloud Server VM on
the public interface is charged per normal, whereas bandwidth on the private
interface is free.  To enable Cloud Files communication on the private
interface, you can either set an environment variable in your application like
follows:

    export RACKSPACE_SERVICENET=True

or programmatically specify the private network, as shown here using the
[Python Cloud Files][8] client library:

{% highlight python %}
import cloudfiles
conn = cloudfiles.get_connection("acct", "api_key", servicenet=True)
{% endhighlight %}

In both cases, "Servicenet" refers to the private interface network internal
to a Rackspace data center.

## Servicenet Gotchas

All seems pretty simple! However, when we finally enabled "servicenet=True" in
our Cloud Servers, we immediately hit errors talking to Cloud Files and
everything refused to run.  After a lot of back and forth with the Rackspace
folks, we finally found out the main issue: Servicenet only works between
Cloud Files and Cloud Servers in **the same data center**.

Before we ran into this snag, we hadn't even checked that our servers and blob
storage were in the same data center.  As it turned out, our Cloud Files
location was in Texas (DFW) and our Cloud Servers were in Chicago (ORD).  And,
after much hand-wringing, we learned that: (1) new Cloud Servers will most
likely be provisioned in Chicago, and (2) you can't easily migrate Cloud Files
accounts from Texas to Chicago.

So, how can one easily tell where your Cloud Servers and Cloud Files are, and
whether or not Servicenet will be available?  The answer for Cloud Servers is
straightforward: in the Rackspace [management dashboard][9], look at your
server list and the "Datacenter" column.  In our case, all servers list as
"ORD1", which means Chicago.  Moving on to Cloud Files, one way to figure
things out is to fire up a Python shell and issue some basic commands to see
what we have.  In all cases, looking at a connection object's
"``connection_args[0]``" value will yield a string for public interfaces like:

    storage<NUMBER>.<DATACENTER>.clouddrive.com

and on the private interface:

    snet-storage<NUMBER>.<DATACENTER>.clouddrive.com

So, on to some example code using the Python client. Here is a Chicago Cloud
Server talking to Chicago Cloud Files on the public interface:

{% highlight python %}
>>> import cloudfiles

>>> chicago_pub_conn = cloudfiles.get_connection("chicago_acct", "1234567890", servicenet=False)
>>> chicago_pub_conn.connection_args[0]
'storage101.ord1.clouddrive.com'
>>> chicago_pub_conn.list_containers()
['foo1', 'bar1', 'baz1']
{% endhighlight %}

... and on the private interface:

{% highlight python %}
>>> chicago_priv_conn = cloudfiles.get_connection("chicago_acct", "1234567890", servicenet=True)
>>> chicago_priv_conn.connection_args[0]
'snet-storage101.ord1.clouddrive.com'
>>> chicago_priv_conn.list_containers()
['foo1', 'bar1', 'baz1']
{% endhighlight %}

Now, switching to a Chicago Cloud Server talking to Texas Cloud Files on the
public interface, we get:

{% highlight python %}
texas_pub_conn = cloudfiles.get_connection("texas_acct", "1234567890", servicenet=False)
texas_pub_conn.connection_args[0]
'storage101.dfw1.clouddrive.com'
>>> texas_pub_conn.list_containers()
['foo2', 'bar2', 'baz2']
{% endhighlight %}

but, trying to talk on the private interface yields the following exception:

{% highlight python %}
>>> texas_priv_conn = cloudfiles.get_connection("texas_acct", "1234567890", servicenet=True)
>>> texas_priv_conn.connection_args[0]
'snet-storage101.dfw1.clouddrive.com'
>>> texas_priv_conn.list_containers()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/usr/local/lib/python2.6/dist-packages/cloudfiles/connection.py", line 410, in list_containers
    raise ResponseError(response.status, response.reason)
cloudfiles.errors.ResponseError: 404: Not Found
{% endhighlight %}

Confusingly, the exception raised is a 404 "Not Found", when it really should
be something more context-specific.

## Final Thoughts

The last time I chatted with the Rackspace folks, they noted most new accounts
will have both Cloud Servers and Cloud Files allocated in Chicago, so using
Servicenet should be as simple as setting the appropriate variable.  In our
specific case, we got around our Texas-Chicago split by allocating an entirely
new account that has both servers and files in Chicago, and ported over our
Texas files.  Somewhat tedious, but a worthwhile long-term investment.

But, if you are trying to use Servicenet and experience 404's or other strange
failures, you probably want to go through the above exercise and identify the
data center where your servers and blobs reside.  And, if you use Cloud
Servers and Cloud Files and aren't already using Servicenet, you definitely
should because you are paying for bandwidth that should otherwise be free!

[1]: http://www.rackspacecloud.com/
[2]: http://www.rackspacecloud.com/cloud_hosting_products/files
[3]: http://www.rackspacecloud.com/cloud_hosting_products/servers
[4]: http://techcrunch.com/2010/07/18/openstack-org-rackspace-open-sources-their-cloud-services-platform-and-gets-nasa-on-board/
[5]: http://openstack.org/
[6]: http://www.faqs.org/rfcs/rfc1918.html
[7]: http://www.rackspacecloud.com/blog/2010/02/23/networking-and-cloud-servers-more-on-the-interfaces/
[8]: http://github.com/rackspace/python-cloudfiles
[9]: https://manage.rackspacecloud.com/CloudServers/ServerList.do

<!-- more end -->