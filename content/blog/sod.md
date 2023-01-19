---
title: Separation of Duties
date: 2023-01-19T15:01:04+08:00
draft: true
description: Separation of Duties without the manual gatekeeping
---

In large organisations https://en.wikipedia.org/wiki/Separation_of_duties  **kills productivity**.

The dogma is:

> No single team should have end to end access from code to production.

> Dev should not deploy code to production.

> Ops should not write code.

## Why?

Separation of duties is a key concept of internal controls, **controls** performed manually by different teams, e.g. "Dev" & "Ops". Today, we have tools that can automate these processes and provide protections from fraud and errors via **controls**.

## Rise of DevOps

DevOps is a cultural movement that aims to bridge the gap between development and operations, to increase productivity. Combining software development (Dev) and IT operations (Ops) aims to shorten the systems development life cycle and provide continuous delivery with high software quality.

Though how are the **controls** enforced? 

How do we prevent a rogue DevOps team member from deploying risky code or practices to production?

## Automated checks & controls

<a href="https://docs.gitlab.com/ee/user/application_security/index.html#application-coverage">
<img src="https://docs.gitlab.com/ee/user/application_security/img/secure_tools_and_cicd_stages.png">
</a>

When a new feature is committed as a Merge Request, it is automatically tested by a CI/CD pipeline. The pipeline is configured to run tests, security scans, and other checks. If the pipeline fails, the <abbr title="Merge Request">MR</abbr> is not merged. This prevents risky code from being deployed to production.

* **Another team member** approves the <abbr title="Merge Request">MR</abbr> else it is not merged - eliminates rogue actor, though **team must be must be trusted**
* Ability to **roll back** via the CI/CD pipeline - derisk deployments
* **Logs** to a central account - accountability / auditability
* Platform Guardrails, like AWS Account controls such as: [Control tower](https://aws.amazon.com/controltower/), [SCPs](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html), [AWS Config](https://aws.amazon.com/config/)
* Costing - drive efficiency and cost optimisation

<img src="https://s.natalian.org/2023-01-19/cost-usage.png" alt="Costing and usage">

Further automations/checks can triggered from the **logs**, such as [CloudTrail](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html) and [CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html).

## Avoid <abbr title="Separation of Duties">SoD</abbr> smells (lack of automation)

- Gate keeping - teams must be empowered, that looks like having their own AWS account and being able to deploy their own application
- Network team needs to open a port for you - team with AWS account should conduct their own effective networking
- "Throwing things over the wall" - team should be able to handle everything themselves given the tools
- _Separation of concerns!_ - this assumes that the team is not trusted and automation is not in place
- Ticket based infrastructure - team is not empowered to do what they need to do, e.g. they lack AdministratorAccess in their AWS account
- Not being allowed to view other repositories / gate keeping - **teams needs to foster open collaboration**
- Auto devops - this assumes the team isn't capable of managing their build pipeline
- Audit - this assumes that the team is not trusted, checks are not in place and logging exports are not in place
- The Operations team will run it for you - for DevOps to work, the team needs to be trusted and use managed services like "Serverless" to deploy their application without fuss, "you build it, you run it"
- Not being allowed to access production data - ideally shouldn't happen, but if it does, it's logged. 

## <abbr title="Separation of Duties">SoD</abbr> pain is alleviated by automation and working closer together

This is my AWS / 2023 interpretation of the <abbr title="Continuous Delivery">CD</abbr>-Friendly <abbr title="Separation of Duties">SoD</abbr> procedures for Configuration outlined upon https://www.slideshare.net/sriramnrn/segregation-of-duties-and-continuous-delivery from slide 27, by my colleague [Ram](https://www.sriramnarayanan.com/segregation-of-duties-and-continuous-delivery/).

Best practices / tooling will evolve over time, though the idea is to remove **manual gatekeeping checks** via automation. 

1. AWS accounts provide most controls out the box, use it!
2. CI/CD pipeline providers like Github/Gitlab provide a lot of checking automations to opt in to. 
3. Communication tools like Slack make it easy for teams to foster open collaboration so that expertise can be shared.