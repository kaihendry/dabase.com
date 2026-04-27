---
title: "AWS SAA-C03 Re-certification Journey"
description: "Documenting my experience re-certifying for the AWS Solutions Architect Associate (SAA-C03) exam — study resources, lessons learned, and tips."
date: 2026-04-27T13:59:47+01:00
---

https://tutorialsdojo.com/aws-cheat-sheets/


Frequently accessed
- S3 Standard — General-purpose, high durability/availability, low latency. Default class.
- S3 Express One Zone — Single-AZ, highest performance (10x faster than Standard), for latency-sensitive workloads.

Auto-optimizing
- S3 Intelligent-Tiering — Automatically moves objects between access tiers (Frequent, Infrequent, Archive, Deep Archive) based on usage
patterns. No retrieval fees.

Infrequently accessed
- S3 Standard-IA (Infrequent Access) — Multi-AZ, lower storage cost, per-retrieval fee. Min 30-day storage.
- S3 One Zone-IA — Single-AZ variant of Standard-IA, ~20% cheaper. Min 30-day storage.

Archival (Glacier)
- S3 Glacier Instant Retrieval — Millisecond retrieval, quarterly access pattern. Min 90-day storage.
- S3 Glacier Flexible Retrieval — Minutes-to-hours retrieval (Expedited/Standard/Bulk). Min 90-day storage.
- S3 Glacier Deep Archive — Cheapest tier, 12–48 hour retrieval. Min 180-day storage.

Other
- S3 on Outposts — Object storage on AWS Outposts hardware (on-premises).

# Route 53

- Simple — Single resource handles all traffic. No health checks. Can return multiple IPs (client picks randomly).
- Weighted — Split traffic across multiple resources by percentage, e.g. 90/10 for blue/green or A/B testing.
- Geolocation — Route based on where the user is (continent, country, or US state). Good for content localisation and data residency.
- Latency — Route to the AWS Region with the lowest network latency for the user. Best for multi-region performance.
- Failover — Active/passive setup: primary gets all traffic; Route 53 switches to secondary only if health check fails.
- Multivalue answer — Returns up to 8 healthy records at random. Client-side load balancing — more resilient than Simple but not a substitute
for a real load balancer.
- IP-based — Route based on the client's IP CIDR range. Useful when you know your users' IP blocks (e.g. ISPs, corporate offices).
- Geoproximity — Route based on the location of your resources (not just users), with an optional bias to shift traffic boundaries between
regions. Requires Traffic Flow.

Key distinctions:
- Geolocation = where the user is; Geoproximity = where your resource is (with tunable bias)
- Latency = measured AWS network latency, not geography
- IP-based = you supply the CIDR→endpoint mapping explicitly

# AWS Security products

Identity & Access Management

- IAM — Fine-grained access control for AWS resources via users, roles, and policies.
- IAM Identity Center — Centralised SSO for workforce access across multiple AWS accounts and apps. Recommended over per-account IAM users.
- Amazon Cognito — Auth for web/mobile apps (user pools = login; identity pools = AWS credentials).
- AWS STS — Issues temporary, limited-privilege credentials for assumed roles.
- AWS RAM — Securely share resources (subnets, Transit Gateways, etc.) across accounts/org.

---
Data Protection

- AWS KMS — Create, manage, and control encryption keys. Integrates with almost every AWS service.
- AWS CloudHSM — Dedicated hardware security modules — you control the keys, AWS has no access. Use when FIPS 140-2 Level 3 is required.
- AWS Certificate Manager (ACM) — Provision, manage, and auto-renew SSL/TLS certificates for AWS services.
- AWS Private CA — Build your own internal certificate authority hierarchy for private PKI.
- AWS Secrets Manager — Store, rotate, and retrieve secrets (DB passwords, API keys). Auto-rotation built in.
- Amazon Macie — Uses ML to discover and classify sensitive data (PII, credentials) in S3.

