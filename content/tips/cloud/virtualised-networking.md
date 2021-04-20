---
title: Virtualised Networking
date: 2021-04-20T16:23:26+08:00
description: What are AWS NACL or Security groups in a on-premises data center context?
---

A proactive step for on-premises data centers is to adopt well established Cloud
concepts like <abbr title="Network Access Control List">NACLs</abbr> and
**Security groups**.

<img src="https://s.natalian.org/2020-02-28/perimeter-controls.jpg">


<abbr title="network access control list">NACLs</abbr> are stateless and
accommodate DENY rules unlike Security groups. Security groups are a simple way
of grouping services to allow them to communicate with one another.

<blockquote cite="Ian Donaldson"> NACLs are more like a traditional
network-based firewall in that they are evaluated when a subnet boundary is
traversed, but with the caveat they are stateless. There’s no real direct
datacentre equivalent. Security Groups are more like host-based firewalls in
that they act at the instance (actually ENI) level, but they are enforced by
the hypervisor. Once again, no perfect datacentre equivalent.  </blockquote>

<q>...you could say a security group is like a firewall enforced by the switch port. And a NACL is probably closest to a route table, but with port and protocol granularity.</q>

# Roadmap

There realistically only appears to be two vendor options for serving
on-premises incumbents, who can't move to the public Cloud for whatever reason:

* VMware call it a "Virtual network"
* OpenShift calls it <a href="https://docs.openshift.com/container-platform/4.6/post_installation_configuration/network-configuration.html"><abbr title="Software Defined Networking">SDN</abbr></a>, which leverages Kubernetes (k8s) under the hood
