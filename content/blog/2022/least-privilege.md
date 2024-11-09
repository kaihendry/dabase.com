---
title: Least Privilege in Practice
date: 2022-08-24T11:12:35+08:00
description: You can't start from the bottom, it wastes time
---

[The Principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege) is often
mis-understood as starting from Zero privileges and working out what
privileges that particular role needs and adding them...

This bottom up approach has a significant trade off, it wastes time!

It's not practical in most cases to go in tedious iterations and examine errors
to work out what required permissions. Often the permissions errors are not
verbose for a start, not giving you enough information to make permission
additions!

Even AWS suggest:

> You might start with broad permissions while you explore the permissions that
> are required for your workload or use case. As your use case matures, you can
> work to reduce the permissions that you grant to work toward least privilege.

https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#grant-least-privilege

# Start with Administrator Access

    { "Action": "*", "Effect": "Allow", "Resource": "*" }

The line above aka
[AdministratorAccess](https://github.com/glassechidna/trackiam/blob/master/policies/AdministratorAccess.json)
makes people very nervous but it's the **only practical way** to proceed when
starting to deploy new projects, ideally in new accounts.

# Work backwards

Once you have your service working, you start dropping privileges. Ideally the
[IAM Access
Analyser](https://www.reddit.com/r/aws/comments/wo1pn0/how_do_you_handle_creation_of_least_privilege/ik90d2n/)
would be useful here, but often it's not.

Best practice often means dropping IAM privileges (e.g. AWS Power User), then
to [managed
roles](https://github.com/glassechidna/trackiam/tree/master/policies) and then
trying to specific about the resources it affects.

However note that when you re-provision from scratch you often need the IAM
privileges again to bootstrap!

# The Goal is least privilege

You can get there in two ways, top or bottom, the efficient way to get there
is starting from the top with **AdministratorAccess**, like it or not.