---
Network & Application Protection

- AWS WAF — Web application firewall; blocks OWASP top-10 attacks (SQLi, XSS) on CloudFront, ALB, API Gateway, AppSync.
- AWS Shield Standard — Free, always-on DDoS protection at L3/L4 for all AWS customers.
- AWS Shield Advanced — Paid; adds L7 DDoS protection, real-time visibility, cost protection, and 24/7 DRT (DDoS Response Team) access.
- AWS Network Firewall — Stateful, managed VPC-level firewall with IDS/IPS. Sits inside your VPC.
- AWS Firewall Manager — Centrally manage WAF rules, Shield Advanced, and Network Firewall policies across an entire AWS Organization.

---
Detection & Response

- Amazon GuardDuty — Intelligent threat detection; continuously analyses CloudTrail, VPC Flow Logs, DNS logs, and runtime activity for
malicious behaviour. No agents needed.
- Amazon Inspector — Automated vulnerability scanning for EC2, Lambda, and container images. Produces CVE findings.
- Amazon Detective — Forensic investigation tool; takes GuardDuty/Security Hub findings and lets you drill into the graph of who did what,
when, from where.
- AWS Security Hub — Aggregates findings from GuardDuty, Inspector, Macie, etc. into a single pane. Also runs CIS/AWS Foundational Security
Best Practices checks (CSPM).
- Amazon Security Lake — Centralises security logs from AWS + third-party sources into an S3-backed data lake using OCSF schema. Feed into
SIEMs.
- AWS CloudTrail — Audit log of every API call in your account. The foundation of all other detection services.
- AWS Config — Tracks resource configuration changes over time; lets you enforce compliance rules (e.g. "S3 buckets must not be public").
- AWS Security Incident Response — Managed service to help prepare for, respond to, and recover from security incidents.

---
Governance & Compliance

- AWS Audit Manager — Continuously collects evidence to map to compliance frameworks (PCI, HIPAA, SOC2).
- AWS Artifact — Self-service portal to download AWS compliance reports (SOC, ISO, PCI DSS) and sign BAAs.
- AWS Control Tower — Landing zone service; sets up a multi-account environment with guardrails (SCPs + Config rules) out of the box.
- AWS Organizations — Account management and grouping. Enables SCPs (Service Control Policies) to set maximum permissions across accounts.

---
Key distinctions to remember

- GuardDuty detects threats in real time; Detective investigates them after the fact; Inspector finds vulnerabilities before exploitation.
- Shield = DDoS; WAF = application-layer attack filtering; Network Firewall = VPC-level stateful firewall.
- KMS = AWS-managed key infrastructure; CloudHSM = you own the HSM, no AWS access to keys.
- Secrets Manager rotates secrets automatically; SSM Parameter Store is cheaper but no auto-rotation.
- CloudTrail = who did what (API audit); Config = what changed on which resource (configuration drift).

# AWS Migration & Backup — SAA-C03 Cheat Sheet

Server / Application Migration

- AWS MGN (Application Migration Service) — Lift-and-shift whole servers to EC2 via a replication agent. Use for "rehost" / "move servers to
AWS" scenarios. One-way: source is decommissioned after cutover.
- AWS Elastic Disaster Recovery (DRS) — Same agent as MGN but for ongoing DR. Source stays live on-prem; failover to AWS when needed. RPO/RTO
in minutes. "DR", "failover to AWS".

▎ MGN = migrate and decommission. DRS = keep source live, failover on demand.

---
Database Migration

- AWS DMS — Migrates databases with live replication (CDC) so the source stays up during cutover. Handles same-engine and cross-engine
(Oracle→Aurora, etc.).
- DMS Schema Conversion (SCT) — Converts schema and stored procedures when switching DB engines. Run this before DMS for heterogeneous
migrations.

---
Data Transfer — Online

