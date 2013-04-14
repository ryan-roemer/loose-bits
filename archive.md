---
layout: page
div_class: archive
title: Archive
---

<div class="row clearfix">
{% for post in site.posts %}
<div class="archive">
  <time class="span2" datetime="{{ post.date | xmlschema }}">
    {{ post.date | date: "%Y-%m-%d" }}
  </time>
  <div class="item span9">
    <strong><a href="{{ post.url }}">{{ post.title }}</a></strong>
    <p>{{ post.description | strip_html }}</p>
  </div>
</div>
{% endfor %}
</div>

