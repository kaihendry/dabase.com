---
title: ⚠️  The Dangers of DevOps ⚠️
date: 2020-09-18T09:55:20+08:00
description: Do not waste your investment with long build times and no local environment
toc: true
---

<img src="https://s.natalian.org/2020-09-18/brad-neathery-nPy0X4xew60-unsplash.webp" alt="Development iteration speed is critical">

How do you know if your investment in Devops is making a positive impact?

Ask the developers if they are satisfied with the #devops adoption. Often the
_new modern workflow_ featuring containers and docker images.. is not actually
better for development and morale due to poor local workflows.

## How long does it take to deploy?

Simply update the YYYY of a footer of your Web application.
The commit change has been made. Now how long does it take for the
customer to view that change, from a `git push`?

Docker containers can be quite slow to provision, and assets to be pulled in.
There is a danger that if this process is unchecked, it can take well over 10
minutes. Lets not forget potential cache invalidation issues.

You don't want people to watch for CI/CD to finish.

## How long takes it take you to roll back?

Sometimes it's not possible to roll back, because you had to made database /
data structure changes which make it non-trivial to back out of. In which case
you need to roll forward. Either way, can you reliably perform this?

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
workflow. If needs be you really must be able to deploy locally.

Good local reliable deploys, make long remote deploys of 10mins+ become less of
an issue.

## Do you deploy daily?

If you don't deploy regularly you actually know if your pipeline is resilient.
Dependencies and platforms change all the time, you must be in the habit of
deploying daily to be confident you have a reliable pipeline.

## Do you check you dependencies?

If you don't check, update and importantly evaluate your dependencies, you will
have a fragile and possibly insecure pipeline. To matters worse, Docker usually
allows more dependencies, so be wary not to let the bloat in!

## Conclusion

Do not overlook long build times and no local environment. These can negate
your #devops investment in first place.
