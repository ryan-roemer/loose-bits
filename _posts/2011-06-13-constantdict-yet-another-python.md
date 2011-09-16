---
layout: post
title: ConstantDict, Yet Another Python Enumeration Pattern
description: ConstantDict is a Python enumeration pattern using class variables
  with straightforward construction, and a terse syntax.
date: 2011-06-13 13:30:00 UTC
permalink: /2011/06/constantdict-yet-another-python.html
tags: ['python', 'patterns']
---

## Introduction

The Python language does not natively provide enumerations. Rejected [PEP
354][1] proposed a string-constructor-based enumeration, later provided as the
separate enum [package][2]. The web is rife with various cookbook recipes and
ad-hoc solutions -- *see, e.g.*, [ActiveState][3] and [Stack Overflow][4].

Here is ``ConstantDict``, one of my preferred enumeration patterns.

## ``ConstantDict``

This pattern (like most Python enumeration recipes) is quite simple and
straightforward, so I'll actually start with the enumeration class, and then
discuss the merits / drawbacks after.

The enumeration class is as follows:

{% highlight python %}
class ConstantDict(object):
    """An enumeration class."""
    _dict = None

    @classmethod
    def dict(cls):
        """Dictionary of all upper-case constants."""
        if cls._dict is None:
            val = lambda x: getattr(cls, x)
            cls._dict = dict(((c, val(c)) for c in dir(cls)
                             if c == c.upper()))
        return cls._dict

    def __contains__(self, value):
        return value in self.dict().values()

    def __iter__(self):
        for value in self.dict().values():
            yield value
{% endhighlight %}

<!-- more start -->

Essentially, we create an internal dictionary of all class variables that are
upper-cased (well, and methods too), and wrap up a couple of instance built-in
methods. Implementing an enumeration with the pattern is pretty
straightforward. Here is a "days of the week" enumeration contrived by
multiply inheriting two base enumeration classes:

{% highlight python %}
class Weekdays(ConstantDict):
    """Weekday days."""
    MONDAY = 'Monday'
    TUESDAY = 'Tuesday'
    WEDNESDAY = 'Wednesday'
    THURSDAY = 'Thursday'
    FRIDAY = 'Friday'

class Weekend(ConstantDict):
    """Weekend days."""
    SATURDAY = 'Saturday'
    SUNDAY = 'Sunday'

class DaysOfTheWeek(Weekdays, Weekend):
    """Days of the week."""
    pass
{% endhighlight %}

And a simple use case example:

{% highlight python %}
# Get enumeration instance.
DAYS = DaysOfTheWeek()

print(DAYS.MONDAY)        # "Monday"
print('Saturday' in DAYS) # True
print('Notaday' in DAYS)  # False
print([x for x in DAYS])  # ["Monday", "Tuesday", ...]
{% endhighlight %}

## Discussion

The ``ConstantDict`` pattern shines in a couple of key areas:

* It has a terse, clean, and extensible structure. The enumerations are
  inheritable, and even support multiple inheritance (as the above examples
  shows). Also, the enumerations can be enhanced with helper methods, etc.,
  because they are real classes.
* The structure allows arbitrary enumeration values. In my example I used
  strings, but anything (even including functions) are valid values.
* The enumeration members are real class variables and not strings. For me this
  is a key point over a pure string-based solution, as I want to be able to run
  ``pylint`` and have it throw errors on invalid enumeration names.

However, ``ConstantDict`` probably isn't the best choice for many situations.
Some of the drawbacks of the pattern include:

* Enumeration members are unordered. Because everything is shoved into a
  dictionary, there are no order guarantees.
* Despite being called ``ConstantDict``, the enumeration values aren't actually
  enforced constants.
* Enumeration values must be manually specified and are not guaranteed to be
  unique. As noted above arbitrary (including identical) enumeration values are
  allowed. However, the pattern could be easily extended to raise an exception
  on detection of duplicate values.
* An enumeration class cannot have other upper-cased class variables or members.
  This should not be too big of a deal as the enumeration class is ideally used
  just as a small constant holder and not a multi-purpose class.
* The caller has to instantiate an instance of the ``ConstantDict`` class.
  This is necessary for the ``__contains__`` and ``__iter__`` convenience
  method. In the past, I have used a different version of the ``ConstantDict``
  class that is used only at the class variable / method level.

There are certainly other tweaks and enhancements that can make the
``ConstantDict`` pattern better for a given situation.  But, in its most basic
form as described above, it provides an easy, extensible thin-wrapper
enumeration.

[1]: http://www.python.org/dev/peps/pep-0354/
[2]: http://pypi.python.org/pypi/enum/
[3]: http://code.activestate.com/recipes/413486/
[4]: http://stackoverflow.com/questions/36932/whats-the-best-way-to-implement-an-enum-in-python

<!-- more end -->