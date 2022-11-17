---
title: Where Terraform sucks
date: 2022-11-17T11:34:07+08:00
description: My complaints about Terraform in the context of Amazon Web Services
toc: true
---

## Terraform language (HCL) is painful

[0.12](https://www.hashicorp.com/blog/announcing-terraform-0-12) comes to mind as an awkward upgrade.

Gotchas like you can't use variables in init stanzas leading a lot of people to use [terragrunt](https://terragrunt.gruntwork.io/) which can add a lot of complexity for basic functionality.

The future of <abbr title="Infrastruture as Code">IaC</abbr> looks like using familiar bindings in common languages like Javascript and Go via CDK. No one enjoys [HCL](https://github.com/hashicorp/hcl/blob/main/hclsyntax/spec.md). HCL [tooling is horrible](https://stackoverflow.com/questions/74124530/how-do-i-rewrite-terraform-hcl-without-regex).

## Terraform state is non-trivial to manage

If you rename a stack, you must remember to rename the state file or location else you will have headaches deluxe.

## Blast factor

Most organisations split their IaC arbitrarily into different stacks. More stacks, the more difficult to deploy the complete infrastructure or just one service.

## Time outs

If you're waiting for infrastructure to provision and there is some break in connectivity or operation, **your state file will be inconsistent**.

You then need to do manual [import actions](/tips/cloud/2022/Terraform-Import/) to repair the situation.

## Serverless is super complex in Terraform

Cloudformation has `AWS::Serverless-2016-10-31` and Terraform requires you to manually setup everything.

- the log group
- execution role
- [IAM awkwardness aws_iam_role_policy_attachment](/tips/cloud/2022/Terraform-a-role/)
- the zip archive process
- the s3 bucket
- the networking

## Drift

The Terraform AWS provider is not perfect. AWS might change a value and then
your plan is inconsistent. This is called **drift** and it's [hard to manage](https://www.youtube.com/watch?v=Jh3pjr0uqWc).

## Destroy

You can detect destroys like so:

    terraform show --json tfplan | jq -r '.resource_changes[].change.actions[]' | grep -q delete && exit 2 || exit 0

Nonetheless there are times when you might need to refactor/rename something and
a destroy will be treated carefully in any production environment.

Often a destroy has led to a down service or worse, lost data, and it's difficult to know the impact and roll back.

## No support

If you have a problem with AWS Terraform, will AWS help? No, they will expect
you to use Cloudformation and be able to see your stack.

How do you get support from Hashicorp? The [forum is hit and
miss](https://discuss.hashicorp.com/) and good luck on [Github](https://github.com/hashicorp/terraform-provider-aws/issues).

## Bootstrapping

It's typical you need to bootstrap each AWS account with a [state bucket and
dynamodb table](https://gist.github.com/4fa171067e0b9ec909afba29a56ede6a).

This manual / "one off" step is difficult to automate.

## Not easy to debug

AWS resources often are interdependent and Terraform doesn't know about these complex relationships. Getting `depends_on` correct is non-trivial. And when it fails you don't know why because you can't see the stack's events.

Provisioning trivial stacks creates 100s of events!

<img src="https://i.imgur.com/wbV3q5J.png" alt="Cloudformation stacks">

When any event goes wrong you don't know the reason why and act upon it.

## Toolchain issues

Upgrading terraform and the [provider lock files](https://stackoverflow.com/questions/73970738/terraform-does-not-match-any-of-the-checksums-recorded-in-the-dependency-lock-fi) are not the same as package-lock.json or go.mod. Watch out!

## Module issues

The beauty of using terraform is thought to be re-using existing modules. In practice it is very difficult to find a module to do even basic infrastructure like provision a serverless function or setup a bucket / Cloudfront (CDN). You will quickly find doing things in [Cloudformation template files](https://github.com/kaihendry/s3-cloudfront-cloudformation/blob/main/template.yml) are much easier and robust.

## Conclusion

Terraform makes it harder to provision, debug and refactor <abbr title="Infrastruture as Code">IaC</abbr> than using native tooling.

Yes the {plan,apply} workflow is familiar, but it's let down by the operational deficiencies.
