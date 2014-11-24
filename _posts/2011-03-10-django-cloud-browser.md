---
layout: post
title: Django Cloud Browser
description: Introducing Django Cloud Browser, a portable Django application
  for viewing and navigating a cloud (AWS, Rackspace, etc.) datastore, with
  admin / normal user interfaces, and pseudo-directory inference.
date: 2011-03-10 05:44:00 UTC
permalink: /2011/03/django-cloud-browser.html
tags: ['openstack', 'django', 'cloud', 'python', 's3', 'rackspace', 'aws',
       'cloud files']
---
{% capture img_dir %}{{ site.url }}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}

## Introduction

I recently pushed the v.0.1.2 release of my new Django application, django-
cloud-browser, to [PyPi][1]. Cloud Browser is a simple web-based file browser
for cloud-based datastores, which so far includes [Amazon S3][2], Rackspace
[Cloud Files][3] (including [OpenStack][4]) and local file system. The
application can expose read-only cloud files to users and/or administrators
with configurations for both normal and administrative deployments.

The basic reference points to get started include:

* [Cloud Browser API / documentation][5]
* [GitHub page][6]
* [PyPi page][7]

## Background

At work, we have some containers with very large numbers of objects -- over 5
million and counting. While objects ultimately are named in a flat namespace,
we divide up the namespace with slashes (e.g.,
"path/to/cloud/object/file.txt"). Nearly all cloud providers (Amazon S3,
Microsoft Azure, and Rackspace) include functionality in their object APIs to
return results grouped around hierarchical "implied" or "pseudo-" directory
objects based on a separator (like the slash that we use).

Despite the fact that Rackspace's underlying [REST][8] and [Python][9] APIs
both support implying directories from a delimiter like a slash, Rackspace's
own [management console][10] will only display objects using a completely flat
namespace. As an example, I have an old side project where I stored US patent
data in XML form in both Rackspace Cloud Files and Amazon S3, and broke up
each object with a slash-delimited path. (I have obscured my bucket /
container names in all of the screen shots in this post). Let's view the
objects in the Rackspace container using their web interface:

<!-- more start -->

[![Rackspace control panel][img_rs_th]][img_rs]
[img_rs_th]: {{ img_dir }}/rackspace_thumb.png
[img_rs]: {{ img_dir }}/rackspace.png

Thus, you have to wade through multiple pages of flat objects to find one you
are looking for, and all of the work in sectioning out the object namespace
has basically gone to waste.

By contrast, Amazon's [web dashboard][11] for S3, will imply
pseudo-directories, as we can see from the analogous view in S3:

[![AWS web dashboard][img_aws_th]][img_aws]
[img_aws_th]: {{ img_dir }}/aws_thumb.png
[img_aws]: {{ img_dir }}/aws.png

Given the hassles with trying to browse our millions of objects in the
Rackspace dashboard, I finally decided to bite the bullet and just code up a
Django application to do the job (such that I could easily integrate it into
our system at work). A few months later, I finally hacked together a first
version of the ``django-cloud-browser`` application.

## Django Cloud Browser

At a high level, Cloud Browser application exposes containers and objects in a
Cloud datastore to users or administrators. Let's look at a basic example:

### Basic Deployment

On your system, first install the application:

{% highlight text %}
$ pip install django-cloud-browser
{% endhighlight %}

Then, edit your Django "settings.py".  Here, I'm setting up a Rackspace Cloud
Files account for browsing:

{% highlight python %}
INSTALLED_APPS = (
    # ...
    'cloud_browser',
)

CLOUD_BROWSER_DATASTORE = "Rackspace"
CLOUD_BROWSER_RACKSPACE_ACCOUNT = "<my_account>"
CLOUD_BROWSER_RACKSPACE_SECRET_KEY = "<my_secret_key>"
{% endhighlight %}

Next, add the URLs to your "urls.py":

{% highlight python %}
urlpatterns = patterns('',
    # ...
    url(r'^cb/', include('cloud_browser.urls')),
)
{% endhighlight %}

And start up your Django project! You should be able to click through
container and object navigation links, as well as page results when they are
over the maximum number of objects per page (configurable via
``CLOUD_BROWSER_DEFAULT_LIST_LIMIT``, but defaults to 20 objects). Here is my
navigation into the same Rackspace object as before, but now the objects have
implied pseudo-directories.

[![Basic Cloud Browser][img_basic_th]][img_basic]
[img_basic_th]: {{ img_dir }}/cb_basic_thumb.png
[img_basic]: {{ img_dir }}/cb_basic.png

Objects that lead to ultimate files will be downloaded / displayed when
clicked. Breadcrumb links are displayed along the top of the page as well.

The application even figures out and sets appropriate headers for content type
and content encoding, which means, e.g., that compressed files will be
uncompressed on the fly by browsers that support the compression scheme. At
this point, it is worth noting that all access through Cloud Browser is
read-only, although in the future we will look to enhancements like uploads,
metadata retrieval / modification, etc.

