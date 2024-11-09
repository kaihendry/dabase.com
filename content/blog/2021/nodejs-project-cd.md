---
title: Mitigating security risks with NodeJS
date: 2021-10-13T17:36:57+08:00
description: What is the best way to manage node JS security issues?
---

I'm new to supporting a complex production nodejs project.

My gut feeling was to employ package management tools like:

* npm audit
* npx depcheck
* npx npm-check-updates

However [npm audit oftens flags high
issues](https://overreacted.io/npm-audit-broken-by-design/), which are largely
the problem of the underlying dependencies. The risks are really hard to gauge.
Most of the time they feel like false alerts.

So now what?

Ensure every package is updated to keep a better security posture? That's an
endless treadmill.

There are [plenty of
tools](https://github.com/lirantal/awesome-nodejs-security), though I am
missing a good **conservative philosophy**.
