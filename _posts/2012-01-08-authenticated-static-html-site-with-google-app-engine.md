---
layout: post
title: Authenticated, Static Web Sites on Google App Engine
description: Google App Engine provides an easy framework for hosting a static
  site and providing extensible user authentication based on Google Apps or
  OpenID accounts. This makes App Engine a great (and inexpensive) resource for
  quickly hosting static HTML content limited to an appropriate user domain.
date: 2012-01-08 14:00:00 UTC
tags: ['app engine', 'google apps', 'static', 'html', 'python']
---
## Static HTML Web Site Hosting with Google App Engine

[Google App Engine][gae] is a platform-as-a-service (PAAS) product that
provides scalable, cloud-hosted web applications using Google's massive
engineering infrastructure. While App Engine is primarily used by web
developers (e.g., programming in Python or Java), it offers three features
which make it uniquely helpful for static site hosting:

* Arbitrary static file handling.
* Extensible authentication support.
* Very inexpensive (most likely free) for hosting static content.

In this post, we'll walk through uploading a static HTML site to App Engine,
and configuring it such that it requires users to log in to via a Google Apps
domain account before viewing any content. This is a common situation for
organizations already using Google Apps to manage email, documents, etc.
that want to host a web site without having extra configuration hassles.
App Engine essentially takes care of all the authentication / user management,
and you just have to upload the static web site.

The assumption throughout the rest of this post is that you already have a
domain name managed by Google Apps (e.g., "example.com"). We will create
an App Engine application and then restrict it to users of the specific Google
Apps domain, requiring a login of a user "@example.com". Finally, we'll upload
the static site and verify that authentication works as expected.

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
  out again, you *already* need to have Google Apps set up for the domain name
  you are entering.

From there you can click "Create Application" and the application should be
created. Make sure to keep your application identifier handy.

To enable Google Apps domain authentication for the new application, we need
to follow the instructions in the App Engine [authentication][gae_auth] article.
Basically, you need to open a web browser to:
"http://www.google.com/a/YOUR DOMAIN" and click on the "Dashboard" tab. Go to
"Service settings" and click on the "Add more services" link. In the
"Other services" section, there will be a place to add an App Engine service.
Type in your application identifier code here and click "Add it now". This
will hook up your specific Google Apps Domain with the App Engine service.

## Configure and Upload Static Web Site

The next step is to gather your static web site files, add an application
configuration, and upload all the content to the App Engine application.
We will place all of our application content in a directory called "my_site"
(or something else of your choosing).  You are best off keeping this directory
under a source control management system (e.g., git), so that you can monitor,
track and revert changes to all of your files.

### Configuration

We need an application configuration file call "app.yaml" in the root
of our project directory. This file controls various aspects of the
application, including how the application routes URLs to handlers. We'll
use a configuration that handles all static file types (including HTML), and
just simply serves them.

There are [various][post1] [other][post2] posts out there discussing
configurations for static web sites on App Engine, but the best configuration
that I found was a [gist][dt_gist] by GitHub user "[darktable][dt_git]".
However, this configuration didn't including authentication, so I forked the
gist and added authentication attributes to produce our final
[app.yaml][gist_app] file that you should download to "my_site/app.yaml".
You can also view a basic [Readme][gist_readme] file and other information at
the GitHub [gist][gist_cfg] page.

Here's a snippet of the "app.yaml" file that you'll need to slightly modify.

{% highlight yaml %}
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

# ... OTHER CONTENT SNIPPED ...

# site root
- url: /
  static_files: static/index.html
  upload: static/index.html
  expiration: "15m"
  login: required
{% endhighlight %}

After downloading to "my_site/app.yaml", update the
``application: you-app-name-here`` directive with your specific App Engine
application identifier you chose in the application creation section above.

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

If you don't get an executable path back, then review the App Engine
"[getting started][gae_intro]" documents for installation of the runtime.

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
[gist_app]: https://gist.github.com/1570659#app.yaml
[gist_readme]: https://gist.github.com/1570659#file_readme.markdown

<!-- more end -->
