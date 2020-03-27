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
* A lot of weird regional <abbr title="AWS Certificate Manager">ACM</abbr> questions that threw me. This is undergoing change I believe at writing to Amazon Trust Services, so the questions will be extra confusing until updated. My confusion is that I generally only use the Global Cloudfront service where the ACM's end up in us-east-1.


The 3 hour test is pretty gruelling. Not looking forward to retaking it in to
two weeks on the 2nd of April, but I need it for my employer
<https://www.corexpert.net/> who are AWS partners.

## VIRTUAL PRIVATE NETWORK (VPN)

### Customer Gateways

An Amazon VPC VPN connection links your data center (or network) to your Amazon Virtual Private Cloud (VPC). A **customer gateway** device is the anchor on your side of that connection. It can be a physical or software appliance.

### Virtual Private Gateways

The anchor on the AWS side of the VPN connection is called a **virtual private** gateway. Associate this with your VPC.

### Site-to-Site VPN Connections

<img src="https://s.natalian.org/2020-03-27/site-to-site.png">

This is typically for on-premise network to an AWS VPC as redundancy to a Direct Connect.

If you want a connection between VPCs, say across regions, you want a [Peering
Connections](https://ap-southeast-1.console.aws.amazon.com/vpc/home?region=ap-southeast-1#PeeringConnections:sort=vpcPeeringConnectionId)
instead. However if your region supports [AWS Transit Gateway with Inter-Regional Peering](https://aws.amazon.com/blogs/aws/aws-transit-gateway-adds-multicast-and-inter-regional-peering/), you want to use this for added flexibility. Track availability on the [FAQ](https://aws.amazon.com/transit-gateway/faqs/).

### Client VPN Endpoints

This links **customer gateway** and **virtual private**. At time of writing mutual authentication via Public Key cryptography seems like the defacto way of doing it: <https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/cvpn-getting-started.html>

The connection is done via Openvpn configuration called
`downloaded-client-config.ovpn` which you need to [painfully
edit](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/cvpn-getting-started.html#cvpn-getting-started-config)
in an ID to the connection address and the keys generated via [Mutual
Authentication](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/authentication-authorization.html#mutual)
process aka public/private keys instead of shared secret.
