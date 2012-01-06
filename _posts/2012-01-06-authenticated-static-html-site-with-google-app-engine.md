---
layout: post
title: Hosting an Authenticated, Static HTML Web Site on Google App Engine
description: Google App Engine provides an easy framework for hosting a static
  site and providing extensible user authentication based on Google, Google
  Apps, or OpenID accounts. This makes App Engine a great (and inexpensive)
  resource for quickly hosting static HTML content limited to an appropriate
  user domain.
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
that requires users to log in before viewing any content. This is a common
situation in organizations using Google Apps to manage email, documents, etc.
already that want to host a web site without having extra configuration
hassles.

<!-- more start -->

[gae]: http://code.google.com/appengine/

<!-- more end -->
