---
layout: post
title: Extending Django Settings with Derived Attributes and Methods
description: Extend the Django settings module with derived / inferred
  attributes at runtime.
date: 2011-04-20 05:07:00 UTC
permalink: /2011/04/extending-django-settings-with-derived.html
tags: ['python', 'django', 'hack']
---

[Django settings][1] construction and configuration is fairly straightforward.
Configure Django and installed application settings, maybe add your own
project-specific settings, and let Django take care of the rest.
As long as you import settings from django.conf all the options and defaults
are properly resolved into the ultimate settings object.

However, every so often I run across a situation where I wish the Django
settings could do just a little bit more. Rather than try and wade into the
depths of Django runtime configuration and risk mucking things up, the
approach I take is to use a thin wrapper class around the already configured
settings and pass through all calls directly.

What we essentially want is "pass through" wrapper class like:

{% highlight python %}
from django.conf import settings as _settings

class Settings(object):
    """Thin settings wrapper."""

    def __init__(self, default_settings):
        """Initializer."""
        self.default_settings = default_settings

    def __getattr__(self, name):
        """Get setting."""
        return getattr(self.default_settings, name)

settings = Settings(_settings)
{% endhighlight %}

Fortunately, Django already has a slightly more complex version of this in the
django.conf.UserSettingsHolder class, so we'll use that instead. I usually
have a common application in my Django projects and insert the settings
wrapper as the common.settings or common.conf module.

<!-- more start -->

From there, we can add any number of "extra" settings variables or derived
methods. For instance, if we wanted to add a settings method to tell if our
database was SQLite or PostgreSQL using knowledge of the driver names, we
could implement some fairly simple methods:

{% highlight python %}
def is_sqlite(self):
    """Return ``True`` if default database is SQLite."""
    # Driver: 'sqlite3'
    return 'sqlite3' in self.DATABASES['default']['ENGINE']

def is_postgres(self):
    """Return ``True`` if default database is PostgreSQL."""
    # Drivers: 'postgresql_psycopg2', 'postgresql'
    return 'postgresql' in self.DATABASES['default']['ENGINE']
{% endhighlight %}

While perhaps too simplistic and brittle for production use, the above example
illustrates how easy it is to add extra dynamic checks. To use the above
methods if very easy -- just import settings from our module (here
common.settings instead of django.conf).

{% highlight python %}
from common.settings import settings

print("Using SQLite?: %s" % settings.is_sqlite())
print("Using Postgres?: %s" % settings.is_postgres())
{% endhighlight %}

which outputs:

{% highlight text %}
Using SQLite?: True
Using Postgres?: False
{% endhighlight %}

for a project configured with ``'ENGINE': 'django.db.backends.sqlite3'``.

In a typical Django project there are several file paths that are usually
derived and hacked into the settings file -- the Django project root
directory, the Django admin media directory, and sometimes the path to the
settings file itself.  Here are methods for our wrapped settings class to
intuit these paths:

{% highlight python %}
def settings_path(self):
    """Return path to project settings."""
    from os import path
    from django.utils import importlib

    # Have to use real settings directly because UserSettingsHolder
    # sets SETTINGS_MODULE to ``None`` as a class variable.
    mod = importlib.import_module(
      self.default_settings.SETTINGS_MODULE)

    # Split off the extension to replace ".pyc" with ".py"
    return path.splitext(path.abspath(mod.__file__))[0] + ".py"

def project_root_path(self):
    """Return path to project root."""
    from os import path

    # We "cheat" here to find project root because we have know
    # this file is ``PROJECT_ROOT/common/settings.py``.
    return path.abspath(path.join(path.dirname(__file__), ".."))

def admin_media_path(self):
    """Return path to Django admin media directory."""
    from os import path
    from django.contrib import admin

    return path.abspath(
      path.join(path.dirname(admin.__file__), "media"))
{% endhighlight %}

And we can view our results with:

{% highlight python %}
from common.settings import settings

print("Settings file path: %s" % settings.settings_path())
print("Project root directory path: %s" %
      settings.project_root_path())
print("Admin media directory path: %s" %
      settings.admin_media_path())
{% endhighlight %}

which outputs:

{% highlight text %}
Settings file path: /Users/ryan/demo/settings.py
Project root directory path: /Users/ryan/demo
Admin media directory path: /Users/ryan/env/demo/lib/python2.6/site-packages/django/contrib/admin/media
{% endhighlight %}

Putting a full file together with our simple extension methods. In our case,
the finished "common/settings.py" file will be:

{% highlight python %}
from os import path
from django.contrib import admin
from django.conf import settings as _settings, UserSettingsHolder
from django.utils import importlib

class CustomSettings(UserSettingsHolder):
    """Thin settings wrapper.

    .. note:: "Real" settings object is available as
      ``.default_settings`` member.
    """

    def is_sqlite(self):
        """Return ``True`` if default database is SQLite."""
        # Driver: 'sqlite3'
        return 'sqlite3' in self.DATABASES['default']['ENGINE']

    def is_postgres(self):
        """Return ``True`` if default database is PostgreSQL."""
        # Drivers: 'postgresql_psycopg2', 'postgresql'
        return 'postgresql' in self.DATABASES['default']['ENGINE']

    def settings_path(self):
        """Return path to project settings."""
        mod = importlib.import_module(
          self.default_settings.SETTINGS_MODULE)

        # Split off the extension to replace ".pyc" with ".py"
        return path.splitext(path.abspath(mod.__file__))[0] + ".py"

    def project_root_path(self):
        """Return path to project root."""
        return path.abspath(
          path.join(path.dirname(__file__), ".."))

    def admin_media_path(self):
        """Return path to Django admin media directory."""
        return path.abspath(
          path.join(path.dirname(admin.__file__), "media"))

settings = CustomSettings(_settings)
{% endhighlight %}

While these contrived example method extensions are solving problems perhaps
best solved elsewhere (like in the actual project settings file), they serve
to illustrate a simple means of how to extend the Django settings module
easily and without interfering with the runtime settings configuration
process.

[1]: http://docs.djangoproject.com/en/dev/topics/settings/

<!-- more end -->