### Configuration Options

#### Other Datastores

In addition to Rackspace Cloud Files, the application supports Amazon S3 as
well as the local file system (with a mock container / objects scheme imposed
on real directories and files).  Examples:

{% highlight python %}
# AWS S3
CLOUD_BROWSER_DATASTORE = "AWS"
CLOUD_BROWSER_AWS_ACCOUNT = "<my_account>"
CLOUD_BROWSER_AWS_SECRET_KEY = "<my_secret_key>"
{% endhighlight %}

and

{% highlight python %}
# Local filesystem
CLOUD_BROWSER_DATASTORE = "Filesystem"
CLOUD_BROWSER_FILESYSTEM_ROOT = "/usr/share/doc"
{% endhighlight %}

#### White / Black Lists

By default, all containers and all objects are browsable. However, the
application supports basic white and black lists at the container level. If a
whitelist is specified, only those containers will be browsable.

{% highlight python %}
CLOUD_BROWSER_CONTAINER_WHITELIST = (
    'my_container',
    'more_stuff',
)
{% endhighlight %}

If a blacklist is specified, only those containers are excluded from browsing.

{% highlight python %}
CLOUD_BROWSER_CONTAINER_BLACKLIST = (
    'secret_stuff',
    'archive',
)
{% endhighlight %}

If both are specified, access is effectively only what is allowed by the
whitelist.

#### View Decorators

The settings variable ``CLOUD_BROWSER_VIEW_DECORATOR`` can be set to a function
(e.g., a decorator) that wraps all browsing views.  Setting this to Django's
``login_required`` decorator permits only logged-in users to use the Cloud
Browser.

#### Static Media

Cloud Browser contains a minimal amount of CSS and JavaScript. If you set up
Django to statically serve these files, then set the
``CLOUD_BROWSER_STATIC_MEDIA_DIR`` variable to the relative path from
``settings.MEDIA_ROOT``. The application has a fallback where if this is
not set, the CSS / JavaScript will be included (inefficiently) in the HTML of
each application view. See the documentation for further details.

### Admin Deployment

Cloud Browser also allows for integration with the Django admin.  Here, we
just make a simple change to our "urls.py":

{% highlight python %}
urlpatterns = patterns('',
    # ...
    # Admin URLs. Note: Include ``urls_admin`` **before** admin.
    url(r'^admin/cb/', include('cloud_browser.urls_admin')),
    url(r'^admin/', include(admin.site.urls)),
)
{% endhighlight %}

It is also a really good idea to manually set the "staff required" decorator
in "settings.py" to mirror the other admin view restrictions:

{% highlight python %}
from django.contrib.admin.views.decorators import staff_member_required
CLOUD_BROWSER_VIEW_DECORATOR = staff_member_required
{% endhighlight %}

And here's the same view as above in the admin:

[![Cloud Browser admin (open)][img_admin_open_th]][img_admin_open]
[img_admin_open_th]: {{ img_dir }}/cb_admin_open_thumb.png
[img_admin_open]: {{ img_dir }}/cb_admin_open.png

The administrative views also have a closable container element (click the +/-
box in the upper right hand corner to toggle):

[![Cloud Browser admin (closed)][img_admin_closed_th]][img_admin_closed]
[img_admin_closed_th]: {{ img_dir }}/cb_admin_closed_thumb.png
[img_admin_closed]: {{ img_dir }}/cb_admin_closed.png

This work is at a very early stage and will likely change a lot, as there are
many unresolved issues: links don't appear on the dashboard because there are
no models, there are no configurable admin permissions to the Cloud Browser
views (either all or none), etc.  But, it's close enough for now.

## Conclusion

Cloud Browser provides a very basic cloud file viewer for your Django
projects, but it gets the job done, particularly for Rackspace Cloud Files.
Any and all feedback and bugs are strongly encouraged -- just open a ticket on
the [GitHub issues page][13]. Happy browsing.

[1]: http://pypi.python.org/pypi
[2]: http://aws.amazon.com/s3/
[3]: http://www.rackspace.com/cloud/cloud_hosting_products/files/
[4]: http://www.openstack.org/projects/storage/
[5]: http://ryan-roemer.github.com/django-cloud-browser/
[6]: https://github.com/ryan-roemer/django-cloud-browser/
[7]: http://pypi.python.org/pypi/django-cloud-browser
[8]: http://docs.rackspacecloud.com/files/api/cf-devguide-latest.pdf
[9]: https://github.com/rackspace/python-cloudfiles/
[10]: https://manage.rackspacecloud.com/CloudFiles.do
[11]: https://console.aws.amazon.com/s3/home?
[12]: http://images.loose-bits.com/cloud_browser_cb_admin_closed.png
[13]: https://github.com/ryan-roemer/django-cloud-browser/issues

<!-- more end -->