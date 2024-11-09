---
title: SAP-C01 AWS Certified Solutions Architect - Professional scrap book
date: 2020-02-26T14:49:14+08:00
description: Notes whilst preparing for a certification
---

# Design for Organizational Complexity

Acronyms:

- <abbr title="Direct Connect">DX</abbr>
- <abbr title="Virtual Interfaces">VIFs</abbr>

## Sub-domain: cross-account authentication and access strategies

### Active directory options

<img src="https://s.natalian.org/2020-02-26/ad-options.jpg">

### Gateway differences

<img src="https://s.natalian.org/2020-02-26/gateway.jpg">

## Sub-domain: Networks

### VPN connection types

<img src="https://s.natalian.org/2020-02-26/networks.jpg">

## Sub-domain: multi-account AWS environments

<img src="https://s.natalian.org/2020-02-26/multi-account-strategy.jpg">

- <a href="https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scp.html"><abbr title="Serice Control Policies">SCPs</abbr></a>

<img src="https://s.natalian.org/2020-02-26/root-account-no-cloudtrail.jpg">

# New solutions

## Sub-domain: security requirements and controls

<img src="https://s.natalian.org/2020-02-26/kinesis-order.jpg">

<img src="https://s.natalian.org/2020-02-26/kinesis-types.jpg">

<img src="https://s.natalian.org/2020-02-26/read-replicas.jpg">

<img src="https://s.natalian.org/2020-02-26/elastiCache.jpg">

<img src="https://s.natalian.org/2020-02-26/dynamodb-global-tables.jpg">

<abbr title="Amazon Simple Workflow Service">SWF</abbr> takes an awful lot of code to make it work well.

<img src="https://s.natalian.org/2020-02-26/iam-access-controls.jpg">

<img src="https://s.natalian.org/2020-02-26/seperate-security-account.jpg">

<img src="https://s.natalian.org/2020-02-26/user-vs-identity-pools.png">

## Sub-domain: deployment strategies for business requirements

<img src="https://s.natalian.org/2020-02-26/deployment-mechanisms.jpg">

# Migration planning

- Plan
  - Discover
    - Assessment and profiling
    - Data requirements and classification
    - Prioritization
    - Business logic and infrastructure dependencies
  - Design
    - Detailed migration plan
    - Estimate effort
    - Security and risk assessment
- Build
  - Transform
    - Network topology
    - Migrate
    - Deploy
    - Validate
  - Transition
    - Pilot testing
    - Transition to support
    - Release management
    - Cutover and decommission
- Run
  - Operate
    - Staff training
    - Monitoring
    - Incident management
    - Provisioning
  - Optimise
    - Monitoring-driven optimization
    - Continuous integration and continuous deployment
    - Well-Architected Framework

<img src="https://s.natalian.org/2020-02-26/storage-portfolio.jpg">

<img src="https://s.natalian.org/2020-02-26/all-three.jpg">

# Cost control

<img src="https://s.natalian.org/2020-02-26/tag-everything.jpg">

<img src="https://s.natalian.org/2020-02-26/two-tags.jpg">

Enforce tags with [AWS Config](https://www.reddit.com/r/aws/comments/f9qv97/tag_watchers/fivmppj/?context=3).

- Termination protection does not work for Auto scaling groups
- Instance protection does work

# Improving Architectures

## Sub-domain: troubleshooting solution architectures

<img src="https://s.natalian.org/2020-02-28/trouble-shooting.jpg">

<img width=1280 height=720 src="https://s.natalian.org/2020-02-28/1582860243_2560x1440.png" alt="CW Events != Alarms">

## Sub-domain: operational excellence

- Two way doors (reversible changes) as opposed to more risky one way doors
- Implement [CloudFormation](https://www.reddit.com/r/aws/comments/f74b61/after_being_in_the_consultant_biz_for_3_years/fi92oal/) aka <abbr title="Infrastructure as Code">IaC</abbr>

## Sub-domain: improve reliability

<img src="https://s.natalian.org/2020-02-28/operational.png" alt="The operational continium">

- [Instance auto recovery](https://aws.amazon.com/about-aws/whats-new/2018/05/amazon-ec2-auto-recovery-is-now-available-for-dedicated-instances/)
- Use Multi-AZ services: S3/DynamoDB automatically Multi-AZ
- AWS EBS Snapshots minimize Recovery Point Objective
- Use RI for critical systems
- <a href="https://darkbit.io/blog/2020/02/18/simple-dlp-for-amazon-s3"><abbr title="Data Loss Prevention">DLP</abbr> with CloudTrail</a>

<img src="https://s.natalian.org/2020-02-28/snapshots.jpg">

## Sub-domain: improving performance

<img src="https://s.natalian.org/2020-02-28/ebs-performance.jpg">

<img src="https://s.natalian.org/2020-02-28/redis-performance.jpg">

- Memcached is single AZ
- Redis [Lazy loading versus Write through](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Strategies.html)

## Sub-domain: improving security

<img src="https://s.natalian.org/2020-02-28/restrict-access.jpg">

<img src="https://s.natalian.org/2020-02-28/encryption-options.jpg">

<img src="https://s.natalian.org/2020-02-28/perimeter-controls.jpg">

- <abbr title="Network Access Control Layer">NACLs</abbr> are stateless and accomodate **DENY** rules unlike Security groups

## Sub-domain: improving deployment

- Cloud Formation - consider Deletion policy attribute, be wary of downtime. **Retain** for S3, **Snapshot** (default) for RDS/EBS etc
- Code deploy - Must remove underlying instances
- Elastic Beanstalk - can do it all
- OpsWorks - Chef can handle minimal downtime
- AWS ECS

<img src="https://s.natalian.org/2020-02-28/additional-resources.jpg">

{{< tweet user="kaihendry" id="1233291346154098688" >}}

[Active-Active versus Active-Passive Failover](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-types.html)

<img width=1280 height=720 src="https://s.natalian.org/2020-03-05/1583386029_2560x1440.png" alt="RPO versus RTO">

<img width=1280 height=720 src="https://s.natalian.org/2020-03-05/1583386197_2560x1440.png" alt="Backup/Restore, Pilot light, Warm standby, to Hot standby">

# The common cloud data migration challenge

<blockquote cite="https://aws.amazon.com/cloud-data-migration/">
Number of days = (Total Bytes)/(Megabits per second * 125 * 1000 * Network Utilization * 60 seconds * 60 minutes * 24 hours)
</blockquote>
