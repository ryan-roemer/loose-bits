---
layout: default
title: Home
---

{% for post in site.posts limit:5 %}
  <div class="post">
    {% include post_header.html %}
    <div class="excerpt">
      {{ post.content | replace:'more start -->','' | replace:'<!-- more end','' }}
    </div>
    <div class="more">
      Read <a href="{{ post.url }}">more</a>...
    </div>
  </div>
{% endfor %}
