---
title: Does Dockerfile USER prevent Linux container breakouts?
date: 2023-03-25T18:29:54+08:00
description: Is adding a USER best practice?
---

As an Infra Devops Lead, I'm often reviewing Dockerfiles that are unnecessarily
complex due to USER permissions. A never ending source of bugs and permission
issues.

When trying to simplify them, the "security savvy" might claim that I'm not
adhering to [Principle of least
privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege) or
[Separation of
duties](https://twitter.com/shinygoldbars/status/1638368021940178949) by not
dropping privileges and introducing a security risk of a **container
breakout**.

My thinking is that Linux container should actually **contain** the process!
Like BSD jails, **jail**.

When I [voiced my opinion on Reddit about USER best
practice](https://www.reddit.com/r/docker/comments/11x3itv/is_adding_a_user_best_practice/),
I was downvoted, and now my post sits at 4 points.

On twitter the conversation went in my favour:

{{< x user="ibuildthecloud" id="1638366204514684928" >}}

And the conversation raised points:

- privileged != root, [do not get confused](https://twitter.com/ibuildthecloud/status/1638788245264961538)
- if you are concerned about container breakout, [linux microvm is what you should use](https://twitter.com/ibuildthecloud/status/1638920893488594946)
- if you are worried about root containers, do you operationally [block them](https://twitter.com/ibuildthecloud/status/1638428212404568064)?
- if you are worried about root containers, do you operationally [run them as a different UID?](https://twitter.com/allingeek/status/1638595225068404736)

To conclude we shouldn't be pushing [security
theatre](https://en.wikipedia.org/wiki/Security_theater) on application
developers. The underlying system should be secure, like BSD!

Adding USER to your Dockerfile is not worth the trade off.
