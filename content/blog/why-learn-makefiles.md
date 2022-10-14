---
title: Why Learn Makefiles
date: 2022-10-07T16:02:18+08:00
description: Makefiles are the entry point to software projects
---

{{< youtube KS75B1hPwss >}}

# Why make?

<a href="https://en.wikipedia.org/wiki/Make_(software)">Make</a> is a software tool older than myself that new developers might over look, as being old and irrelevant.

The Makefile language **requires tabs** and that alone causes new users to abandon it.

There are some **good reasons to know basic Make**:

1. It's the **entrypoint** for [thousands of software projects](<https://codestat.dev/explorer?q=content%3Aoutput(.*%20-%3E%20project%20has%20makefile)%20path%3AMakefile%20type%3Apath%20count%3Aall%20select%3Arepo&t=number&dp=30>)
2. It's [fast](https://spin.atomicobject.com/2021/03/22/makefiles-vs-package-json-scripts/) 
3. `make` is present with any devel environment
3. The `Makefile` describes the rules on how the software is built!

# Tips to improving your Make experience

Use an $EDITOR that shows tabs:

> set list listchars=nbsp:¬,tab:»·,trail:·,extends:>

Keep it simple! Targets should be files, if not PHONY to be pedantic

Ensure bash completion works:

> [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

Try https://github.com/tj/mmake

# My own examples

- https://github.com/search?q=user%3Akaihendry+filename%3AMakefile&ref=simplesearch
- https://dabase.com/blog/2013/Makefile_based_static_site_generator/
