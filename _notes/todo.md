---
---

## Current

* Social:
  * Google Plus -- NOT IMPLMENTED
  * Facebook -- NOT IMPLMENTED
  * AddThis -- NOT IMPLMENTED
  * LinkedIn -- NOT IMPLEMENTED

* Style Classes
  * Do an image in the header (?)

## Later

* Images / Icons:

  * Favicon: Get going.
  * Apple-Touch: Get this going too.

* Sidebars:

  * Twitter feed.
  * Tag cloud.

## Log

* Old "more" hack:

```
{{ post.content | replace: "--", "DOUBLE_DASH" | replace: "<!DOUBLE_DASH", "<!--"  | replace: "DOUBLE_DASH>", "-->" | replace:"DOUBLE_DASH","&endash;&endash;" | replace:"more start -->","" | replace:"<!-- more end","" }}
{% comment %}END ESCAPE WACKINESS-->{% endcomment %}
```
