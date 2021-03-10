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

A fair reading of this _secure coding_ requirement would suggest to me, employing say a
security linter like [gosec](https://github.com/securego/gosec) via some
[continuous
integration](https://github.com/kaihendry/badpath/blob/main/.github/workflows/gosec.yml) aka <abbr title="Continuous Integration">CI</abbr>.

However there is a couple of problems with this:

1. [Insecure code can pass through a linter](https://github.com/securego/gosec/issues/569)
2. There is no such thing as **secure** anything
3. Security vulnerabilities will be more likely to be found **after** not <u>during</u> development.

How might one address these issues?

1. Might not be solvable until an incident occurs, you're best chance is to
   have **continuous delivery** in place, to be able fix the problem in a timely manner!
2. Accept there is **no checkbox** for something to termed "secure". Build security in with the  [shift left approach](https://en.m.wikipedia.org/wiki/Shift-left_testing). Have a security champion in your team.
3. This requires specialised tooling especially if you do not deploy with CI every day on your dependencies (e.g. npm audit)

My colleagues in China have
[BuildSecurityIn](https://www.buildsecurityin.net/en/) to explain a methodology
with security built into your development process. I'm confident the authors of
the <abbr title="Technology Risk Management">TRM</abbr> document from <abbr
title="Monetary Authority of Singapore">MAS</abbr> want the same thing, though
I'm just nitpicking about how to express that.


Retorts: [Roland suggests I am reading the TRM too closely](https://twitter.com/rolandturner/status/1369512342203944964) 🤣
