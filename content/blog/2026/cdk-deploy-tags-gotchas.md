---
title: "Tags are not free in AWS CDK"
date: 2026-02-24T10:30:58Z
description: "AWS CDK's --tags CLI flag has subtle gotchas: tags vanish in self-mutating pipelines, frequently-changing tags cause unexpected resource churn, and service-specific tagging quirks can break deployments."
---

`cdk deploy --tags key=value` feels like a safe, additive operation. It isn't always.

## The CDK team's own verdict

A CDK maintainer said it plainly in
[GitHub issue #9259](https://github.com/aws/aws-cdk/issues/9259):

> *"cdk deploy --tags should never have been a feature and you shouldn't be
> using it."*

The recommended approach is to apply tags inside your CDK app with `Tags.of(scope).add(key, value)`, passing dynamic values like commit hashes via environment variables at synth time. That bakes tags into the CloudFormation template rather than attaching them as stack-level metadata at deploy time.

## Tags disappear in self-mutating pipelines

CDK Pipelines self-mutates: after the first `cdk deploy`, the pipeline manages its own updates. Any `--tags` from the CLI are not carried into the CodeBuild environment that runs subsequent deploys — they're silently dropped on the next self-mutation. No error, the resources just stop having those tags.

## High-churn tags cause unnecessary mutations

Stamping a deployment with the current commit hash is a common tracing pattern:

```bash
cdk deploy --tags CommitHash=$(git rev-parse --short HEAD)
```

But every deployment becomes a tag change, and tag changes are CloudFormation mutations. For stateful resources or anything with long-running connections, that's unneeded risk. It also pollutes change sets, making it harder to see what actually changed in infrastructure.

## Tagging is inconsistent across AWS services

Not every resource handles tags the same way, and `--tags` won't warn you when it hits a service limit or quirk.

**S3 Access Points** are a concrete example. `CfnAccessPoint` uses a plain `CfnTag[]` array rather than CDK's `TagManager`, so `Tags.of(scope).add(...)` does **not** automatically propagate to it the way it does with L2 constructs — you must set tags explicitly in `CfnAccessPointProps`. The risk here is unexpected tag *absence*, not tag presence: if you're using ABAC and the tag silently never gets applied, access is denied with no configuration error. There's a further subtlety: the `aws:ResourceTag` condition key on an Access Point only covers the access point's own tags, not the underlying bucket's — a scope limitation that's easy to miss.

Other surprises:

- **Stage boundaries**: tags at the `App` level don't cross into `Stage` constructs — apply them at or below the stage.
- **Priority conflicts**: CDK tags are Aspects; when two conflict at the same priority, the one deepest in the construct tree wins, which can silently override intentional tags.
- **Hotswap**: `--hotswap` applies tag changes via service APIs directly, bypassing CloudFormation and drift detection.

## What to do instead

1. **Tag in code** with `Tags.of(scope).add(key, value)` — inject dynamic values via environment variables at synth time.
2. **Avoid high-churn values** (commit hashes, timestamps) on resources that are sensitive to updates.
3. **Verify service-specific behaviour** before using tags for anything policy-sensitive (ABAC, SCPs, resource policies).
4. **Use `cdk drift`** to surface out-of-band tag changes before they cause production surprises.

Related: [hardcodeDetector](https://github.com/kaihendry/hardcodeDetector) catches another CDK trap — hardcoding explicit resource names, which causes the same kind of unexpected churn and replacement.
