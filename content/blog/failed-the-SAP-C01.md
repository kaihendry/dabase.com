---
title: "Failed the AWS Certified Solutions Architect professional exam"
date: 2020-03-18T09:48:37+08:00
---

Yesterday I took and failed the SAP-C01 exam. You may have noticed I scribbled
some [preparation notes earlier](https://dabase.com/blog/AWS_Pro_exam_notes/).

Candidate score was 730 and I needed 750 to pass. So I was close, but it showed
at least to me some gaps in my knowledge:

* How big is a Snowball: [~80TB](https://docs.aws.amazon.com/snowball/latest/ug/limits.html) and do consider you can have **multiple** (aka scale out)
* VM Import/Export - is this the way you export VMs to AWS from an on premise data center? I thought one used [CloudEndure](https://www.cloudendure.com/)..
* Various <abbr title="Active Directory">AD</abbr> configurations or rather migration strategies. If a client has an <abbr title="Active Directory">AD</abbr> controller on premises, what is needed to move it to the AWS Cloud? Connector and then? <https://tutorialsdojo.com/aws-directory-service/>
* Various Cloudformation questions. Like if you have an existing setup in one region, can you **export** the Cloudformation template and just run it with a changed region parameter?
* Even though I've used AWS ECS for years, some questions about the [task roles](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) and [awsvpc](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html) versus `bridge` confused me.
* Routing <abbr title="with respect to">wrt</abbr> joining two VPCs that share the same private subnet range 10.0.0.1/24
* Little confused by inter VPC connectivity options. Transit? Gateway?
* A lot of weird regional <abbr title="AWS Certificate Manager">ACM<abbr> questions that threw me. This is undergoing change I believe at writing to Amazon Trust Services, so the questions will be extra confusing until updated. My confusion is that I generally only use the Global Cloudfront service where the ACM's end up in us-east-1.


The 3 hour test is pretty gruelling. Not looking forward to retaking it in to
two weeks on the 2nd of April, but I need it for my employer
<https://www.corexpert.net/> who are AWS partners.
