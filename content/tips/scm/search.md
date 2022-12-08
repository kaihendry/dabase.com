---
date: 2022-12-08
title: Searching for a git commit message
description: fatal command line, '[FOOBAR-1234]' Invalid range end
---

Remove the brackets to look at all commits matching **[FOOBAR-1234]**

    git log -p --grep="FOOBAR-1234"
