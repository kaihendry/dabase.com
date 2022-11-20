---
title: Where Terraform sucks
date: 2022-11-17T11:34:07+08:00
description: Complaints about Terraform in the context of Amazon Web Services
toc: true
---

## Terraform language (HCL) is painful

[0.12](https://www.hashicorp.com/blog/announcing-terraform-0-12) comes to mind as an awkward upgrade.

Gotchas like you can't use variables in init stanzas leads teams to
adopt [terragrunt](https://terragrunt.gruntwork.io/) which can add a lot of
complexity for basic functionality.

The future of <abbr title="Infrastruture as Code">IaC</abbr> looks like using
familiar bindings in common languages like Javascript and Go via CDK. No one
enjoys [HCL](https://github.com/hashicorp/hcl/blob/main/hclsyntax/spec.md). HCL
[tooling is
lacking](https://stackoverflow.com/questions/74124530/how-do-i-rewrite-terraform-hcl-without-regex).

Developers hate HCL and hence Devops / SRE is born: A developer who endures HCL
and slow iterations.

## Terraform state is non-trivial to manage

If you rename a stack, you must remember to rename the state file or location
else your infrastructure will be broken.

Don't forget to lock access to state when working in a team and if you have
timeouts, prepare to run `terraform force-unlock` manually out of your pipeline.

## Blast radius

Most organisations split their IaC arbitrarily into different stacks. The more
stacks, the more difficult to deploy the complete infrastructure or just one
service if someone decided to split it up. Painful.

[Refactoring
terraform](https://developer.hashicorp.com/terraform/language/modules/develop/refactoring)
of someone's overzealous splits to make things sensible is even more painful.

## Time outs

If you're waiting for infrastructure to provision and there is some break in
connectivity or operation, **your state file will be inconsistent**.

You then need to do manual [import actions](/tips/cloud/2022/Terraform-Import/)
to repair the situation.

This easily happens when provisioning modern infrastructure (_cough_
Kubernetes) takes well over twenty minutes.

## Serverless is super complex in Terraform

Cloudformation has `AWS::Serverless-2016-10-31` and Terraform requires you to
manually setup everything.

- the log group
- execution role
- [IAM awkwardness aws_iam_role_policy_attachment](/tips/cloud/2022/Terraform-a-role/)
- the zip archive process
- the s3 bucket
- the networking

Update: You might want to try [serverless.tf](https://www.reddit.com/r/Terraform/comments/yxmmdf/where_terraform_sucks/iwq4z7y/)

## Helm (Kubernetes) doesn't make sense with Terraform

Using [helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) is awkward with Terraform.

With Kubernetes objects (YAML) you are better off with a Gitops workflow using
ArgoCD.

Two IaC git repos is very common; org-{tf,k8s}. Do not mix k8s declarations with terraform!

## Drift

The Terraform AWS provider is not perfect. AWS might change a value and then
your plan is inconsistent. This is called **drift** and it's [hard to manage](https://www.youtube.com/watch?v=Jh3pjr0uqWc) across stacks and environments.

Manual remediation of mismatching actual and desired state across stacks is
unsustainable. Better ideas are Gitops workflows and higher level constructs
like Cloudformation, which try to enforce IaC intent.

## Destroy

You can detect destroys like so:

    terraform show --json tfplan | jq -r '.resource_changes[].change.actions[]' | grep -q delete && exit 2 || exit 0

Nonetheless there are times when you might need to refactor/rename something and
a destroy will be treated carefully in any production environment.

Often a destroy has led to a down service or worse, lost data, and it's
difficult to know the impact (without a lot of experience) and roll back.

## Poor support

If you have a problem with AWS Terraform, will AWS help? No, they will expect
you to use Cloudformation and be able to see your stack (see "Not easy to debug").

The [forum is hit and miss](https://discuss.hashicorp.com/) and good luck on [Github](https://github.com/hashicorp/terraform-provider-aws/issues).

How do you get support from Hashicorp? Deploying [Terraform Enterprise](https://developer.hashicorp.com/terraform/enterprise) or foisted on the Terraform Cloud which isn't an option for some highly regulated companies.

## Bootstrapping

It's typical you need to bootstrap each AWS account with a [state bucket and
dynamodb table](https://gist.github.com/4fa171067e0b9ec909afba29a56ede6a).

This manual / "one off" step is difficult to automate.

## Not easy to debug

AWS resources often are interdependent and Terraform doesn't know about these
complex relationships. Getting `depends_on` correct is non-trivial. And when it
fails you don't know why because you can't see the stack's events.

Provisioning trivial stacks creates 100s of events!

<img src="https://i.imgur.com/wbV3q5J.png" alt="Cloudformation stacks">

When any event goes wrong you don't know the reason why and act upon it. That's
because you're using Terraform.

AWS's native tooling Cloudformation rolls back by default when provisioning goes
wrong or at least gives a **clear indication of why something failed**. With terraform you will be left to picking up the pieces when changes
inevitably go wrong.

## Re-run plan, apply and pray

When things go wrong, the plan is inconsistent. The typical solution is to
re-run. It sounds silly, but it actually happens where you need to re-run a
{plan,apply} 3-4x times for AWS to provision a complex shared networking
infrastructure!

This might be avoided with `depends_on`, though as mentioned this is really not
easy to get right without knowing the details of the underlying Cloud service.

## Dumb and Slow

Terraform tries to create a resource and polls until it exists unlike native
tooling which is aware of the events and dependencies.

You won't have a good idea of progress and often you will hit timeouts on
complex Kubernetes stacks. Especially if you do things like manipulate
[aws_auth_roles](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest),
which will only work when the EKS is up after ~20 minutes.

## Upgrade issues

Upgrading terraform and the [provider lock
files](https://stackoverflow.com/questions/73970738/terraform-does-not-match-any-of-the-checksums-recorded-in-the-dependency-lock-fi)
are not the same as Node's package-lock.json or go.mod. Watch out!

Terraform is constantly changing and it's difficult to find a stable route to
upgrade. As a result many organisations use old terraform versions that manifest the
problem!

## Modules misunderstood

The beauty of using terraform modules is thought to be re-using existing
third-party solutions. In practice, off the shelf
[modules](https://registry.terraform.io/) are a [leaky
abstraction](https://en.wikipedia.org/wiki/Leaky_abstraction) and introduce
dependencies that are difficult to manage (Hint: `.terraform.lock.hcl` won't help!).

**The real reason to use modules is organisational compliance.**

Do not think of opensource Terraform community modules as being plug and play
components to solve your infrastructure gaps. They are often generic, bloated
and won't meet your organisation's (compliance) requirements.

## Conclusion

Terraform makes it harder to provision, debug and refactor <abbr
title="Infrastruture as Code">IaC</abbr> than using native tooling.

The future is probably a mix of something like `aws cloudformation deploy`
after using [CDK](https://aws.amazon.com/cdk/) to generate the YAML, and
managing your Kubernetes with a Gitops workflow.

Gone is Terraform's beloved plan and apply, and naive polling to ensure
resources are there. Infrastructure is no longer some static
independent resources, which Terraform served well.
