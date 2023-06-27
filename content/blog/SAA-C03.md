---
title: AWS Learning notes
date: 2023-06-27T09:58:34+01:00
description: Learning notes for the AWS Certified Solutions Architect - Associate exam
---

# RDS Proxy

> RDS Proxy establishes and manages the necessary connection
> pools to your database so that your application creates fewer
> database connections.

https://aws.amazon.com/blogs/compute/using-amazon-rds-proxy-with-aws-lambda/

# AWS Backup

> In AWS Backup, a backup vault is a container that stores and organizes
> your backups.

https://docs.aws.amazon.com/aws-backup/latest/devguide/vaults.html

# AWS DataSync (AMS SSPS)

> AWS DataSync moves large amounts of data online between on-premises
> storage and Amazon S3, Amazon Elastic File System (Amazon Elastic File
> System) or Amazon FSx.

<a href="https://aws.amazon.com/datasync/">
<img src="https://s.natalian.org/2023-06-27/datasync.png">
</a>

> DataSync software agent connects to your Network File System (NFS) and
> Server Message Block (SMB) storage, so you don’t have to modify your
> applications

# Notes

Security Groups are on the instance level, not the subnet level.

AWS S3 Glacier instant retrieval for **rare cases**.

AWS Guard Duty offers continuous monitoring.

Backup + Restore strategy is the cheapest backup strategy. Next level is Pilot Light.

<a href="/blog/2020/AWS_Pro_exam_notes/">
<img alt="Four levels of Disaster Recovery" src="https://s.natalian.org/2020-03-05/1583386197_2560x1440.png">
</a>


<abbr title="Amazon Simple Queue Service">SQS</abbr> not guaranteed to preserve order by default. Kinesis preserves ordering.

<abbr title="Web Application Firewall">WAF</abbr> is for Layer 7, AWS Network Firewall provides <a href="https://aws.amazon.com/network-firewall/faqs/#product-faqs#network-firewall-faqs#general">"control and visibility to Layer 3-7 network traffic for your entire VPC"</a>.
