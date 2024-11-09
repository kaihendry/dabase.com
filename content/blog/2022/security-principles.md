---
title: Security Principles💂
date: 2022-12-05T11:23:49+08:00
description: AWS security principles
---

The most important security principles:

# Principle of least privilege

This is [frustrating to implement if you start at the
very least instead of making it a goal](/blog/2022/least-privilege/).

Most "shift left" security linters will be blindly flagging your code for "IAM policy should
avoid use of wildcards and instead apply the principle of least privilege",
whilst in practice this is the only way to proceed.

It's a constant tradeoff of [ignoring naive
checks](https://github.com/aquasecurity/tfsec#ignoring-warnings), and
monitoring services like [IAM Access Advisor](https://aws.amazon.com/blogs/security/iam-access-analyzer-makes-it-easier-to-implement-least-privilege-permissions-by-generating-iam-policies-based-on-access-activity/).

# Principle of defense in depth

Preventing human error, "Guardrails" & "Governance" fall under this wide
ranging topic.

Here is a [good analysis of the defences required to secure a production S3
bucket](https://www.reddit.com/r/Terraform/comments/yyiqn6/developers_i_want_to_hear_from_you_have_you/iwy839t/).

Vigilance is key and to complete the picture you must have [organisation wide
**security event
monitoring**](https://aws.amazon.com/blogs/aws/new-amazon-cloudwatch-cross-account-observability/) like [AWS Cloudtrail](https://github.com/kaihendry/sam-cloudtrail-ec2)
in place.
