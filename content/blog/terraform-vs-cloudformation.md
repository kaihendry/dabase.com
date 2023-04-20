---
title: Terraform vs Cloudformation
date: 2023-04-19T20:09:46+08:00
description: Terraform or Cloudformation for managing AWS infrastructure?
---

I have [issues with Terraform](https://dabase.com/blog/2022/terraform/), but I didn't make clear why I prefer Cloudformation.

|                          | **Terraform**                              | **Cloudformation**                                                 |
|--------------------------|--------------------------------------------|--------------------------------------------------------------------|
| Cloud agnostic           | Oversold due to differences with providers | AWS only                                                           |
| Modules                  | [Often misunderstood but far easier to use](https://dabase.com/blog/2022/terraform/#modules-misunderstood)  | There are modules and "Transforms" though are not easy to use |
| Toolchain                | Great ecosystem of "shift left" tooling                 | AWS tooling only works once infrastructure created                                            |
| Language refactorability | HCL has some imperative constructs & offers alternate interfaces/abstractions     | YAML describes the end state, i.e. solely declarative                   |
| Native                   | State managed externally with lots of polling        | "stacks" best maintain state & knows to wait without API retries      |
| Documentation            | AWS Provider is a great reference, e.g. [S3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)      | AWS's is typically **generated** and misses notes, [S3](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket.html)            |

## Serverless

Terraform is particularly painful to provision Serverless functions due to the
role, permissions, the "aws_iam_role_policy_attachment", s3 bucket and other
aspects like Cloudwatch and sns topics. A lot of boilerplate and not easy to
get right for Terraform to deploy lambda.

AWS Severless Application Model (SAM), a Cloudformation "Transform" is much
easier to use for deploying Serverless functions.

## Toolchain: Shift left

Terraform has tooling to detect when declarations might violate security /
organisational policies before it's applied.

Terraform's key **plan and apply** workflow is a good way to see the impact
(including cost!) of changes before you apply. This makes it much easier to
review infrastructure changes.

Cloudformation doesn't have Terraform's workflow and the AWS compliance tooling
like AWS config only works once you've applied the changes. To catch issues is
to carefully monitor your environments "path to production", where impact of
changes are tracked (via tags?) from dev to staging to production. AWS has a
whole suite of Governance / security tools like GuardDuty, Billing, Cloudtrail,
Config which are all need knowledge and experience to effectively use.

## The future of Cloudformation

AWS's Cloud Development Kit (CDK) is an imperative language that compiles to
Cloudformation. However it has teething issues:

{{< tweet user="ibuildthecloud" id="1640919745435402240" >}}
{{< tweet user="ibuildthecloud" id="1641246127126360064" >}}
{{< tweet user="ibuildthecloud" id="1648893333127811076" >}}

## Conclusion

The choice between Terraform and Cloudformation is not a clear cut one. For
larger teams, Terraform's "shift left", flexibility and "blast radius" is
industry proven. For smaller perhaps more knowledgable teams, Cloudformation's
simplicity and declarative nature is a good fit, depending on the use case.


* [Terraform vs Cloudformation Discussion on Reddit](https://www.reddit.com/r/Terraform/comments/yxjkks/terraform_vs_cloudformation/)
