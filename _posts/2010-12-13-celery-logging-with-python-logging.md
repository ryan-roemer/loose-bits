---
layout: post
title: Celery Logging with Python Logging Handlers
description: Use Python standard library logging handlers with the Celery
  distributed task queue.
date: 2010-12-13 15:54:00 UTC
permalink: /2010/12/celery-logging-with-python-logging.html
tags: ['django', 'logging', 'python', 'hack', 'monkey patch', 'celery']
---

## Logging in Celery

We use [Celery][1] as our backend messaging abstraction at work, and have lots
of disparate nodes (and across different development, test, and production
deployments).  As each system deployment now contains a large (and growing)
number of nodes, we have been making a heavy push towards consolidated logging
through a central logging server sink, using syslog (specifically
[rsyslog][2]).

So, ideally, we would just use Celery's configuration to specify a syslog
handler (or maybe use a pipe).  Unfortunately, it seems there is just not a
simple way of doing this straight from Celery, as the only logging
configuration parameters (with possible values) are:

{% highlight python %}
CELERYD_LOG_FILE = "/path/to/file.log"  # File logging.
                                        # (OR)
CELERYD_LOG_FILE = None                 # stderr.
{% endhighlight %}

which means you either get a file logger ([filehandler][3]) or a stderr logger
([streamhandler][4]).

Hints and guidance on the web in terms of getting arbitrary logging handlers
(or syslog specifically) is sparse, as well as noisy.  A lot of the code and
discussion I found used Celery as the _backend_ for a generic logging
framework or library.  But, I found very little in terms of getting Celery
tasks and processes to actually log _to_ syslog.

## Bringing Arbitrary Logging to Celery

As nothing magically appeared as the "right" solution, I considered a couple
of different ways to hook things up:

1. **Watched Files**: Have Celery log to a file per usual, then add extra
   configuration and scripts to watch the file for changes and submit the
   changes to syslog directly. I didn't go with this approach, as I really
   prefer to have configuration for our project within generic Python settings,
   and not need extra, system-specific scripts and setup.
2. **Patch Celery**: The Celery logging hooks and code are fairly
   straightforward.  I could have added the patch and submitted upstream.
   Unfortunately, for the project at work, we are moving to fast to wait for
   changes, and as we are looking forward to some upstream Celery releases,
   I'd rather not maintain a private custom patch set through all of that.
3. **Monkey Patch Celery**: In the same vein as the former option, the same
   hooks and changes could be applied as a [monkey patch][5] instead.  This is
   what I eventually went with.

## Patching Logging Handlers into Celery

Monkey patching is oft-controversial and generally discouraged practice, as
getting things wrong is easy, and interactions within the patched library /
code can get really messy. In our case, I reluctantly chose monkey patching,
as it was a short patch, easy to disable, and I had no good other solutions.

Now that I've given the standard disclaimer, let's get to the patch! The
relevant Celery function we want to patch in celery.log._setup_logger():

<!-- more start -->

{% highlight python %}
def _setup_logger(logger, logfile, format, colorize,
        formatter=ColorFormatter, **kwargs):

    if logger.handlers:                 # already configured
        return logger

    handler = _detect_handler(logfile)
    handler.setFormatter(formatter(format, use_color=colorize))
    logger.addHandler(handler)
    return logger
{% endhighlight %}

As we can see, there is only one shot at a handler, and it comes from
``celery.log._detect_handler()``, which either returns a stream or file
handler. What I would ideally like is to define be able to define a Django
settings variable (we use Django and not native Celery settings at work):

{% highlight python %}
PATCH_CELERYD_LOG_HANDLERS = (
    lambda: logging.FileHandler("path/to/another_log.txt"),
    lambda: logging.handlers.SysLogHandler(),
)
{% endhighlight %}

and define a new ``_setup_logger()``:

{% highlight python %}
import celery.log

from celery.log import ColorFormatter
from django.conf import settings

old_setup_logger = celery.log._setup_logger

def _setup_logger(logger, logfile, format, colorize,
        formatter=ColorFormatter, **kwargs):

    patched_logger = old_setup_logger(
        logger, logfile, format, colorize, formatter, **kwargs)

    for handler_fn in getattr(settings, "PATCH_CELERYD_LOG_HANDLERS", []):
        handler = handler_fn()
        handler.setFormatter(formatter(format, use_color=colorize))
        patched_logger.addHandler(handler)

    return patched_logger
{% endhighlight %}

