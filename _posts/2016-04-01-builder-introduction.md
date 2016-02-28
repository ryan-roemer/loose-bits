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
desirable to have one project and published _`npm`_ module per component.

<!-- TODO: GET LINK for npm workflows -->

A modern trend is to use _`npm`_ to manage workflows via the _`scripts`_ field
of a project's _`package.json`_ file. This is a fantastic approach for single
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

Enter '[`builder`][]', a new tool for managing multiple independent projects.
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

* **You Can Give Up**: Builder tries to remain as close to a basic _`npm`_
  workflow as possible. So much so, that the project README gives detailed steps
  for removing Builder and going back to just _`npm`_ workflows.

* **A Few "Nice to Haves" Over _`npm run <task>`_**: Setting aside archetypes
  and multi-project management, _`builder`_ provides cross-OS compatible helpers
  for common task running scenarios like concurrent execution (_`concurrent`_)
  and spawning the _same_ tasks in parallel with different environment variables
  (_`env`_). It also provides useful controls for task retries, buffered output,
  setup tasks, etc.

Put more succintly, we like to think of Builder as "_almost_ _`npm`_", just with
a few extras and central control.

You can see Builder in action in the [Formidable Labs][fmd] [Victory][victory]
project, which comprises over ten different React components for data
visualisations. The projects use Babel, Webpack, Karma, Eslint, and a many
number other tools and tasks. But the workflows involved are all _nearly the
same_ for each repository.

The Victory project manages all development / build / quality worklow tasks with
Builder through _`scripts`_ commands defined in a single module, the
'[`builder-victory-component`][]' archetype. With Builder in place, we only have
one place to worry about tweaking our build commands, adding new checks or
tests to our quality tasks, etc.

### Let's Explore Builder!

With that introduction, we're going to do a series of post on various aspects
of the Builder project ecosystem:

* **Builder as a Command Line Tool**: In this post, we'll look at using
  _`builder`_ on the command line as a replacement for _`npm run`_ with some
  very useful additional features.
* **Builder Archetypes**: We will introduce "archetype" projects which control
  _`scripts`_ and dependencies for multiple projects. We will explain how to
  command and control multiple identical projects with a single archetype
  and tips, tricks, and potential stumbling blocks along the way.
* **Builder Initialization**: An archetype can further define templates that
  the _`builder-init`_ tool can use to bootstrap a new project from user-entered
  prompts.

Putting all of this together, Builder provides a comprehensive, yet lightweight
and flexible way to create and manage your multi-repository projects.

<!-- more start -->

## The Builder Command Line Tool

For the rest of this article, we're just going to talk about using 'builder'
as a replacement for _`npm run`_ in a single project. No multiple projects, no
archetypes, no initialization -- we'll have more articles to come in the future
for those fun topics.

At its core, _`builder`_ is a tool that consumes _`package.json`_ files and can
execute tasks specified in the _`scripts`_ field, much like _`npm`_ does.

### _`npm run`_ Scripts

The _`npm`_ tool that we all know and love for installing dependencies is also a
powerful task runner. For example, if we have a _`package.json`_ file that looks
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

we can use _`npm run <task-name>`_ to run them with the following results

```sh
$ npm run fail
# ... SNIPPED ...
npm ERR! Exit status 1

$ npm run hello
hello

$ NAME=Ryan npm run hello-env
Hello Ryan
```

### Builder Actions

Builder provides three basic task running options: _`run`_, _`concurrent`_, and
_`envs`_, each of which we will discuss in turn.

<!-- TODO LINK README -->
#### Builder Run

The first action that builder provides is _`builder run`_, analogous to
_`npm run`_. In fact, for a single project, we get identical output for those
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

The _`run`_ action goes a little beyond _`npm`_ by accepting some useful flags
including:

* _`--tries`_: Number of times to attempt a task (default: _`1`_)
* _`--setup`_: Single task to run for the entirety of _`<action>`_.

With these flags, we could, for example, try a task "n" number of times before
considering it a failure, which is useful for things like flaky functional tests.

```sh
$ builder run --tries=3 fail
[builder:proc:retry] 2 tries left, Command: false
[builder:proc:retry] 1 tries left, Command: false
[builder:builder-core:end:13171]
  Task: run fail, Error: Command failed: /bin/sh -c false
```

<!-- TODO LINK README -->
#### Builder Concurrent

The _`concurrent`_ action enables you to run multiple tasks at the same time and
then (by default) stop on the first error. This is useful for things like
development watched builds, running tests in parallel, etc. And, it is
conveniently cross-OS compatible.

With just _`npm`_ you would need to do something like:

```sh
$ npm run <task1> & npm run <task2> & npm run <task3>
```

but without fine-grained control over reporting back task failures, retrying,
etc.

With _`builder`_, this becomes:

```sh
$ builder run <task1> <task2> <task3>
```

or in our working example:

```sh
$ NAME=Ryan builder concurrent hello-env hello-env hello hello
Hello Ryan
Hello Ryan
hello
hello
```

The _`concurrent`_ action has a good number of powerful flags for dealing with
the complexities of executing a lot of different tasks in parallel:

* _`--queue`_: Number of concurrent processes to run (default: unlimited - _`0|null`_)
* _`--[no-]buffer`_: Buffer output until process end (default: _`false`_)
* _`--[no-]bail`_: End all processes after the first failure (default: _`true`_)

It also supports the familiar _`--tries`_ and _`--setup`_ flags we discussed
for the _`run`_ action.

<!-- TODO LINK README -->
#### Builder Envs

The _`envs`_ action is for when you'd like to run the _same_ task concurrently,
but with different environment variables for each task invocation. This
scenario comes up in various testing scenarios such as running the same
functional test suite against multiple browsers distinguished by a
_`BROWSER=chrome_` environment variable.

With just _`npm`_ you would need to do something like:

```sh
$ NAME=Bob  npm run hello-env & \
  NAME=Bill npm run hello-env & \
  NAME=John npm run hello-env

Hello John
Hello Bill
Hello Bob
```

With _`builder`_ you pass a JSON array string of environment variables to use:

```sh
$ builder envs hello-env \
  '[{"NAME":"Bob"}, {"NAME":"Bill"}, {"NAME":"John"}]'

Hello Bob
Hello Bill
Hello John
```

Like _`concurrent`_ the Builder _`envs`_ command gives you the same control
flags for fine grained task control including: _`--queue`_, _`--[no-]buffer`_,
_`--[no-]bail`_, _`--tries`_ and _`--setup`_ f


### Builder in Action

These three Builder actions provide a lot of power and flexibility for sprucing
up your _`package.json`_ tasks. Let's look over a couple of real-world examples
out in the open source world.

* `TODO: Little-loader`
* `TODO: Requirepack`


And that's about it! The _`builder`_ command line tool is not really
revolutionary or a drastic change when used alone in a project, but it provides
some very _nice_ and _useful_ features for running _`scripts`_ tasks in your
_`npm`_-based workflows.

[fmd]: http://formidablelabs.com/
[`builder`]: https://github.com/FormidableLabs/builder
[`builder-init`]: https://github.com/FormidableLabs/builder-init
[`builder-react-component`]: https://github.com/FormidableLabs/builder-react-component
[`builder-victory-component`]: https://github.com/FormidableLabs/builder-victory-component
[victory]: http://victory.formidable.com

<!-- more end -->
