---
layout: post
title: Browserless AJAX Testing with Rhino and Envjs, Part 1.
description: Test your jQuery/AJAX JavaScript code using QUnit without a
  browser using Rhino and Env.js.
date: 2011-02-08 06:15:00 UTC
permalink: /2011/02/browserless-ajax-testing-with-rhino-and.html
tags: ['javascript', 'dom', 'django', 'envjs', 'ajax', 'python', 'test',
       'rhino']
---
{% capture img_dir %}{{ site.baseurl }}media/img/{{page.date|date: "%Y/%m/%d"}}{% endcapture %}
{% capture pt2 %}{{ site.baseurl }}2011/02/browserless-ajax-testing-with-rhino-and_16.html{% endcapture %}

## Updates - 5/27/2011

Since this original post, there has been a lot of good feedback surrounding
getting an Envjs + QUnit + Rhino setup going, so please read the comments at
the bottom of this post.  Here are the summarized points:

* **QUnit**: Newer versions of QUnit have issues with Envjs, adding a
  ``<pre/>`` to output that Envjs can't handle.  A comment from "Ryan"
  (not me -- I'm "Ryan Roemer" below) also points out the QUnit has changed
  the function signature of the logging callbacks and links to an improved
  "[setup.js][2]" file.  I have inserted links to a known [working version][3]
  of QUnit.
* **jQuery 1.5**: jQuery 1.5+ also has issues with Envjs due to calls to a
  couple of methods not currently available in either Envjs 1.2 or 1.3.
  There is a [patch][4] on GitHub for the issue for Envjs 1.3.  I have
  backported the patch (and some other fixes) to a [forked version][5] of
  Envjs 1.2 on my GitHub account.
* **Envjs 1.3**: Envjs 1.2 was a single file, with primarily Rhino support.
  [Envjs 1.3][6] is massive enhancement project that supports a large number of
  JavaScript engines including: Node.js, SpiderMonkey, etc. It's still in early
  development, but definitely worth taking a look at.

## Introduction

This is the first of two blog posts focusing on browserless testing of AJAX /
JavaScript using Rhino and Envjs. Today, we discuss getting browserless
[QUnit][7] tests up and running from the command line. A [follow-on][8]
post will discuss running QUnit tests which involve DOM manipulation and AJAX
interaction.

Testing web applications can be an enormous pain. Tests take time to write
correctly and usefully, the interaction between the front and back ends is
complicated, and it is often a hassle just to get people to run the tests on a
regular basis. At work as of late, we have been trying to kick start our
JavaScript unit testing -- our system has a Django/Python backend, and a
JavaScript (mostly jQuery-based) frontend.

On the backend, we are in good shape, test-wise -- the Django [test case
extensions][9] to the Python unit test framework make backend unit testing
easy and straightforward. Everything runs fairly quickly, and from the command
line. In fact, we have actually made a (soft) requirement that all developers
run a [Fabric][10] target called "precommit" that runs all of our Django unit
tests (in addition to Python and JavaScript style checkers).

On the frontend, it's a different story. Our previous test suite relied
entirely on a browser and a running development server loaded with data in a
known state. Our unit tests were written against QUnit, and for the most part
worked fine for the code they did exercise. But, even where our frontend tests
would catch newly introduced bugs, all too often the tests just weren't run,
and we would actually discover the bug several commit cycles later.

While we clearly need to integrate a fully automated infrastructure around
browser-based tests (using great tools like [Selenium][11] or [Windmill][12]),
my thoughts turned to the idea that the heavyweight nature of full end-to-end
AJAX testing was getting in the way of us writing and running frontend tests.
More specifically, the difficulties come down to two fundamental problems --
our tests on the frontend are: (1) not easy to write and run, and (2) are not
integrated into an automated, "one-touch" running scheme.

<!-- more start -->

## JavaScript Engines and the Pesky Browser Environment

Last week I decided to finally bite the bullet and push hard for the easiest
and simplest JavaScript testing solution -- execution of a full suite of QUnit
tests that would execute without a browser from a single command line command.

The first stop is getting a JavaScript engine to actually run JavaScript (test
and code) in lieu of a browser. Fortunately, there are lots of great open
source options including:

* [Rhino][13]: Mozilla's Java JavaScript implementation.
* [SpiderMonkey][14]: Mozilla's C implementation of JavaScript.
* [V8][15]: Google's JavaScript virtual machine for Chrome.

A JavaScript engine only gets you pure JavaScript language support. The hard
part is that any nontrivial web application with a good amount of JavaScript
has a large percentage of code that manipulates the DOM and essentially needs
a browser environment for a lot of functionality. So much so, that as general
assertion, it is probably not worth trying to separate out pure and browser-
dependent JavaScript code in development solely for this purpose.

Thus, the second step necessary for running QUnit tests is a simulation of the
browser environment (e.g., window, console, etc.), just without the browser.
This is a harder problem.

A few years ago, while working on some prototype code for a friend's startup,
I started researching browserless JavaScript testing, specifically looking for
browser emulation options. At the time, the only serious emulation solution I
found was in a [blog post][16] by [John Resig][17] (of [jQuery][18] fame),
where he had successfully hacked together a pure JavaScript browser
environment (called "env.js") that was capable of AJAX, DOM manipulation, and
even running the jQuery set of QUnit tests.

Unfortunately, my buddy's side project eventually went on hiatus, and I never
got around to rigging up a completely browserless test project. Working on
purely backend server code for the past couple of years (C++, C#, python), it
has taken me some time to get both the opportunity and desire to research a
browserless JavaScript environment.

So years later, looking back into the issue, I was pleased to revisit Resig's
proof-of-concept browser simulation environment and find that it had evolved
into a full open source project -- [Envjs][19] -- which provides an amazingly
powerful browser-like environment, capable of DOM manipulation, AJAX
interaction, cookie setting, etc.

## Making Rhino, Envjs, QUnit, and JavaScript Tests Play Nicely Together

Rediscovering Envjs and finding it in good shape meant that I simply had to
plug in a JavaScript engine, make sure it works with QUnit, and then fire up
my test suites without a browser. I ended up choosing Rhino as my JavaScript
engine as Envjs has specific support for it, but presumably other engines can
be made to work with Envjs and get equivalent results as I will describe
below.

So, let's get started.

### Rhino and Envjs Installation

In terms of extra tools / libraries, all we need is Rhino and Envjs:

Rhino is available from the Mozilla [FTP site][20]. I ended up going with
[rhino1_7R2][21] -- the Envjs web site notes that it is best to go with a
recent Rhino release. The package can be installed anywhere, but we are going
to need to know the path to the file "js.jar" in the package to pass as a
class path argument to Java.

After installing, let's check that Rhino actually works:

    $ cd /path/to/rhino
    $ java -cp js.jar org.mozilla.javascript.tools.shell.Main -opt -1
    Rhino 1.7 release 2 2009 03 22
    js> print("hello world");
    hello world
    js> quit();

Next, install Envjs. I went with [Envjs 1.2][22]. (I did end up having to
patch the library to get cookies working properly, but that's a post for
another day -- and presumably fixed in trunk). Envjs can be installed anywhere
the rest of your code can access it -- I went with the same JavaScript
directory as all our other third party library code.

### Example Libraries and Test Code

Ignoring how I actually installed and placed files, for the rest of this
discussion, let's assume we have a simplified world view in a single working
directory, where we'll place all our third party, test and library code. None
of these files really need (or should) be in the same directory, but it is
easier to describe things without multiple directory traversal.

Here is the third party code:

* [**``env.rhino.1.2.js``**][23]: The Envjs file we downloaded.  If you are
  using jQuery 1.5+, you may want this [patched Envjs][5] instead.
* [**``qunit.css``**][24]: QUnit styles. (*Link to known working version*).
* [**``qunit.js``**][25]: QUnit code. (*Link to known working version*).

We are going to create two more files in a subsequent section.

* **``setup.js``**: Hook Envjs to QUnit.
* **``run-tests.js``**: Include our setup script and actually invoke the tests
  at on our test HTML page.

And, here is some library and test code files:

* **``my-lib.js``**: An example JavaScript library (that we want to test).
  <a name="my-lib.js"> </a>

{% highlight javascript %}
function addTwo(x, y) {
    return x + y;
}
{% endhighlight %}

* **``my-tests.js``**: An example custom QUnit tests for my-lib.js.
  <a name="my-tests.js"> </a>

{% highlight javascript %}
module("My Module");

test("addTwo", function () {
    equals(addTwo(0, 0), 0, "Add nothing.");
    equals(addTwo(1, 2), 3, "Add numbers.");
    equals(addTwo(-1, -2), -3, "Add negatives.");
});
{% endhighlight %}

* **``test.html``**: Basic QUnit HTML page (see QUnit documentation) with
  script links to "my-lib.js" and "my-tests.js".
  <a name="test.html"> </a>

{% highlight html %}
<html>
  <head>
    <title>QUnit</title>
    <link rel="stylesheet" href="qunit.css" type="text/css" />
    <script type="text/javascript" src="qunit.js"></script>
    <script type="text/javascript" src="my-lib.js"></script>
    <script type="text/javascript" src="my-tests.js"></script>
  </head>
  <body>
    <h1 id="qunit-header">QUnit Test Suite</h1>
    <h2 id="qunit-banner"></h2>
    <div id="qunit-testrunner-toolbar"></div>
    <h2 id="qunit-userAgent"></h2>
    <ol id="qunit-tests"></ol>
    <div id="qunit-fixture"></div>
  </body>
</html>
{% endhighlight %}

Once we've got all of these custom and third party files, we can just open
test.html in a browser, and the QUnit tests should all run, pass and look
something like:

[![QUnit results][img_qunit_th]][img_qunit]
[img_qunit_th]: {{ img_dir }}/qunit_thumb.png
[img_qunit]: {{ img_dir }}/qunit.png

### Configuring Envjs and QUnit

We need to hook QUnit into Envjs, so we can display output to stdout (using
``console.log()``). Fortunately, QUnit explicitly provides a lot of hooks to do
everything we want, which I've implemented in a file named "setup.js", placed
alongside our other JavaScript libraries.

I mostly followed the excellent [guide][26] from the Envjs folks, and here's
the gist of my configuration for "setup.js":
<a name="setup.js"> </a>

{% assign special_fmt = '{%s}' %}
{% highlight javascript %}
load('env.rhino.1.2.js');
load('qunit.js');

var starttime = new Date().getTime();

// Envjs/QUnit Bridge.
Envjs({
    // Straight from the Envjs guide.
    scriptTypes: {
        "": true,
        "text/javascript": true
    },
    // Straight from the Envjs guide.
    beforeScriptLoad: {
        'sharethis': function (script) {
            script.src = '';
            return false;
        }
    },

    // Hook QUnit logging to console.
    afterScriptLoad: {
        'qunit': function () {
            var count = 0, testName;

            console.log("* QUnit test runner loaded.");

            // Grab current test name.
            QUnit.testStart = function(name, testEnvironment) {
                testName = name;
            };
            // Override log to display to stdout.
            QUnit.log = function (result, message) {
                // Strip out HTML in results messages.
                message = message.replace(/<\/?.*?>/g, '');
                console.log("  * {{ special_fmt }}(%s)[%s] %s",
                    testName, count++,
                    result ? 'PASS' : 'FAIL', message);
            };
            QUnit.done = function (fail, total){
                var endtime = new Date().getTime();
                var pass = total - fail;
                console.log("\n" +
                    "*****************\n" +
                    "* QUnit Results *\n" +
                    "*****************\n" +
                    "* PASSED: %s\n" +
                    "* FAILED: %s\n" +
                    "* Completed %s tests total in %s seconds.\n",
                    pass, fail, total,
                    parseFloat(endtime-starttime) / 1000.0);
           };
        },

        // Straight from the Envjs guide.
        '.': function (script) {
            script.type = 'text/envjs';
        }
    }
});
{% endhighlight %}

Note that the Envjs guide actually went further than this example, as the
guide's setup code writes the QUnit HTML report out to a new file. The
interesting thing about running JavaScript in Rhino is that code runs with
full system permissions outside of the JavaScript sandbox, so you can also do
normal file system manipulation. (And, as the Envjs documentation notes with
big scary warnings, there are huge security issues with running outside code
within an Envjs / Rhino environment).

### Test Runner

The last file we have to compose is our actual test runner.  Fortunately, this
is quite simple, as shown in "run-tests.js"-- just load the setup and point to
the test page:
<a name="run-tests.js"> </a>

{% highlight javascript %}
load('setup.js');

console.log("Starting QUnit tests...");
window.location = "test.html";
{% endhighlight %}

### Test it Out!

Now that we have Rhino, Envjs and QUnit all hooked together, it's time to
actually run some QUnit tests. Assuming your file / directory setup matches
the above contrived example, we should be able to run the tests by invoking
Rhino with our test runner script:

{% highlight text %}
$ java -cp ~/rhino1_7R2/js.jar org.mozilla.javascript.tools.shell.Main -opt -1 run-tests.js
[  Envjs/1.6 (Rhino; U; Mac OS X x86_64 1 ... ]
Starting QUnit tests...
* QUnit test runner loaded.
  * { addTwo }( 0 )[ PASS ]  Add nothing., expected: 0
  * { addTwo }( 1 )[ PASS ]  Add numbers., expected: 3
  * { addTwo }( 2 )[ PASS ]  Add negatives., expected: -3

*****************
* QUnit Results *
*****************
* PASSED:  3
* FAILED:  0
* Completed  3  tests total in  1.989  seconds.
{% endhighlight %}

Awesome. We have QUnit testing goodness for our library, running within Rhino,
and log / results output to the console, all through a single bash command. We
can add and include more libraries and test suites to test.html, and they
automatically get picked up by the test suite.

## Next Time -- Browserless AJAX, Playing with the DOM and More!

Today we examined and set up basic browserless JavaScript unit tests with
Rhino and Envjs. Despite the promises of the title of this post, we'll have to
wait until next time to extend out QUnit test suite to include actual / mocked
AJAX testing and DOM manipulation with this set up. But, just removing the
browser from the frontend test path is a great step towards more lightweight
JavaScript unit tests -- and situating us for the type of tests that developers
will want to write and run.

[2]: https://github.com/zepheira/exhibit3/blob/master/scripted/lib/setup.js
[3]: https://github.com/jquery/qunit/commit/a46610796b457fab05587945e743d4e857f580b5
[4]: https://github.com/orslumen/env-js/commit/c3e702cfa84872782dd40a2c4cd8a4c8f9bac3a3
[5]: https://github.com/ryan-roemer/envjs-1.2
[6]: https://github.com/thatcher/env-js
[7]: http://docs.jquery.com/Qunit
[8]: {{ pt2 }}
[9]: http://docs.djangoproject.com/en/dev/topics/testing/
[10]: http://fabfile.org/
[11]: http://seleniumhq.org/
[12]: http://www.getwindmill.com/
[13]: http://www.mozilla.org/rhino/
[14]: http://www.mozilla.org/js/spidermonkey/
[15]: http://code.google.com/p/v8/
[16]: http://ejohn.org/blog/bringing-the-browser-to-the-server/
[17]: http://ejohn.org/about/
[18]: http://jquery.org/
[19]: http://www.envjs.com/
[20]: ftp://ftp.mozilla.org/pub/mozilla.org/js
[21]: ftp://ftp.mozilla.org/pub/mozilla.org/js/rhino1_7R2.zip
[22]: http://www.envjs.com/release/envjs-1.2
[23]: http://www.envjs.com/dist/env.rhino.1.2.js
[24]: https://github.com/jquery/qunit/blob/a46610796b457fab05587945e743d4e857f580b5/qunit/qunit.css
[25]: https://github.com/jquery/qunit/blob/a46610796b457fab05587945e743d4e857f580b5/qunit/qunit.js
[26]: http://www.envjs.com/doc/guides

<!-- more end -->