I would have preferred a pure "``*args, **kwargs``" version of the patched
function, but unfortunately, we need to dig out the formatter parameter if
set, so I copied the method signature of the original.  Also, I used lambda's
in ``PATCH_CELERYD_LOG_HANDLERS`` and called the function in the new setup
logger so as to create a _new_ handler object each time for loggers.  It is
important to have different handler objects because formats attach to handler
objects, and Celery uses different formats for general/default/process logging
vs. task-specific logging.  If a handler has last been set to a task logger
format, that includes a format for among other things "task_name", then you
will get a KeyError on trying to issue a logging statement.

Other than that, the patched method is very easy to read -- it iterates the
custom handler function list and creates new handlers for each different
logging object.  Putting this in to a patched version, I also added a marker
attribute to the logger object (to tell the patching is done), as well as the
patching code to lock, switch and mark the methods:

{% highlight python %}
import logging
import celery.log

from celery.log import ColorFormatter
from django.conf import settings

old_setup_logger = celery.log._setup_logger  # Store the real method.
def my_setup_logger(logger, logfile, format, colorize,
        formatter=ColorFormatter, **kwargs):
    """Replacement for :method:`celery.log._setup_logger`."""

    patched_logger = old_setup_logger(
        logger, logfile, format, colorize, formatter, **kwargs)

    # Check if not patched.
    if not getattr(patched_logger, "_LOG_PATCH_DONE", False):
        # Lock and patch.
        logging._acquireLock()
        try:
            handler_fns = getattr(settings, "PATCH_CELERYD_LOG_HANDLERS", [])
            for handler_fn in handler_fns:
                handler = handler_fn()
                handler.setFormatter(formatter(format, use_color=colorize))
                patched_logger.addHandler(handler)

            # Mark logger object patched.
            setattr(patched_logger, "_LOG_PATCH_DONE", True)
        finally:
            logging._releaseLock()

    return patched_logger

# Apply patches.
CELERY_MOD_PATCHED = False
if not CELERY_MOD_PATCHED:
    logging._acquireLock()  # Lock logging during patch.
    try:
        celery.log._setup_logger = my_setup_logger  # Patch old w/ new.
        CELERY_MOD_PATCHED = True
    finally:
        logging._releaseLock()
{% endhighlight %}

With the patch applied, any number of Python standard logging handlers can now
be added to the celery task / process loggers.

## Applying the Patch at Runtime

So we've defined the patch, but how do we apply it?  Part of the problem is
celery configuration.  If you apply the patch too early, you get the following
exception:

{% highlight text %}
.../python2.6/site-packages/celery/loaders/default.py:53: NotConfigured:
No celeryconfig.py module found! Please make sure it exists and is available to Python.
{% endhighlight %}

So, we have to find a proper place in the initialization process, after Celery
settings.  The best solution I found for this is to create a faux Django
"application" , that contains only the patch code.  Let's call the application
"patch_celery":

{% highlight text %}
$ cd path/to/project
$ django-admin.py startapp patch_celery
{% endhighlight %}

Copy and paste all of the patch code above into the __init__.py.  And then, we
simply add the patch application to the Django settings.py installed apps:

{% highlight python %}
INSTALLED_APPS = (
    # ...
    'djcelery',
    'patch_celery',
    # ...
)
{% endhighlight %}

The best place to put the patch is right _after_ the djcelery application.
Now, add your patch variable, ``PATCH_CELERYD_LOG_HANDLERS``, to settings.py
with any designated handlers (per previous example) and you're off with any
logging handlers for celery tasks that you want!  You can disable the patch by
simply removing the "patch_celery" application from installed applications in
settings, which enables easily toggling per appropriate context without major
code swaps.

## Afterthoughts

The monkey patch to Celery certainly gets the job done for now.  However, the
fact that the full method signature for ``celery.log._setup_logger()`` is used
makes the patch very brittle -- if a parameter changes in the underlying
method, the patched method may cease to work, or worse, give a wrong parameter
to the underlying method.

[1]: http://celeryproject.org/
[2]: http://www.rsyslog.com/
[3]: http://docs.python.org/library/logging.html#filehandler
[4]: http://docs.python.org/library/logging.html#streamhandler
[5]: http://en.wikipedia.org/wiki/Monkey_patch

<!-- more end -->