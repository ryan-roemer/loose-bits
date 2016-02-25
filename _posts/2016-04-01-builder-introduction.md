---
layout: post
title:  Introducing Builder, an npm-based Task Runner
description:
  We introduce the Builder collection of tools for multi-project workflows
  and tour the 'builder' command line tool.
tags: ['builder', 'javascript', 'npm']
---

## A Task Runner for Modern JavaScript

### Things are Hard

Modern JavaScript development is **complicated**. We have application
frameworks, build tools, test / quality scripts, and even a mutable language
target with the meteoric rise of Babel and ES-next.

Often, a single development project can encompass tens or even hundreds of
different repositories. Especially for React components, where it is often
desirable to have one project and published 'npm' module per component.

<!-- TODO: GET LINK for npm workflows -->

A modern trend is to use 'npm' to manage workflows via the 'scripts' field of
a project's 'package.json' file. This is a fantastic approach for single
projects to keep dependencies slim and tasks flexible. However, the approach
doesn't really scale when you're coordinating many (say 5-50) very similar
repositories.

All in all, managing development complexity across many repositories is an
increasingly daunting task. Many projects have basically "given up" on
distributed projects in favor of monolithic repositories to hone down the number
of configurations, tasks, and dependencies needed to publish many small pieces
of software. And the rest of us are left wondering if there is a way to keep
the flexibility and decoupling benefits of independent projects in the face
of these frustrations...

### A Path Forward for Multiple Projects?

Enter '[builder][]', a new tool for managing multiple independent projects.
Builder is typically appropriate for situations involving:

* **multiple** projects / repositories
* with **nearly identical** tasks and dependencies
* with complex development / build / test **workflows**

As a "meta-tool", the Builder project focuses relentlessly on keeping project
and task management _lightweight_ and the overall scheme _flexible_ with
guiding principles that include:

* **Flexibility**: There are a number of meta tools for controlling JavaScript
  workflows / development lifecycles. However, most are of the "buy the farm"
  nature. This works great when everything is within the workflow but falls
  apart once you want to be "just slightly" different. Builder solves this by
  allowing fine grain task overriding by name, where the larger composed tasks
  still stay the same and allow a specific repository to "go off script" in an
  easy, understandable, and precise manner.

* **You Can Give Up**: Builder tries to remain as close to a basic 'npm'
  workflow as possible. So much so, that the project README gives detailed steps
  for removing Builder and going back to just 'npm' workflows.

* **A Few "Nice to Haves" Over 'npm run \<task\>'**: Setting aside archetypes and
  multi-project management, 'builder' provides cross-OS compatible helpers for
  common task running scenarios like concurrent execution ('concurrent') and
  spawning the _same_ tasks in parallel with different environment variables
  ('env'). It also provides useful controls for task retries, buffered output,
  setup tasks, etc.

Put more succintly, we like to think of Builder as "_almost_ 'npm'", just with
a few extras and central control.

You can see Builder in action in the [Formidable Labs][fmd] [Victory][victory]
project, which comprises over ten different React components for data
visualisations. The projects use Babel, Webpack, Karma, Eslint, and a many
number other tools and tasks. But the workflows involved are all _nearly the
same_ for each repository.

The Victory project manages all development / build / quality worklow tasks with
Builder through 'scripts' commands defined in a single module, the
'[builder-victory-component][]' archetype. With Builder in place, we only have
one place to worry about tweaking our build commands, adding new checks or
tests to our quality tasks, etc.

### Let's Explore Builder!

With that introduction, we're going to do a series of post on various aspects
of the Builder project ecosystem:

* **Builder as a Command Line Tool**: In this post, we'll look at using
  'builder' on the command line as a replacement for 'npm run' with some very
  useful additional features.
* **Builder Archetypes**: We will introduce "archetype" projects which control
  'scripts' and dependencies for multiple projects. We will explain how to
  command and control multiple identical projects with a single archetype
  and tips, tricks, and potential stumbling blocks along the way.
* **Builder Initialization**: An archetype can further define templates that
  the 'builder-init' tool can use to bootstrap a new project from user-entered
  prompts.

Putting all of this together, Builder provides a comprehensive, yet lightweight
and flexible way to create and manage your multi-repository projects.

<!-- more start -->

## The Builder Command Line Tool

For the rest of this article, we're just going to talk about using 'builder'
as a replacement for 'npm run' in a single project. No multiple projects, no
archetypes, no initialization -- we'll have more articles to come in the future
for those fun topics.

At its core, 'builder' is a tool that consumes 'package.json' files and can
execute tasks specified in the 'scripts' field, much like 'npm' does.

### 'npm run' Scripts

The 'npm' tool that we all know and love for installing dependencies is also a
powerful task runner. For example, if we have a 'package.json' file that looks
like:

```js
{
  "scripts": {
    "fail": "false",
    "hello": "echo hello",
    "hello-env": "echo Hello ${NAME}"
  }
}
```

we can use 'npm run \<task-name\>' to run them with the following results

```sh
$ npm run fail
# ... SNIPPED ...
npm ERR! Exit status 1

$ npm run hello
hello

$ NAME=Ryan npm run hello-env
Hello Ryan
```

<!-- TODO LINK README -->
### 'builder run'

The first action that builder provides is 'builder run', analogous to
'npm run'. In fact, for a single project, we get identical output for those
three task commands:

```sh
$ builder run fail
# ... SNIPPED ...
[builder:builder-core:end:13162] Task: run fail, Error: Command failed: /bin/sh -c false

$ builder run hello
hello

$ NAME=Ryan builder run hello-env
Hello Ryan
```

The 'run' action goes a little beyond 'npm' by accepting some useful flags
including:

* '`--tries`': Number of times to attempt a task (default: '`1`'')
* '`--setup`': Single task to run for the entirety of '`<action>`'.

With these flags, we could, for example, try a task "n" number of times before
considering it a failure, which is useful for things like flaky functional tests.

```sh
$ builder run --tries=3 fail
[builder:proc:retry] 2 tries left, Command: false
[builder:proc:retry] 1 tries left, Command: false
[builder:builder-core:end:13171]
  Task: run fail, Error: Command failed: /bin/sh -c false
```



[fmd]: http://formidablelabs.com/
[builder]: https://github.com/FormidableLabs/builder
[builder-init]: https://github.com/FormidableLabs/builder-init
[builder-react-component]: https://github.com/FormidableLabs/builder-react-component
[builder-victory-component]: https://github.com/FormidableLabs/builder-victory-component
[victory]: http://victory.formidable.com

<!-- more end -->
