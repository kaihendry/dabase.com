---
title: "Snowflake IaC without switching to Terraform"
date: 2026-03-10T10:00:00Z
description: "Using CDK Terrain with the official Snowflake Terraform provider"
---

Scenario: you already use CDK, your team is happy, and you use CDKTF for
non-AWS resources.

Then HashiCorp (now owned by IBM) sunsets CDKTF, and suddenly it feels like you
must run both CDK and plain Terraform/HCL in the same pipelines.

That is the panic moment. But that is not where things end up.

Using [CDK Terrain](https://cdktn.io/), you can consume the **official**
Snowflake Terraform provider and stay in a CDK-first workflow.

My proof-of-concept repo:

https://github.com/kaihendry/snowflake-cdktn

## Hashicorp drops the Cloud Development Kit

HashiCorp deprecated CDKTF and archived the upstream repository the same day, on December 10, 2025

- https://github.com/hashicorp/terraform-cdk/commit/a0c56138e2b4c7b6c128bd7ba08a8e317df852af
- https://github.com/hashicorp/terraform-cdk

CDK Terrain is the [community
continuation](https://github.com/open-constructs/cdk-terrain/commits/main/). In
practice, it preserves the CDKTF workflow and gives a more CDK-consistent way
to keep using the Terraform provider ecosystem.

## Why I still want CDK over plain Terraform

- **Type checking and IDE support**: autocomplete, compile-time checks, and
  first-class language tooling.
- **Real refactoring**: rename symbols, extract abstractions, and reorganize
  IaC like normal software.
- **Testability**: infrastructure can be unit-tested with standard test
  frameworks.
- **Better abstraction for complex systems**: CDK constructs are reusable,
  composable modules instead of repeating verbose config.
- **Level 2 constructs**: CDK is much more flexible to express Organisational
  patterns and guard rails that would be very difficult to do with Terraform.


For complex infrastructure, CDK gives me the software engineering ergonomics I
want, while Terraform providers still do the provisioning.

If you need to deploy Snowflake at scale, CDK is still a viable option.
