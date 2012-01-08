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
should read the "[getting started][gae_intro]" documentation. Also, if given
the option to "install command symlinks", make sure you choose to do this
(which will give us an ``appcfg.py`` executable in our path for use later).

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

For authentication within a Google Apps domain, there are further instructions
in the App Engine [authentication][gae_auth] article that we need to follow.
Summarizing, you also need to open a web browser to:
"http://www.google.com/a/YOUR DOMAIN" and click on the "Dashboard" tab. Go to
"Service settings" and click on the "Add more services" link. In the
"Other services" section, there will be a place to add an App Engine service.
Type in your application identifier code here and click "Add it now". This
will hook up your specific Google Apps Domain with the App Engine service.

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

{% highlight yaml %}
# App configuration for static site with auth.
#
# Originally from: https://gist.github.com/873098
application: you-app-name-here
version: 1
runtime: python
api_version: 1

default_expiration: "30d"

handlers:
- url: /(.*\.(appcache|manifest))
  mime_type: text/cache-manifest
  static_files: static/\1
  upload: static/(.*\.(appcache|manifest))
  expiration: "0m"
  login: required

- url: /(.*\.atom)
  mime_type: application/atom+xml
  static_files: static/\1
  upload: static/(.*\.atom)
  expiration: "1h"
  login: required

- url: /(.*\.crx)
  mime_type: application/x-chrome-extension
  static_files: static/\1
  upload: static/(.*\.crx)
  login: required

- url: /(.*\.css)
  mime_type: text/css
  static_files: static/\1
  upload: static/(.*\.css)
  login: required

- url: /(.*\.eot)
  mime_type: application/vnd.ms-fontobject
  static_files: static/\1
  upload: static/(.*\.eot)
  login: required

- url: /(.*\.htc)
  mime_type: text/x-component
  static_files: static/\1
  upload: static/(.*\.htc)
  login: required

- url: /(.*\.html)
  mime_type: text/html
  static_files: static/\1
  upload: static/(.*\.html)
  expiration: "1h"
  login: required

- url: /(.*\.ico)
  mime_type: image/x-icon
  static_files: static/\1
  upload: static/(.*\.ico)
  expiration: "7d"
  login: required

- url: /(.*\.js)
  mime_type: text/javascript
  static_files: static/\1
  upload: static/(.*\.js)
  login: required

- url: /(.*\.json)
  mime_type: application/json
  static_files: static/\1
  upload: static/(.*\.json)
  expiration: "1h"
  login: required

- url: /(.*\.m4v)
  mime_type: video/m4v
  static_files: static/\1
  upload: static/(.*\.m4v)
  login: required

- url: /(.*\.mp4)
  mime_type: video/mp4
  static_files: static/\1
  upload: static/(.*\.mp4)
  login: required

- url: /(.*\.(ogg|oga))
  mime_type: audio/ogg
  static_files: static/\1
  upload: static/(.*\.(ogg|oga))
  login: required

- url: /(.*\.ogv)
  mime_type: video/ogg
  static_files: static/\1
  upload: static/(.*\.ogv)
  login: required

- url: /(.*\.otf)
  mime_type: font/opentype
  static_files: static/\1
  upload: static/(.*\.otf)
  login: required

- url: /(.*\.rss)
  mime_type: application/rss+xml
  static_files: static/\1
  upload: static/(.*\.rss)
  expiration: "1h"
  login: required

- url: /(.*\.safariextz)
  mime_type: application/octet-stream
  static_files: static/\1
  upload: static/(.*\.safariextz)
  login: required

- url: /(.*\.(svg|svgz))
  mime_type: images/svg+xml
  static_files: static/\1
  upload: static/(.*\.(svg|svgz))
  login: required

- url: /(.*\.swf)
  mime_type: application/x-shockwave-flash
  static_files: static/\1
  upload: static/(.*\.swf)
  login: required

- url: /(.*\.ttf)
  mime_type: font/truetype
  static_files: static/\1
  upload: static/(.*\.ttf)
  login: required

- url: /(.*\.txt)
  mime_type: text/plain
  static_files: static/\1
  upload: static/(.*\.txt)
  login: required

- url: /(.*\.unity3d)
  mime_type: application/vnd.unity
  static_files: static/\1
  upload: static/(.*\.unity3d)
  login: required

- url: /(.*\.webm)
  mime_type: video/webm
  static_files: static/\1
  upload: static/(.*\.webm)
  login: required

- url: /(.*\.webp)
  mime_type: image/webp
  static_files: static/\1
  upload: static/(.*\.webp)
  login: required

