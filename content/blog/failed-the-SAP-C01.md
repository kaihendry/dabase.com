---
title: "Failed the AWS Certified Solutions Architect professional exam"
date: 2020-03-18T09:48:37+08:00
---

Yesterday I took and failed my SAP-C01 exam. You may have noticed I scribbled
some [preparation notes earlier](https://dabase.com/blog/AWS_Pro_exam_notes/).

Candidate score was 730 and I needed 750 to pass. So I was close, but it showed
at least to me some gaps in my knowledge:

* VM Import/Export - is this the way you export VMs to AWS from an on premise data center? I thought one used [CloudEndure](https://www.cloudendure.com/)..
* Various <abbr title="Active Directory">AD</abbr> configurations or rather migration strategies. If a client has an <abbr title="Active Directory">AD</abbr> controller on premises, what is needed to move it to the AWS Cloud?
* Various Cloudformation questions. Like if you have an existing setup in one region, can you **export** the Cloudformation template and just run it with a changed region parameter?
* Even though I've used AWS ECS for years, some questions about the [task roles](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) and [awsvpc](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html) versus `bridge` confused me.
* Routing <abbr title="with respect to">wrt</abbr> joining two VPCs that share the same private subnet range 10.0.0.1/24
* Little confused by inter VPC connectivity options. Transit? Gateway?


The 3 hour test is pretty gruelling. Not looking forward to retaking it in to
two weeks, but I need it for my current employers <https://www.corexpert.net/>
who are AWS partners.
