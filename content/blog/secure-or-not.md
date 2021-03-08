---
title: Secure or not?
date: 2021-03-08T18:24:19+08:00
description: It's a trap to think there is a check box for security
---

After browsing <a
href="https://www.mas.gov.sg/-/media/MAS/Regulations-and-Financial-Stability/Regulatory-and-Supervisory-Framework/Risk-Management/TRM-Guidelines-18-January-2021.pdf">Singapore's
<abbr title="Technology Risk Management">TRM</abbr> Guidelines</a> from the
<abbr title="Monetary Authority of Singapore">MAS</abbr>, it just struck me
**what I don't like about it**.

The claim that something is **secure** or not.

> 6.2.2 The financial institution (FI) should ensure secure coding, source code review and application
> security testing standards are applied <u>during</u> Agile software development.

A fair reading of this requirement would suggest to me, employing say a
security linter like [gosec](https://github.com/securego/gosec) via some
[continuous
integration](https://github.com/kaihendry/badpath/blob/main/.github/workflows/gosec.yml).

However there is a couple of problems with this:

1. [Insecure code can pass through a linter](https://github.com/securego/gosec/issues/569)
2. There is no such thing as **secure** anything
3. Security vulnerabilities will be more likely to be found **after** not <u>during</u> development.

How does one address these issues?

1. Might not be solvable until an incident occurs, you're best chance is to
   have **continuous delivery** in place, to fix the problem in a timely manner!
2. Accept there is **no checkbox** for something to termed "secure". It's a **best effort** and some are better at it than others, choose wisely.
3. This requires specialised tooling especially if you don't do continuous delivery, i.e. run CI every day on your dependencies (e.g. npm audit)
