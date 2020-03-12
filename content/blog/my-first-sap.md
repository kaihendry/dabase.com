---
title: "My First SAP"
date: 2020-03-11T09:28:32+08:00
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

Considering HANAs high memory requirements, remember:

* R,X memory optimised
* U high memory

**SAPS** is a benchmark, which correlates to interactions per user on the SAP
sales and distribution module. [Quick
sizer](https://www.sap.com/about/benchmark/sizing.html) on existing workloads
can help you map to the AWS instances via **SAPS**.

SSD disks should always be used.

## Deployments and networking

These often require a static IP, aka an AWS Elastic IP:

* SAProuter - so you can "ssh in"
* SAP Web dispatcher - their load balancer
* SAP Transports `/usr/sap/trans` so you can do RPC calls between environment

In the AWS context, deployments are usually are in a private VPC. Requiring a
VPN (IPsec) for access.

Production and a Non-production should probably split out by AWS account. They
could be connected by **AWS VPC sharing** a permissions construct, or **VPC
peering** a networking construct.

AWS Transit Gateway, a more flexible hub and spoke model could be used. But that instance and connection has associated **costs** over just the data transfer of **VPC peering**.

To improve connectivity latency for clients, AWS offers an Accelerated VPN product. As well as a interesting Global accelerator, which basically sets up a single IP for the fat client, the SAP GUI to be configured with.

For the age old "production data in staging" environment for debugging problem, SAP does offer a "System refresh" way of getting data. But to mask / redact sensitive production data, tools like <abbr title="SAP Test Data Migration Server">TDMS</abbr> and other third party tools like **Qlik Gold**.

## Monitoring

AWS Data Provider for SAP feeds data into SAP <abbr title="Computing Center Management System">CCMS</abbr>.

How SAP CCMS is the old way of SAP monitoring. Currently the SAP monitoring solutions are:
* [Solution manager](https://support.sap.com/en/alm/solution-manager/expert-portal.html)
* [SAP Hana Cockpit](https://help.sap.com/viewer/6b94445c94ae495c83a19646e7c3fd56/2.0.03/en-US/c61b097543124d5a9e631c0288c6714c.html)

However the most forward looking SAP monitoring strategy appears to be adopting
[Prometheus with
exporters](https://blogs.sap.com/2020/02/07/monitoring-sap-and-hana-instances-with-prometheus-and-grafana/).

## AWS EBS volumes

Do not use the Instance store for SAP Workloads.

They should be encrypted by default.

1. root OS
2. SAP app
3. data, aka the database
4. logs from database

Depending on performance characteristics, it could just be two volumes:

1. root OS & SAP app
2. database & logs

Or use multiple volumes in a RAID-0 striped setup for increased I/O. Or try
different volume type. Though it's actually cheaper to **allocate more space** in
**gp2 space**.

Remember you can change volume size type on the fly. You can temporarily change
the type for increased performance!

For backups use snapshot for OS + App. Use SAP tools for the data/base and
script to S3. Often via an intermediate st1 volume.

S3 is 10 9s for durability and 4 nines availability.

**sapmnt** would use EFS on Linux and FSx for Windows workloads.

## High availability

For high availability workloads, use an ELB to two workloads on different AZs.
The app could be hosted on EFS (also use <abbr title="enqueue replicate
service">ers</abbr>) and the database could be replicated with DB Log
replication. It's Active / Passive, it cannot be Active/Active due the nature
of DB replication. However it's common to use a third party solution, SLES HAE,
RHEL HA Add-on, SIOS Protection Suite.

## Disaster Recovery

* Passive DR, backup up to S3
* Pilot light would be using replication

# Quickstart

s3://saplabs-media000/hana20/sps04/

	ec2-user@imdbmaster:~> lsblk
	NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
	nvme0n1                 259:0    0   50G  0 disk
	├─nvme0n1p1             259:1    0    2M  0 part
	├─nvme0n1p2             259:2    0   20M  0 part /boot/efi
	└─nvme0n1p3             259:3    0   50G  0 part /
	nvme1n1                 259:4    0  512G  0 disk
	└─vghanaback-lvhanaback 254:0    0  511G  0 lvm  /backup
	nvme2n1                 259:5    0  300G  0 disk /hana/shared
	nvme3n1                 259:6    0  225G  0 disk
	└─vghanadata-lvhanadata 254:1    0  585G  0 lvm  /hana/data
	nvme4n1                 259:7    0  225G  0 disk
	└─vghanadata-lvhanadata 254:1    0  585G  0 lvm  /hana/data
	nvme5n1                 259:8    0  225G  0 disk
	└─vghanadata-lvhanadata 254:1    0  585G  0 lvm  /hana/data
	nvme6n1                 259:9    0  175G  0 disk
	└─vghanalog-lvhanalog   254:2    0  325G  0 lvm  /hana/log
	nvme7n1                 259:10   0  175G  0 disk
	└─vghanalog-lvhanalog   254:2    0  32G  0 lvm  /hana/log
	nvme8n1                 259:11   0   50G  0 disk /usr/sap
	nvme9n1                 259:12   0   50G  0 disk /media

# HANA offerings

1. *SAP HANA <abbr title="Bring Your Own License">BYOL</abbr> only S4 HANA compatible
2. SAP Cloud Platform SAP HANA service for custom application development
3. SAP HANA express edition for testing use case studies
4. SAP HANA Enterprise Cloud (HEC) on AWS -- one throat to choke

You can't seperate your app and database, for latency reasons.