- AWS DataSync — Fast scheduled transfer of files/objects from on-prem (NFS, SMB) or between AWS storage services (S3, EFS, FSx). Needs an
agent on-prem. "Migrate file shares", "sync NFS to S3".
- AWS Transfer Family — Managed SFTP/FTPS/FTP endpoint that lands files directly in S3 or EFS. "Partners upload via SFTP", "FTP into S3".
- AWS Storage Gateway — Hybrid bridge for on-prem apps that still need local access. Three modes: File (NFS/SMB→S3), Volume (iSCSI→EBS
snapshots), Tape (VTL→Glacier). "On-prem apps must keep running", "replace tape library".

---
Data Transfer — Offline

- Snowcone — ~8 TB, smallest/ruggedized, edge locations.
- Snowball Edge — ~80 TB, standard bulk transfer device, also runs edge compute. "TBs to PBs over a slow link".
- Snowmobile — Up to 100 PB per truck. Use when >10 PB.

▎ Rule of thumb: if the transfer would take more than ~1 week over your internet connection, use Snowball.

---
Backup

- AWS Backup — Centralised policy-driven backup across RDS, EBS, EFS, DynamoDB, S3, FSx, EC2, and more. Handles cross-region and
cross-account copies, retention policies, and audit reports. "Centralised backup", "compliance", "backup across multiple services".

---
Quick decision guide

- Whole servers → EC2: MGN
- Ongoing on-prem DR: DRS
- Live database migration: DMS (add SCT if switching engines)
- File shares to S3/EFS: DataSync
- SFTP partner uploads: Transfer Family
- On-prem apps need local storage interface: Storage Gateway
- Too much data for the network: Snowball Edge
- Centralised backup policy: AWS Backup

Amazon DLM (Data Lifecycle Manager) — automates the creation, retention, and deletion of EBS snapshots and EBS-backed AMIs. You define
  lifecycle policies (e.g. "snapshot every 12 hours, keep 7 days") and DLM executes them on a schedule. It can also copy snapshots cross-region
   for DR.

  DLM vs AWS Backup for EBS:
  - Both can snapshot EBS volumes
  - DLM is EBS/AMI-specific, simpler, no extra cost beyond snapshot storage
  - AWS Backup covers EBS plus many other services (RDS, EFS, DynamoDB etc.) under one policy — use it when you need a unified backup policy
  across multiple service types
  - For the exam: if the scenario is purely EBS snapshots on a schedule → DLM is the focused answer; if it's "centralised backup across
  services" → AWS Backup

# S3 speed

S3 Transfer Acceleration — speeds up uploads/downloads to a specific S3 bucket. When enabled, you use a special endpoint
(bucket.s3-accelerate.amazonaws.com) and your data enters the AWS backbone at the nearest CloudFront edge location rather than travelling the
public internet all the way to the bucket's region. S3-only. Charged per GB transferred.

Keyword: "users uploading large files to S3 from around the world", "slow S3 uploads from distant regions".

---
AWS Global Accelerator — speeds up traffic to any application (EC2, ALB, NLB, Elastic IPs) across regions. Gives you two static anycast IP
addresses that route users to the nearest AWS edge, then onto the AWS backbone to your endpoint. Also does health checking and automatic
failover between regions. Not storage-specific.

Keyword: "global users hitting an application with low latency", "static IPs for a global app", "multi-region failover", "gaming / VoIP /
non-HTTP workloads".

---
Key distinctions for the exam:

- S3 Transfer Acceleration = S3 uploads/downloads only, uses CloudFront edge network
- Global Accelerator = any application, uses anycast IPs + AWS backbone, adds failover
- Both route traffic via the AWS global network to avoid the public internet
- If the scenario mentions S3 and far-away users uploading files → Transfer Acceleration
- If the scenario mentions static IPs, multi-region failover, or non-HTTP protocols → Global Accelerator
- CloudFront vs Global Accelerator: CloudFront caches content at the edge; Global Accelerator just routes faster with no caching