- url: /(.*\.woff)
  mime_type: application/x-font-woff
  static_files: static/\1
  upload: static/(.*\.woff)
  login: required

- url: /(.*\.xml)
  mime_type: application/xml
  static_files: static/\1
  upload: static/(.*\.xml)
  expiration: "1h"
  login: required

- url: /(.*\.xpi)
  mime_type: application/x-xpinstall
  static_files: static/\1
  upload: static/(.*\.xpi)
  login: required

# image files
- url: /(.*\.(bmp|gif|ico|jpeg|jpg|png))
  static_files: static/\1
  upload: static/(.*\.(bmp|gif|ico|jpeg|jpg|png))
  login: required

# audio files
- url: /(.*\.(mid|midi|mp3|wav))
  static_files: static/\1
  upload: static/(.*\.(mid|midi|mp3|wav))
  login: required

# windows files
- url: /(.*\.(doc|exe|ppt|rtf|xls))
  static_files: static/\1
  upload: static/(.*\.(doc|exe|ppt|rtf|xls))
  login: required

# compressed files
- url: /(.*\.(bz2|gz|rar|tar|tgz|zip))
  static_files: static/\1
  upload: static/(.*\.(bz2|gz|rar|tar|tgz|zip))
  login: required

# index files
- url: /(.+)/
  static_files: static/\1/index.html
  upload: static/(.+)/index.html
  expiration: "15m"
  login: required

- url: /(.+)
  static_files: static/\1/index.html
  upload: static/(.+)/index.html
  expiration: "15m"
  login: required

# site root
- url: /
  static_files: static/index.html
  upload: static/index.html
  expiration: "15m"
  login: required
{% endhighlight %}

You can also view / download the file at its GitHub [gist][gist_cfg] page, as
well as a basic [Readme][gist_readme] file.

Download the file to "my_site/app.yaml" and update the
``application: you-app-name-here`` directive with your specific application
identifier you chose in the application creation section above.

### Static Content

Now that we have a configuration file, create folder called "my_site/static"
which will house all of your static web site. As we want to check that the
authentication works first before uploading potentially sensitive information,
I would recommend creating a test HTML page that just contains the content
"It worked!" or something, and adding that as "my_site/static/index.html".

Now, we should have a project layout that looks like:

    my_site/
      app.yaml
      static/
        index.html

At this point we can upload the full site to our static server using
[appcfg.py][gae_appcfg]. Make sure that we have ``appcfg.py`` available:

{% highlight bash %}
$ which appcfg.py
/usr/local/bin/appcfg.py
{% endhighlight %}

If you don't get an executable path back, then review the
"[getting started][gae_intro]" documents for installation of the App Engine
runtime.

Assuming we do have ``appcfg.py`` available, change directory in your shell
to the directory containing "my_site" and upload the static site:

{% highlight bash %}
$ appcfg.py update my_site
{% endhighlight %}

You will have to enter your Google credentials here. After the upload
finishes, you should be able to open a web browser to:
"&lt;your application identifier&gt;.appspot.com". If you are authenticated to
your Google Apps domain, you should see the "It worked!" test page. If not, you
should be prompted to login to your Google Apps domain. A good way to test
the authentication works is to open a new Google Chrome Incognito window. It
should always force a new Google Apps login if you have configured things
properly. If the authentication doesn't work quite right, review the
App Engine [authentication][gae_auth] page.

Assuming authentication does work correctly, then you can now remove the
test "index.html" file and upload your real site content to the
"my_site/static" directory. Every time you change the content, make sure
to re-upload the project with ``appcfg.py`` and enjoy your static web site!

[gae]: http://code.google.com/appengine/
[gae_auth]: http://code.google.com/appengine/articles/auth.html
[gae_appcfg]: http://code.google.com/appengine/docs/python/tools/uploadinganapp.html
[gae_create]: http://appengine.google.com/start/createapp
[gae_sign_up]: https://appengine.google.com/
[gae_download]: http://code.google.com/appengine/downloads.html
[gae_intro]: http://code.google.com/appengine/docs/python/gettingstarted/
[post1]: http://blog.engelke.com/2008/07/30/google-appengine-for-web-hosting/
[post2]: http://www.instantfundas.com/2011/02/how-to-host-static-websites-on-google.html
[dt_gist]: https://gist.github.com/873098
[dt_git]: https://github.com/darktable
[gist_cfg]: https://gist.github.com/1570659
[gist_readme]: https://gist.github.com/1570659#file_readme.markdown

<!-- more end -->
