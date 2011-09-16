---
layout: post
title: Distributed Task Locking in Celery
description: Create distributed task locks for the Celery message queue using
  Redis and Python decorators.
date: 2010-10-10 20:20:00 UTC
permalink: /2010/10/distributed-task-locking-in-celery.html
tags: ['django', 'memcached', 'python', 'redis', 'celery']
---

## Background

We use the [Celery][1] distributed task queue library at work, which is great
for running asynchronous tasks across multiple processes and servers.  Celery
has both user-initiated and periodic (think cron replacement) tasks, and we
have found in practice that the system distributes tasks quite nicely across
our farm of celery servers.

One issue we have is that for several of our periodic tasks, we need to ensure
that only one task is running at a time, and that later instances of the same
periodic task are skipped if a previous incarnation is still running.

The [Celery documentation][2] has a cookbook recipe for this scenario:
"[Ensuring a task is only executed one at a time][3]".  The crux of the
solution is to make a distributed lock using the Django cache ([memcached][4]
in the example) with the following lambda's:

{% highlight python %}
lock_id = "something unique"
lock_expire = 60 * 5  # five minutes

acquire_lock = lambda: cache.add(lock_id, "true", lock_expire)
release_lock = lambda: cache.delete(lock_id)
{% endhighlight %}

## Non-persistent Locks?

This approach works fine if the cache is shared across all celery worker nodes
and the cache is persistent.  However, if memcached (or some other non-
persistent cache) is used and (1) the cache daemon crashes or (2) the cache
key is culled before the appropriate expiration time / lock release, then you
have a race condition where two or more tasks could simultaneously acquire the
task lock.  This "distributed cache lock" approach has been discussed in
[various][5] [posts][6], which all acknowledge the danger of relying on
memcached for persistent data.

## Distributed Locks with Redis

As noted by one of the links above, the simplest solution to this problem if
you like using the cache for distributed locks is to switch to [memcachedb][7]
which is not a caching solution *per se*, but rather a persistent key-value
store that implements the memcached interface.

<!-- more start -->

However, for our system, using memcached as our Django cache is great in its
current non-persistent form for what it is -- a cache. So, I investigated more
generally to find a high performance, persistent key-value store (ideally with
a decent Python interface).  After reviewing a lot of neat and interesting
systems, I finally settled on [Redis][8].  Redis provides a very high
performance key-value store (data is maintained in memory) with persistence
(using the [append only file][9] feature) and [distribution /
replication][10].  As an added bonus, I found the server setup, installation
and CLI interaction to be very straightforward.

So, back to locking... The Redis [python client][11] already has a lock class
with "``with``" operator support:

{% highlight python %}
import redis

with redis.Redis().lock("my_key"):
    print("Got lock.")
{% endhighlight %}

However, the above example is a blocking lock, and for the "single task"
issue, we want a non-blocking lock, that simply exits if the lock is not
acquired:

{% highlight python %}
import redis

have_lock = False
my_lock = redis.Redis().lock("my_key")
try:
    have_lock = my_lock.acquire(blocking=False)
    if have_lock:
        print("Got lock.")
    else:
        print("Did not acquire lock.")

finally:
    if have_lock:
        my_lock.release()
{% endhighlight %}

Beyond this simple example, the Lock class implements key expiration (via the
Redis [setnx][12] command) to enable timeouts in the python client.

## Enforced Single Celery Task

So, bringing this back to our celery tasks, we can use this distributed lock
to have our tasks try to acquire a non-blocking lock, and exit if the lock
isn't acquired.  Also, we want to set a lock timeout (lasting for a generous
overestimate of task duration time) so that tasks will eventually be able to
re-acquire the lock if some task / celery node hard crashes or goes in to an
unresponsive state before releasing the lock.

All of this can be put together as a decorator around a Task.run() method:

{% highlight python %}
import redis

REDIS_CLIENT = redis.Redis()

def only_one(function=None, key="", timeout=None):
    """Enforce only one celery task at a time."""

    def _dec(run_func):
        """Decorator."""

        def _caller(*args, **kwargs):
            """Caller."""
            ret_value = None
            have_lock = False
            lock = REDIS_CLIENT.lock(key, timeout=timeout)
            try:
                have_lock = lock.acquire(blocking=False)
                if have_lock:
                    ret_value = run_func(*args, **kwargs)
            finally:
                if have_lock:
                    lock.release()

            return ret_value

        return _caller

    return _dec(function) if function is not None else _dec
{% endhighlight %}

Note that this decorator preserves task return values.  If your tasks don't
have return values, you can get rid of the ``ret_value`` code.

Using the decorator is easy -- just annotate a task ``run()`` method:

{% highlight python %}
from celery.task import Task

class SingleTask(Task):
    """A task."""

    @only_one(key="SingleTask", timeout=60 * 5)
    def run(self, **kwargs):
        """Run task."""
        print("Acquired lock for up to 5 minutes and ran task!")
{% endhighlight %}

... and your task will only ever have one running instance at any given time.

[1]: http://celeryq.org/
[2]: http://celeryq.org/docs
[3]: http://celeryq.org/docs/cookbook/tasks.html#ensuring-a-task-is-only-executed-one-at-a-time
[4]: http://memcached.org/
[5]: http://bluxte.net/musings/2009/10/28/simple-distributed-lock-memcached
[6]: http://www.regexprn.com/2010/05/using-memcached-as-distributed-locking.html
[7]: http://memcachedb.org/
[8]: http://code.google.com/p/redis/
[9]: http://code.google.com/p/redis/wiki/AppendOnlyFileHowto
[10]: http://code.google.com/p/redis/wiki/ReplicationHowto
[11]: http://github.com/andymccurdy/redis-py
[12]: http://code.google.com/p/redis/wiki/SetnxCommand

<!-- more end -->