Tasks
=====

## Current

* Social: Add integrations (see old site at: 4624aea9e08b466939bf7baf617fcf8f03912c14)
  * Google Plus
  * Facebook
  * AddThis
  * LinkedIn

* Header
    * Do an image in the header (?)

* Navbar
    * Style navbar differently (?) Image/gradient background (?)

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
