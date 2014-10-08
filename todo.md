---
---

## Current

* Theme this sucker!
  * Loose Bits old header (black with tagline).

* Continue porting over all old files
  * TODO: Check all the remaining files.

* Social:
  * Google Plus -- NOT IMPLMENTED
  * Facebook -- NOT IMPLMENTED
  * AddThis -- NOT IMPLMENTED
  * LinkedIn -- NOT IMPLEMENTED

* Styles
  * Embed Slide Share
  * Embed Video
  * Embed Prezi

* Style Classes
  * more

## Notes

* Date: `date -u +"%Y-%m-%d %H:%M:%S UTC"`
* Dev: `jekyll serve --baseurl / --watch --limit 3`
* Prod: `jekyll serve --baseurl / --watch`

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