---
layout: page
div_class: archive
title: Archive
---

<div class="row">
{% for post in site.posts %}
<div class="archive">
  <time datetime="{{ post.date | xmlschema }}">
    {{ post.date | date: "%Y-%m-%d" }}
  </time> -
  <strong><a href="{{ post.url }}">{{ post.title }}</a></strong>
  <p>{{ post.description }}</p>
</div>
{% endfor %}
</div>
