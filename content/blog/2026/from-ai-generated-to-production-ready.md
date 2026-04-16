---
title: "From AI-Generated to Production-Ready: Closing the Gap"
description: "AI can write code fast, but getting it to production requires the same rigour as any other code — testing, review, observability, and ownership. Here's how to bridge that gap."
date: 2026-04-16T15:25:19+01:00
---

When [creating a green field software project with AI](https://github.com/kaihendry/cream), what makes that code "Production quality"?

From a "proof of concept", instinctively I would:

* add tests (main_test.go) to capture the current tested functionality
* add a .github/workflow to ensure it builds and can be distributed

As a bonus I would add some sort of tagging / version release that is exhibited whilst running the app, e.g. v0.0.1

# But more seriously

A collegue suggested, how would you gather feedback that the product solved
your users needs?

This is non-trivial, since you need adoption for feedback. Stars? Tweets? Email
feedback? Telemetry? How do you capture and intrepret this?

How would you then improve on that product? If you host the software product on
the Web, this is seamless, else you need to consider releasing the software as
a package. Now you need a Continuous Deployment.
