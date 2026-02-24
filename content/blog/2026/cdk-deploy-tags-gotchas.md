---
title: "Tags are not free in AWS CDK"
date: 2026-02-24T10:30:58Z
description: "AWS CDK's --tags CLI flag has subtle gotchas: tags vanish in self-mutating pipelines, frequently-changing tags cause unexpected resource churn, and service-specific tagging quirks can break deployments."
draft: true
---

`cdk deploy --tags key=value` looks like a convenient way to stamp resources at
deploy time. In practice, it has enough rough edges that you shouldn't treat it
as a free operation.

## The CDK team's own verdict

A CDK maintainer put it plainly in
[GitHub issue #9259](https://github.com/aws/aws-cdk/issues/9259):

> *"cdk deploy --tags should never have been a feature and you shouldn't be
> using it."*

That's a strong signal. The recommended alternative is to apply tags inside
your CDK app using the `Tags` API:

```python
from aws_cdk import Tags, App

app = App()
Tags.of(app).add("Environment", "production")
Tags.of(app).add("CommitHash", os.environ["COMMIT_SHA"])
```

This bakes tags into the CloudFormation template itself rather than passing
them as stack-level metadata at deploy time.

## Tags disappear in self-mutating pipelines

CDK Pipelines self-mutates: after the first `cdk deploy`, the pipeline takes
over its own updates. Any `--tags` you passed on the CLI are not propagated
into the CodeBuild environment that runs subsequent deploys. The tags are
silently dropped on the next self-mutation.

You won't get an error. The resources just stop having those tags.

## Frequently-changing tags cause unnecessary churn

A common pattern is stamping a deployment with the current git commit hash:

```bash
cdk deploy --tags CommitHash=$(git rev-parse --short HEAD)
```

This sounds useful for traceability but it means **every deployment is a tag
change**, and tag changes are CloudFormation mutations. Depending on the
resource type, a mutation can trigger an update, a replacement, or a
re-creation. For most resources this is fine, but for anything stateful or
with long-running connections it adds risk you didn't ask for.

The mutation also shows up in CloudFormation change sets, which can obscure the
actual infrastructure change you're reviewing.

## AWS tagging is not consistent across services

Not every AWS resource handles tags the same way, and `--tags` won't warn you
when it hits a service-specific limit or restriction.

**S3 Access Points** are a good example. The CDK's `CfnAccessPoint` construct
doesn't expose tags as a first-class property the same way L2 constructs do.
Tags applied via `Tags.of(accessPoint).add(...)` may not propagate as expected,
and Access Points used for attribute-based access control (ABAC) are
particularly sensitive — the wrong tag value, or a missing tag, can silently
break access policies.

Other common surprises:

- **Stage boundaries**: tags applied at the `App` level do not cross into
  `Stage` constructs. Resources inside a stage won't inherit app-level tags
  unless the tag is applied at the stage level or below.
- **Tag priority conflicts**: CDK applies tags as Aspects, and when two
  conflicting aspects share the same priority, the one closest to the bottom of
  the construct tree wins. This is not always obvious and can silently override
  intentional tags.
- **Hotswap deployments**: `cdk deploy --hotswap` applies tag changes directly
  through service APIs, bypassing CloudFormation. Those changes won't show up
  in drift detection.

## What to do instead

1. **Apply tags in code** using `Tags.of(scope).add(key, value)`. Pass dynamic
   values like commit hashes via environment variables read at synth time.
2. **Avoid high-churn tag values** (commit hashes, timestamps) unless you've
   confirmed the target resources tolerate frequent updates.
3. **Check service-specific tagging docs** before relying on tag propagation for
   anything security or policy-sensitive (ABAC, SCPs, resource policies).
4. **Use `cdk drift`** to catch out-of-band tag changes before they cause
   surprises in production.

The `--tags` flag isn't broken for simple cases, but it has enough sharp edges
that it's worth understanding before leaning on it.

Related: [hardcodeDetector](https://github.com/kaihendry/hardcodeDetector) catches another CDK trap — hardcoding names explicitly in your stack, which causes similar unexpected churn and replacement issues.
