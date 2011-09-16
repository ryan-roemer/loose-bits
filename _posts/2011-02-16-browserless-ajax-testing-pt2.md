---
layout: post
title: Browserless AJAX Testing with Rhino and Envjs, Part 2.
description: Test DOM manipulation in your jQuery/AJAX JavaScript code without
  a browser using Rhino and Env.js.
date: 2011-02-16 15:17:00 UTC
permalink: /2011/02/browserless-ajax-testing-with-rhino-and_16.html
tags: ['javascript', 'dom', 'django', 'envjs', 'ajax', 'python', 'test',
       'rhino']
---
{% capture pt1 %}{{ site.baseurl }}2011/02/browserless-ajax-testing-with-rhino-and.html{% endcapture %}

## Introduction

This is the second of two posts looking at browserless AJAX / JavaScript
testing with [Rhino][1] and [Envjs][2]. [Last time][3], we set up Rhino and
Envjs to run a basic set of [QUnit][4] tests from the command line, exercising
pure JavaScript code with no AJAX or DOM manipulation.  Today, we will add
tests for code that hacks on the DOM and makes AJAX calls.

Let's start with the files we had last time (with links to previous blog
post):

* **``env.rhino.1.2.js``**: Envjs for Rhino.
* [**``qunit.css``**][5]: QUnit styles. (*Link to known working version*).
* [**``qunit.js``**][6]: QUnit code. (*Link to known working version*).
* [**``setup.js``**][7]: Our custom hook Envjs to QUnit.
* [**``run-tests.js``**][8]: Include our setup script and actually invoke the
  tests at on our test HTML page.
* [**``my-lib.js``**][9]: An example JavaScript library (that we want to test).
* [**``my-tests.js``**][10]: An example custom QUnit tests for my-lib.js.
* [**``test.html``**][11]: Basic QUnit HTML page (see QUnit documentation) with
  script links to "my-lib.js" and "my-tests.js".

## New Files and Tests

Let's add some new libraries and tests to our working set, to include DOM
actions and AJAX:

<!-- more start -->

* **``jquery.js``**: The venerable [jQuery library][12], which we'll use for
  DOM and AJAX calls.
* [**``my-tests2.js``**][13]: Our new tests, described in full detail below.
* my-lib2.js: We'll add two functions -- one which does simply DOM manipulation
  with events, the other which does an AJAX call and inserts the text from
  another URL into a div element.

{% highlight javascript %}
// my-lib2.js
/**
 * Add text and clickable elements to div.
 */
function addTextAndClicker($div, text) {
  $div.
    text(text).
    css('color', "rgb(0, 0, 0)").
    css('cursor', "pointer");
  $div.click(function () {
    $div.
      css('color', "rgb(255, 255, 255)").
      css('cursor', "default");
  });
}

/**
 * Dump text from URL into 'code' div.
 */
function dumpText($div, url, callback) {
  $.ajax({
    type: 'GET',
    url: url,
    dataType: 'text',
    success: function (data) {
      // Update the div.
      // Note: The "<pre/>" tag has some issues with Envjs.
      $("<code />").appendTo($div).text(data);

      // User callback.
      if (callback) {
        callback();
      }
    }
  });
}
{% endhighlight %}

Interestingly, I originally had the ``dumpText()`` function create a new
"&lt;pre/&gt;" tag, but something between Rhino and Envjs did not like it, and
Rhino would error out on running this code. So, I switched to "&lt;code/&gt;"
and everything worked fine. I guess the point is that nothing absolutely
substitutes for a real browser, but Envjs does a really great job
notwithstanding!

## Serving Our Files for AJAX

One important thing to note is that because we are doing AJAX calls now, we
quickly will run into the [same origin policy][15].  To easily get around this
for purposes of this demonstration, open a new terminal window, point it to
the test directory we're working in and serve all files in the directory
directly from localhost with the python built-in web server (here I chose port
8001):

{% highlight text %}
$ cd /path/to/test/code
$ python -m SimpleHTTPServer 8001 .
{% endhighlight %}

Check things out by navigating a real browser to:
http://127.0.0.1:8001/test.html.  Our QUnit tests from last time should run in
the window.

## Testing our New Code

Now that we have created our new library and are running a slim web server (so
we can actually make AJAX requests), let's write some test code in "my-
tests2.js".  At the module level, we make use of the QUnit setup and teardown
options to attach test div elements to the QUnit fixture element, so we can
actually do some (temporary) DOM manipulation.

