---
title: "My First SAP"
date: 2020-03-11T09:28:32+08:00
draft: true
---

A [post on SAP on HN](https://news.ycombinator.com/item?id=22244750) I found
to be a great introduction.

The next stumbling block is the sheer amount of different
[products](https://www.sap.com/sea/products.html) <a
href="https://en.wikipedia.org/wiki/SAP_SE">SAP</a> have. Some
[SaaS](https://en.wikipedia.org/wiki/Software_as_a_service), and some
[on-premises](https://en.wikipedia.org/wiki/On-premises_software). Since I've
joined a partner, I'm focusing on the **on-premises solutions**, i.e. the
software we're allowed to run ourselves.

For <abbr title="Enterprise Resource Planning">ERP</abbr> solutions there are at least:

* S/4 HANA featuring their infamous [in-memory](https://en.wikipedia.org/wiki/SAP_HANA) database **HANA** that runs on Linux
* SAP ByDesign
* SAP BusinesOne
* SAP CloudPlatform
* SAP Fiori
* SAP Ariba

I believe why there are so many, is SAP bought any fledging ERP competition.
However, SAP **push S/4 HANA**, their latest evolution of ERP. This is a
problem for many existing clients since the upgrade path to **HANA** is usually
**expensive**.

To make matters a little confusing SAP are pushing their **SAP Cloud
Platform**. So SAP markets public cloud deployment as **SAP Hyperscale
environments**. They also **mandate specific regions** because their own
complementing SaaS solution are only in specific regions. So they might only
**certify** workloads only in **specific AWS regions** to **ensure low
latency** experiences, back to their own integrated SaaS applications.

## Database is everything

Business logic and configuration, as well as data, is all kept in the HANA database.

## Certified

On the topic of "certified", only certain [AWS instance
types](https://aws.amazon.com/sap/instance-types/) can be used.

## Deployments and networking

* SAProuter - so you can "ssh in"
* SAP Web dispatch - their load balancer
* SAP Transports so you can do RPC calls between environement

In the AWS context, deployments are usually are in a private VPC. Requiring a
VPN (IPsec) for access.

Production and a Non-production should probably split out by AWS account. They
could be connected by **AWS VPC sharing** a permissions construct, or **VPC
peering** a networking construct.

AWS Transit Gateway, a more flexible hub and spoke model could be used. But that instance and connection has associated **costs** over just the data transfer of **VPC peering**.

To improve connectivity latency for clients, AWS offers an Accelerated VPN product. As well as a interesting Global accelerator, which basically sets up a single IP for the fat client, the SAP GUI to be configured with.

For the age old "production data in staging" environment for debugging problem, SAP does offer a "System refresh" way of getting data. But to mask / redact sensitive production data, tools like <abbr title="SAP Test Data Migration Server">TDMS</abbr> and other third party tools like **Qlik Gold**.





