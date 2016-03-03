---
layout: post
title:  Wrangling Lots of Projects with Builder Archetypes
description:
  We look at Builder archetypes, a module-based approach to centralize and
  control project tasks, dependencies, and more.
tags: ['builder', 'archetypes', 'react', 'javascript', 'npm']
---

## Builder, A Task Runner for Multiple Projects

In our [first Builder article][builder-post-01], we introduced _`builder`_ as
a task runner, similar in use and features to _`npm run`_, but some some really
nice extras for modern JavaScript projects.

In this post, we'll look beyond a single project and focus on perhaps the most
valuable aspect of the Builder ecosystem: coordinating and managing multiple
similar projects via a single point of control.

### Multi-project Madness

* TODO: The problem statement. React components, hapi plugins, etc.

### One Archetype to Rule Them All*

* TODO: One archetype controls
    * Multiple projects
    * Nearly identical
    * Complex workflows

* TODO: The "mission control" for a set of identical projects

* TODO: So, not actually one to control "all", just "all the identical ones".


### Working with Archetypes

* TODO: Example - install `builder` and `builder-react-component`.

* TODO: How an Archetype Works
    * Files:
        * _`package.json`_ - tasks, prod deps
        * _`dev/package.json`_ - dev deps
        * _`configs/`_ - files, etc.

    * Runtime
        * Load archetypes and add `scripts` tasks.
        * Mutate `PATH`, `NODE_PATH`
            * Resolution order.

    * Tasks:
        * Archetype and root project.
        * Special `npm:*` tasks.

    * Complexities:
        * `require.resolve()`
        * npm v3 flattening
        * Link to "archetype authoring" and "tips and tricks" in deck.



### Flexibility, Meta-tools, and Buying the Farm

* TODO: The problem of meta tools and buying the farm.
* TODO - POINT: Flexibility of via customizable overrides.
* TODO - POINT: "Just npm" -- can give up easily.


### Giving Up

* TODO - POINT: "Just npm" -- can give up easily.


<!-- more start -->

[builder-post-01]: TODO_INSERT_LINK
[fmd]: http://formidablelabs.com/
[builder]: https://github.com/FormidableLabs/builder
[builder-init]: https://github.com/FormidableLabs/builder-init
[builder-react-component]: https://github.com/FormidableLabs/builder-react-component

<!-- more end -->