We use an asynchronous test pattern for the ``dumpText`` AJAX tests to handle
latency between the call and response.  The call to ``stop()`` stops QUnit
execution to allow the code and tests to run.  If the asynchronous callback
doesn't finish (and invoke ``start()``) within the designated time period
(here 1 second), then QUnit will raise an error.  Assuming we have given
ourselves enough time, once ``start()`` is invoked, then QUnit starts up again
for the remaining tests and a final summary.  For a good overview of QUnit
testing with asynchronous examples, see
"[How to Test your JavaScript Code with QUnit][16]".

Here's everything together for "my-tests2.js":
<a name="my-tests2.js"> </a>

{% highlight javascript %}
module("my-lib2", {
  /**
   * Add new elements before each test.
   */
  setup: function () {
    var self = this;

    // Store test page fixture.
    self.$fixture = $('#qunit-fixture');

    // Create new test div's.
    self.$addText = $('<div/>').
      attr('id', "add-text").
      appendTo(self.$fixture);

    self.$dumpText = $('<div/>').
      attr('id', "dump-text").
      appendTo(self.$fixture);
  },

  /**
   * Remove tests elements after.
   */
  teardown: function () {
    var self = this;

    // Remove test div's
    self.$addText.remove();
    self.$dumpText.remove();
  }
});

test("addTextAndClicker", function () {
  var self = this;
  equals(self.$addText.text(), "", "Div starts empty");

  // Add the text and clicker.
  addTextAndClicker(self.$addText, "Hi There!");
  equals(self.$addText.text(), "Hi There!", "Div has text");
  equals(self.$addText.css('color'),
         "rgb(0, 0, 0)", "Starting color");
  equals(self.$addText.css('cursor'),
         "pointer", "Changed cursor");

  // Click the clicker and check.
  self.$addText.click();
  equals(self.$addText.text(), "Hi There!","Div still has text");
  equals(self.$addText.css('color'),
         "rgb(255, 255, 255)", "Changed color");
  equals(self.$addText.css('cursor'),
        "default", "Changed cursor");
});


test("dumpText", function () {
  var self = this;
  equals(self.$dumpText.text(), "", "Div starts empty");

  // Stop QUnit execution to wait for AJAX call and tests.
  stop(1000);  // Wait up to 1 second.

  // Perform AJAX call.
  // Just dump our setup script as straight text.
  dumpText(self.$dumpText, "http://127.0.0.1:8001/setup.js",
    function () {
    // Now, run tests.
    var $code = self.$dumpText.find('code');
    equals($code.length, 1, "Verify code element.");

    // Find some known text strings.
    var find = function (text) {
      ok($code.html().indexOf(text) != -1,
         "Find string \"" + text + "\"");
    };
    find("beforeScriptLoad");
    find("afterScriptLoad");
    find("QUnit test runner loaded");
    find("QUnit.log");

    // Restart QUnit execution.
    start();
  });
});
{% endhighlight %}

Now, lets update our "test.html" file to run both our previous and new unit
tests (and add the jQuery dependency):

{% highlight html %}
<html>
  <head>
    <title>QUnit</title>
    <link rel="stylesheet" href="qunit.css" type="text/css" />
    <script type="text/javascript" src="qunit.js"></script>
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="my-lib.js"></script>
    <script type="text/javascript" src="my-tests.js"></script>
    <script type="text/javascript" src="my-lib2.js"></script>
    <script type="text/javascript" src="my-tests2.js"></script>
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

Finally, we need to tweak "run-tests.js" to point to the locally served test
page instead of simply the local filesystem.

{% highlight javascript %}
load('setup.js');

console.log("Starting QUnit tests...");
window.location = "http://127.0.0.1:8001/test.html";
{% endhighlight %}

And, let's run the tests!

