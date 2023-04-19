---
title: Terraform vs Cloudformation
date: 2023-04-19T20:09:46+08:00
description: Terraform or Cloudformation for managing AWS infrastructure?
---

I have [issues with Terraform](https://dabase.com/blog/2022/terraform/), but I didn't make clear why I prefer Cloudformation.

|                          | **Terraform**                              | **Cloudformation**                                                 |
|--------------------------|--------------------------------------------|--------------------------------------------------------------------|
| Cloud agnostic           | Oversold due to differences with providers | AWS only                                                           |
| Modules                  | Often misunderstood but far easier to use  | There are modules and "Transforms" though are not very easy to use |
| Toolchain                | Great ecosystem of tooling                 | AWS tooling is lacking                                             |
| Language refactorability | HCL has some imperative constructs & offer alternate interfaces     | YAML describes the end state, i.e. solely declarative                   |
| Native                   | State  managed externally with lots of polling        | Has "stacks" & knows to wait without constant API retries      |
| Drift | Not actively able to point out drift | Can detect drift and can rollback |
| Documentation            | AWS Provider is a great reference, e.g. [S3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)      | AWS's is typically generated and misses nuances & notes, [S3](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket.html)            |
|                          |                                            |                                                                    |

## Serverless

Terraform is particularly painful to provision Serverless functions due to the role, permissions, the "aws_iam_role_policy_attachment", s3 bucket and other aspects like Cloudwatch and sns topics. A lot of boilerplate and it's not easy to get right. 

AWS Severless Application Model (SAM), a Cloudformation "Transform" is much easier to use for deploying Serverless functions.

## Toolchain: Shift left

Terraform has tooling to detect when declarations might violate security policies before it's applied. It's plan and apply workflow is a good way to see the impact (including cost!) of changes before you apply.

Cloudformation doesn't have a plan, the AWS tooling like AWS config only works once you've applied the changes. The catch issues is to carefully monitor path to production, where impact of changes are tracked from dev to staging to production using AWS tools like GuardDuty, Billing, Cloudtrail, Config which is far more difficult to do.

## The future of Cloudformation

AWS's Cloud Development Kit (CDK) is an imperative language that compiles to Cloudformation. However it has teething issues:

{{< tweet user="ibuildthecloud" id="1640919745435402240" >}}

{{< tweet user="ibuildthecloud" id="1641246127126360064" >}}

