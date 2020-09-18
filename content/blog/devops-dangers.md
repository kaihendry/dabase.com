---
title: The Dangers of DevOps
date: 2020-09-18T09:55:20+08:00
description: How do you know if your investment in Devops is making a positive impact?
---

What are the most important implements to a #devops workflow?

# How long does it take to deploy?

You simply update the YYYY of a footer of your Web application. The change has
been made. Now how long does it take for the customer to view that change, from
a `git push`?

Docker containers can be quite slow to provision, and assets to be pulled in.
There is a danger that if this process is unchecked, it can take well over 10
minutes. Lets not forget potential cache invalidation issues.

# How long takes it take you to roll back?

Sometimes it's not possible to roll back, because you had to made database /
datastructure changes which make it non-trivial to back out of. In which case
you need to roll forward. Either way, can you reliably perform this? And
measure it?

# Can you develop locally?

One danger of #devops is that as a developer you defer the build to the CI and
you test in the staging environment. This is great for reproducibility, but
completely sacrifices development iteration speed and productivity.