{% highlight text %}
$ java -cp ~/rhino1_7R2/js.jar org.mozilla.javascript.tools.shell.Main -opt -1 run-tests.js
[  Envjs/1.6 (Rhino; U; Mac OS X x86_64 10.6.6; en-US; rv:1.7.0.rc2) Resig/20070309 PilotFish/1.2.13  ]
Starting QUnit tests...
* QUnit test runner loaded.
  * { addTwo }( 0 )[ PASS ]  Add nothing., expected: 0
  * { addTwo }( 1 )[ PASS ]  Add numbers., expected: 3
  * { addTwo }( 2 )[ PASS ]  Add negatives., expected: -3
  * { addTextAndClicker }( 3 )[ PASS ]  Div starts empty, expected: ""
  * { addTextAndClicker }( 4 )[ PASS ]  Div has text, expected: "Hi There!"
  * { addTextAndClicker }( 5 )[ PASS ]  Starting color, expected: "rgb(0, 0, 0)"
  * { addTextAndClicker }( 6 )[ PASS ]  Changed cursor, expected: "pointer"
  * { addTextAndClicker }( 7 )[ PASS ]  Div still has text, expected: "Hi There!"
  * { addTextAndClicker }( 8 )[ PASS ]  Changed color, expected: "rgb(255, 255, 255)"
  * { addTextAndClicker }( 9 )[ PASS ]  Changed cursor, expected: "default"
  * { dumpText }( 10 )[ PASS ]  Div starts empty, expected: ""
  * { dumpText }( 11 )[ PASS ]  Verify code element., expected: 1
  * { dumpText }( 12 )[ PASS ]  Find string "beforeScriptLoad"
  * { dumpText }( 13 )[ PASS ]  Find string "afterScriptLoad"
  * { dumpText }( 14 )[ PASS ]  Find string "QUnit test runner loaded"
  * { dumpText }( 15 )[ PASS ]  Find string "QUnit.log"

*****************
* QUnit Results *
*****************
* PASSED:  16
* FAILED:  0
* Completed  16  tests total in  2.981  seconds.
{% endhighlight %}

From the results, we can see that we now have all of our unit tests running
from pure JavaScript code to our new DOM manipulation and AJAX calls.

## Other Enhancements

Beyond the setup we discussed today, there are several really cool additions
and improvements you can add to your browserless testing solution.

### Use Mocks for AJAX Calls

Although running a simple python web server gets us through this demonstration
pretty easily for our AJAX calls, in practice AJAX calls might rely on more
than a simple static server can provide. At that point, you either have to
deal with running your development web application server at the same time, or
switch to mocking out the AJAX calls.  A great solution is to use fantastic
[MockJax][17] jQuery plugin, which overrides $.ajax() calls to substitute with
a configurable mock response.

### Add Code Coverage Reports

Amazingly, the [JSCoverage][18] code coverage library does work with this
Rhino  and Envjs setup. I hooked things up by running jscoverage-server in a
similar fashion to how we did the command line python server above (which
completely replaces the need for it), and then added the following to
"setup.js" in the QUnit.done option:

{% highlight javascript %}
QUnit.done = function (fail, total){
  // ... previous code ...

  // Code coverage report.
  if (window.jscoverage_report) {
    console.log("Writing coverage report.");
    jscoverage_report();
  }
};
{% endhighlight %}

It is important that the coverage report come at the very **end** of the
QUnit.done handler to ensure that all of our tests truly are finished running.
See the JSCoverage [manual][19] for more details about running the coverage
server and writing reports.

## Conclusion

Revisiting the original motivation for this post series, the original pain
point was that frontend tests are complicated to write and a hassle to run.
With the fully browserless testing environment we have explored here, it is
possible to create a system out of Rhino, Envjs and QUnit that runs all tests
with a single command line argument, making the former hassle into something
so easy you could add it to your pre-/post- commit hooks in your version
control software. And, by being able to write our tests in mostly straight
QUnit (with a little extra setup help), test writing for developers remains
relatively straightforward, even dealing with AJAX, etc.

[1]: http://www.mozilla.org/rhino/
[2]: http://www.envjs.com/
[3]: {{ pt1 }}
[4]: http://docs.jquery.com/Qunit
[5]: https://github.com/jquery/qunit/blob/a46610796b457fab05587945e743d4e857f580b5/qunit/qunit.css
[6]: https://github.com/jquery/qunit/blob/a46610796b457fab05587945e743d4e857f580b5/qunit/qunit.js
[7]: {{ pt1 }}#setup.js
[8]: {{ pt1 }}#run-tests.js
[9]: {{ pt1 }}#my-lib.js
[10]: {{ pt1 }}#my-tests.js
[11]: {{ pt1 }}#test.html
[12]: http://jquery.com/
[13]: {{ page.url }}#my-tests2.js
[15]: http://en.wikipedia.org/wiki/Same_origin_policy
[16]: http://net.tutsplus.com/tutorials/javascript-ajax/how-to-test-your-javascript-code-with-qunit/
[17]: http://enterprisejquery.com/2010/07/mock-your-ajax-requests-with-mockjax-for-rapid-development/
[18]: http://siliconforks.com/jscoverage/
[19]: http://siliconforks.com/jscoverage/manual.html

<!-- more end -->