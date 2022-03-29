---
title: Why Private Subnets?
date: 2022-03-29T09:23:55+08:00
description: There is little need for complex network topologies anymore
---

Architectures with Private subnets are a relic of [Three tier
architecture](https://docs.aws.amazon.com/whitepapers/latest/serverless-multi-tier-architectures-api-gateway-lambda/three-tier-architecture-overview.html).

<img src="https://s.natalian.org/2022-03-29/three-tier-data.png">

The assumption with this architecture and specifically its data layer, is that
data required network isolation in a private subnet. Why? Because
**historically SQL databases have simple clear text communication protocols**.

In my experience Apps were never consistently in a Private or Public subnet.

To meet security shortcomings in the data layer with legacy SQL server
protocols, databases by best practice were deployed in private non-Internet
addressable network zone, to limit data breach risks.

# Enter serverless

Serverless isn't only about thinking about "servers" less, it's also about
**thinking about your data layer less**.

[DynamoDB](https://aws.amazon.com/blogs/aws/happy-birthday-dynamodb) and Amazon
S3 - Cloud Object Storage are both disruptive and now mature managed data layer
solutions that are importantly **publicly addressable** on the Internet. Cloud
data layers have the security design and controls to not require network isolation!

Yes, you can design a "private" Architecture with serverless technologies, which have an:

1. Public facing load balancer - <abbr title="Application Load Balancer">ALB</abbr>
2. Lambda in private subnet
3. S3/DynamoDB connected via a "VPC endpoint"

This private design is offers little benefit in exchange for a lot of
complexity to your Infrastructure.

Lets play devil's advocate.

# Why would you need a Private subnet in your serverless Architecture?

## Reduce data costs

In a private subnet when you communicate with S3/DynamoDB you don't incur
bandwidth costs. However now you need to setup a NAT gateway and that incurs
another set of costs.

Furthermore if you communicate across private subnets you can incur costs. So
this argument is a pretty poor benefit for the complexity of Private
architecture.

## Architect for a DNS firewall

To add a DNS firewall, you need a [private hosted
zone.](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resolver-dns-firewall.html)

## Latency

A private subnet with VPC endpoints should be lower latency, though this is not proved.

## Private links

If you require to communicate with other AWS accounts in some network
isolation, it makes sense to have your own private subnet.

Private links with private IPs and complex orchestration aside, AWS mandate
secure TLS protocols for communicating between accounts. Private Links often
result in opaque URLs like
https://eu2r4q0h43.execute-api.ap-southeast-1.amazonaws.com/stg/store because
having named URLs becomes much harder in a private subnet.

AWS protocols like AWSv4 signing and API resource policies, could be used
instead of Private Links which are difficult to maintain and setup.

Ultimately don't forget that most likely the other account will be using AWS
dynamodb and S3 which runs on a public subnet. Was the Private Link worth it?

## Reduce attack surface area

The surface area to address and attack the application as well as the data
layer should be the same in both public (assuming API gateway /
lambda / S3 or DynamoDB) / private designs.

# Why stop using a Private subnet?

Using a managed data layer like AWS S3/DynamoDB, means using **data that already exists effectively in a public subnet**.

Why create a complex public-private-public Architecture when a **simpler one can
suffice**?

# Conclusion

Unless you need DNS firewall and don't trust the public Internet for
communicating between accounts, you probably need a Private subnet
architecture.

The complexity of supporting a Private architecture will **hurt your
Availability** / reliability as the Confidentiality, Integrity and Availability
Triad will attest!
