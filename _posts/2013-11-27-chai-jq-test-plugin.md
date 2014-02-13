---
layout: post
title: chai-jq - jQuery Assertions for Chai
description:
  chai-jq is a plugin for the Chai test assertion framework that
  adds a set of jQuery specific assertions for JavaScript application testing.
tags: ['chai', 'jquery', 'javascript', 'testing']
---

## A New jQuery Plugin for Chai

[Chai][chai] is a wonderful JavaScript test assertion library that I rely on
extensively (usually using it in conjunction with the [Mocha][mocha] test
framework library). Chai has an intuitive, natural-language approach to
assertions that enables you tests to read almost like an English narrative.
Chai also supports plugins which extend the base assertion API.

Chai is quite often used for frontend JavaScript testing, and specifically for
testing jQuery elements in an application web page. There is an existing
[chai-jquery][chai_jquery] plugin for Chai, which is extensive and really
quite neat. Unfortunately, it has a [few issues][chai_jquery_issues] with
overriding built-in Chai assertions like `have` and `length` in ways that
changes the underlying Chai API.

With that motivation in mind, I hacked together a quick jQuery plugin,
[`chai-jq`][plugin_site] for Chai that has a separate `$`-prefixed namespace to
avoid collisions with existing Chai assertions, and put the project up on
[GitHub][plugin_repo].

## The chai-jq Plugin

The [`chai-jq`][plugin_site] plugin has full documentation at the
[project website][plugin_site], including installation instructions.
The plugin works in all of the following environments:

* **Browser**: Via a standard `<script>` tag include.
* **Browser + AMD**: Via an AMD library like [RequireJS][requirejs].
* **Node.js + JsDom**: In Node.js using the JsDom browser environment
  emulator.

In terms of what [`chai-jq`][plugin_site] provides, here is a brief tour of the
API (stolen from the project docs):

<!-- more start -->

### `.$visible`

Asserts that the element is visible.

{% highlight javascript %}
expect($("<div>&nbsp;</div>"))
  .to.be.$visible;
{% endhighlight %}

See: [http://api.jquery.com/visible-selector/](http://api.jquery.com/visible-selector/)

### `.$hidden`

Asserts that the element is hidden.

{% highlight javascript %}
expect($("<div style=\"display: none\" />"))
  .to.be.$hidden;
{% endhighlight %}

See: [http://api.jquery.com/hidden-selector/](http://api.jquery.com/hidden-selector/)

### `.$val(string|regexp)`

Asserts that the element value matches a string or regular expression.

{% highlight javascript %}
expect($("<input value='foo' />"))
  .to.have.$val("foo").and
  .to.have.$val(/^foo/);
{% endhighlight %}

See: [http://api.jquery.com/val/](http://api.jquery.com/val/)

### `.$class(string)`

Asserts that the element has a class match.

{% highlight javascript %}
expect($("<div class='foo bar' />"))
  .to.have.$class("foo").and
  .to.have.$class("bar");
{% endhighlight %}

See: [http://api.jquery.com/hasClass/](http://api.jquery.com/hasClass/)

### `.$attr(name, string)`

Asserts that the target has exactly the given named attribute, or
asserts the target contains a subset of the attribute when using the
`include` or `contain` modifiers.

{% highlight javascript %}
expect($("<div id=\"hi\" foo=\"bar time\" />"))
  .to.have.$attr("id", "hi").and
  .to.contain.$attr("foo", "bar");
{% endhighlight %}

See: [http://api.jquery.com/attr/](http://api.jquery.com/attr/)

### `.$prop(name, value)`

Asserts that the target has exactly the given named property.

{% highlight javascript %}
expect($("<input type=\"checkbox\" checked=\"checked\" />"))
  .to.have.$prop("checked", true).and
  .to.have.$prop("type", "checkbox");
{% endhighlight %}

See: [http://api.jquery.com/prop/](http://api.jquery.com/prop/)

### `.$html(string)`

Asserts that the target has exactly the given HTML, or
asserts the target contains a subset of the HTML when using the
`include` or `contain` modifiers.

{% highlight javascript %}
expect($("<div><span>foo</span></div>"))
  .to.have.$html("<span>foo</span>").and
  .to.contain.$html("foo");
{% endhighlight %}

See: [http://api.jquery.com/html/](http://api.jquery.com/html/)

### `.$text(string)`

Asserts that the target has exactly the given text, or
asserts the target contains a subset of the text when using the
`include` or `contain` modifiers.

{% highlight javascript %}
expect($("<div><span>foo</span> bar</div>"))
  .to.have.$text("foo bar").and
  .to.contain.$text("foo");
{% endhighlight %}

See: [http://api.jquery.com/text/](http://api.jquery.com/text/)

### `.$css(name, string)`

Asserts that the target has exactly the given CSS property, or
asserts the target contains a subset of the CSS when using the
`include` or `contain` modifiers.

{% highlight javascript %}
expect($("<div style=\"width: 50px; border: 1px dotted black;\" />"))
  .to.have.$css("width", "50px").and
  .to.have.$css("border-top-style", "dotted");
{% endhighlight %}

See: [http://api.jquery.com/css/](http://api.jquery.com/css/)

The [`chai-jq`][plugin_site] plugin is just getting off the ground and is
likely still rough around the edges. Any [issue reports][plugin_issues],
[pull requests][plugin_pulls], and feedback are most welcome.


[chai_jquery]: https://github.com/chaijs/chai-jquery
[chai_jquery_issues]: https://github.com/chaijs/chai-jquery/issues/30
[plugin_issues]: https://github.com/FormidableLabs/chai-jq/issues
[plugin_pulls]: https://github.com/FormidableLabs/chai-jq/pulls
[plugin_repo]: https://github.com/FormidableLabs/chai-jq
[plugin_site]: http://formidablelabs.github.io/chai-jq/
[chai]: http://chaijs.com/
[mocha]: http://visionmedia.github.io/mocha/
[requirejs]: requirejs.org

<!-- more end -->
