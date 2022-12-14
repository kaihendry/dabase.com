---
title: Why use AWS Customer Managed Keys?
date: 2022-12-14T21:23:18+08:00
description: tfsec promotes CMK keys over AWS managed KMS, how come?
---

[tfsec promotes CMK usage as mentioned in my
video](https://youtu.be/uyZ91ipqxVk). But why <abbr title="Customer Managed
Key">CMK</abbr> and what's the trade off?

The [table on the official AWS documentation](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-mgmt) doesn't spell out why you would want to use CMK over AWS-Managed.

I've asked around and the reasons are:

- encrypted EBS Snapshots can’t be shared using AWS managed keys
- Non-CMK KMS key cannot be shared across accounts
- KMS CMKs in particular become necessary for many cross-account data sharing configurations, such as passing encrypted bucket data to another account.
- Can be used as a "Kill switch" once disabled, which renders the data inaccessible. If the key is deleted (minimum 7 day wait), the data is permanently inaccessible

# Cost of <abbr title="Customer Managed Key">CMK</abbr>

$1/key/month, but with yearly rotation you pay an extra $1/key/month for the previous versions too.

# Key policy is the last line of defence for IAM policy errors

KMS is the only service where both the IAM principal policy AND the resource
policy has to allow access. In S3, if either of those allowed access than the
Principal would have access. That’s not true for KMS. The key policy must still
allow it.

So if you accidentally gave \* to a Principal the key policy could still prevent
access.

# Reasons not to use CMK

It's not unusual for a **key per app/service/team adding costly complexity**
for little benefit. Overzealous security reasoning includes: "Separation of
concerns" and the "Principle of least privilege". It's like have an SSL
**certificate for every subdomain and application and team**.

Having to orchestrate infrastructure with a specific key makes every \*.tfvars
to require an extra parameter like `kms_master_key_id`. If you don't manage the
key and policy carefully you might accidentally lock out your data.

The threat model is arguably just local to the AWS account, and likelyhood of
AWS-managed and encrypted data being exposed is both unlikely and limited to
essentially AWS. Hence the extra overhead of managing keys for internal
communication outweigh the surface area of the threat. Especially considering
there are probably far easier ways for AWS to intercept your data if you didn't
embrace the [shared security
model](https://aws.amazon.com/compliance/shared-responsibility-model/).
