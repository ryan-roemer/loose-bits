---
layout: page
div_class: archive
title: Archive
---

{% for post in site.posts %}
  <div class="archived-post clearfix">
    <time datetime="{{ post.date | xmlschema }}">
      {{ post.date | date: "%Y-%m-%d" }}
    </time>
    <div class="item">
      <a href="{{ post.url }}">{{ post.title }}</a>
      <p>{{ post.description | strip_html }}</p>
    </div>
  </div>
{% endfor %}
