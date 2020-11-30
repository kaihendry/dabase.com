---
title: When DevOps goes bad
date: 2020-09-18T09:55:20+08:00
description: Do not waste your investment with long build times and no local environment
toc: true
---

<img src="https://s.natalian.org/2020-09-18/brad-neathery-nPy0X4xew60-unsplash.webp" alt="Development iteration speed is critical">

How do you ensure your investment in Devops is making a positive impact?

Ask the developers if they are satisfied with the #devops adoption! Often the
_new modern workflow_ featuring containers and docker images.. is not actually
better for development and morale due to poor local workflows which
disenfranchise developers.

## How long does it take to deploy?

Simply update the YYYY of a footer of your Web application.
The commit change has been made. Now how long does it take for the
customer to view that change, from a `git push`?

Docker containers can be quite slow to provision, and assets to be pulled in.
There is a danger that if this process is unchecked, it can take well over 10
minutes. Lets not forget potential cache invalidation issues.

You don't want people to watch for CI/CD to finish. It should be fast, having a
reproducible environment isn't enough!

## How long takes it take you to roll back?

Sometimes it's not possible to roll back, because you had to make database /
data structure changes which make it non-trivial to back out of. In which case
you need to roll forward. Either way, can you reliably perform this?

You must allow for failure.

## Can you develop locally?

One danger of #devops is that as a developer you defer the build to the newly
created remote <abbr title="Continuous Integration">CI</abbr> pipeline and you
test in the staging environment. This is great for reproducibility, but
completely sacrifices development iteration speed and productivity.

You must have a local <abbr title="Continuous Integration">CI</abbr> workflow
where it's painless to run tests and develop locally with a [live reload
utility](https://github.com/codegangsta/gin).

Likewise the remote <abbr title="Continuous Deployment">CD</abbr> #devops
should not invalidate a local <abbr title="Continuous Deployment">CD</abbr>
workflow. If needs be you must **be able** to deploy locally.

Good local reliable deploys, make long remote deploys of 10mins+ become less of
an issue.

## Do you deploy daily?

If you don't deploy regularly you actually don't know if your pipeline is
resilient.  Dependencies and platforms change all the time, you must be in the
habit of deploying daily to be confident you have a reliable pipeline.

## Do you check (in) your dependencies?

If you don't check, update and importantly evaluate your dependencies, you will
have a fragile and possibly insecure pipeline. To matters worse, Docker allows
developers to easily express more dependencies, so be wary not to let the bloat
in!

To prevent dependency fragility, you might want to actually [check in your
dependencies](https://natalian.org/2019/11/15/Private_modules_with_Go_mod/) for
piece of mind.

## Conclusion

Do not overlook long build times and no local environment. A slow <abbr
title="Continuous Integration">CI</abbr>/<abbr title="Continuous
Deployment">CD</abbr>, without a local fallback, can negate your #devops
investment in first place.

Fast iterations facilitates value creation.
