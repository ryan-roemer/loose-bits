---
layout: post
title: Hosting an Authenticated, Static HTML Web Site on Google App Engine
description: Google App Engine provides an easy framework for hosting a static
  site and providing extensible user authentication based on Google Apps or
  OpenID accounts. This makes App Engine a great (and inexpensive) resource for
  quickly hosting static HTML content limited to an appropriate user domain.
date: 2012-01-06 14:00:00 UTC
tags: ['app engine', 'google apps', 'static', 'html', 'python', 'sphinx']
---

## Static HTML Web Site hosting with Google App Engine

[Google App Engine][gae] is a platform-as-a-service (PAAS) product that
provides scalable cloud-hosted web applications using Google's massive
engineering infrastructure. While App Engine is primarily used by web
developers (e.g., programming in Python or Java), it provides two features
which make it uniquely helpful for static site hosting:

* Arbitrary static file handling.
* Extensible authentication support.

In this post, we'll walk through uploading a static HTML site to App Engine
that requires users to log in before viewing any content. The assumption is
that you already have a domain name managed by Google Apps (e.g.,
"example.com"). We will then create a website and restrict it to users of the
specific Google Apps domain, requiring a login of a user "@example.com".
This is a common situation for organizations already using Google Apps to
manage email, documents, etc. already that want to host a web site without
having extra configuration hassles. App Engine essentially takes care of all
the authentication / user management, and you just have to upload a static
web site!

<!-- more start -->

## Create an Authenticated App Engine Application

The first step is to create an App Engine web application. You'll need to
[sign up][gae_sign_up] for an App Engine account, [download][gae_download]
the App Engine Python SDK (make sure you get the **Python** one!), and you
should read the "[getting started][gae_intro]" documentation.

Once you are all set up on App Engine, we can create the actual application.
The important thing to point out here is that you must select the
authentication method you want for your web site **at** creation time, as it
cannot be changed later. (Although, you can create a *new* application with
different authentication and delete your original application).

Take a moment to review the App Engine [authentication][gae_auth] article,
as we're basically going to follow these steps. Go to the
[create application][gae_create] web page. Fill in the following information:

* **Application Identifier**: Choose a descriptive name for your site (e.g.
  "internal-docs". There cannot be an existing matching identifier, so have
  some alternates handy. This will result in a domain name of
  "internal-docs.appspot.com" (or whatever your identifier is) for your
  finished website.
* **Application Title**: An free text description of your website. Feel free to
  put anything in that provides a simple title for your site.
* **Authentication Options (Advanced)**: You'll need to click the "edit" link
  which then gives us three options for authentication: (1) "Open to all Google
  Accounts users (default)", (2) "Restricted to the following Google Apps
  domain:", or (3) "(Experimental) Open to all users with an OpenID Provider".
  Click the button for "Restricted to the following Google Apps domain:" and
  enter your Google Apps-managed domain (e.g., "example.com"). I should point
  out again, you *already* need to have a Google Apps for the domain name you
  are entering.

From there you can click "Create Application", and the application should be
created. Make sure to keep your application identifier handy.

## Configure and Upload Static Web Site

The next step is to gather your static web site files, add an application
configuration, and upload all the content to the App Engine application.
Let's assume we have a directory that we're going to fill with all of this
called "my_site". As an aside, you are best off keeping this directory under a
source control management system (e.g., git), so that you can monitor, track
and revert changes to all of your files.

### Configuration

We need an application configuration file call "app.yaml" in the root directory
of our project directory. This file controls various aspects of the
application, including how the application routes URLs to handlers. We'll
use a configuration that handles all static file types (including HTML), and
just simply serves them.

There are [various][post1] [other][post2] posts out there discussing
configurations for static web sites on App Engine, but the best configuration
that I found was a [gist][dt_gist] by Git user "[darktable][dt_git]".
However, this configuration didn't including authentication, so I forked the
gist and added authentication attributes to produce our final "app.yaml"
file:

<script src="https://gist.github.com/1570659.js?file=app.yaml"></script>


{% comment %}
TODO HERE
App: foobardelete123456
Orig (): 
Mine: https://gist.github.com/1570659

{% endcomment %}




[gae]: http://code.google.com/appengine/
[gae_auth]: http://code.google.com/appengine/articles/auth.html
[gae_create]: http://appengine.google.com/start/createapp
[gae_sign_up]: https://appengine.google.com/
[gae_download]: http://code.google.com/appengine/downloads.html
[gae_intro]: http://code.google.com/appengine/docs/python/gettingstarted/
[post1]: http://blog.engelke.com/2008/07/30/google-appengine-for-web-hosting/
[post2]: http://www.instantfundas.com/2011/02/how-to-host-static-websites-on-google.html
[dt_gist]: https://gist.github.com/873098
[dt_git]: https://github.com/darktable

<!-- more end -->
