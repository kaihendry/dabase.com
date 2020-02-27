---
title: SAP-C01 AWS Certified Solutions Architect - Professional scrap book
date: 2020-02-26T14:49:14+08:00
description: Notes whilst preparing for a certification
---

# Design for Organizational Complexity

Acronyms:

* <abbr title="Direct Connect">DX</abbr>
* <abbr title="Virtual Interfaces">VIFs</abbr>

## Sub-domain: cross-account authentication and access strategies

###  Active directory options

<img src="https://s.natalian.org/2020-02-26/ad-options.jpg">

### Gateway differences

<img src="https://s.natalian.org/2020-02-26/gateway.jpg">

## Sub-domain: Networks

### VPN connection types

<img src="https://s.natalian.org/2020-02-26/networks.jpg">

## Sub-domain: multi-account AWS environments

<img src="https://s.natalian.org/2020-02-26/multi-account-strategy.jpg">

* <a href="https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scp.html"><abbr title="Serice Control Policies">SCPs</abbr></a>

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

* Plan
	* Discover
		* Assessment and profiling
		* Data requirements and classification
		* Prioritization
		* Business logic and infrastructure dependencies
	* Design
		* Detailed migration plan
		* Estimate effort
		* Security and risk assessment
* Build
	* Transform
		* Network topology
		* Migrate
		* Deploy
		* Validate
	* Transition
		* Pilot testing
		* Transition to support
		* Release management
		* Cutover and decommission
* Run
	* Operate
		* Staff training
		* Monitoring
		* Incident management
		* Provisioning
	* Optimise
		* Monitoring-driven optimization
		* Continuous integration and continuous deployment
		* Well-Architected Framework

<img src="https://s.natalian.org/2020-02-26/storage-portfolio.jpg">

<img src="https://s.natalian.org/2020-02-26/all-three.jpg">

# Cost control

<img src="https://s.natalian.org/2020-02-26/tag-everything.jpg">

<img src="https://s.natalian.org/2020-02-26/two-tags.jpg">

Enforce tags with [AWS Config](https://www.reddit.com/r/aws/comments/f9qv97/tag_watchers/fivmppj/?context=3).
