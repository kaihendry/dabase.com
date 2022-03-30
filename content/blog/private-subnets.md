---
title: Do not complicate Serverless architectures with Private subnets
date: 2022-03-29T09:23:55+08:00
description: Security in the cloud is identity-centric not network-based
---

Architectures with Private subnets are a relic of on-premises [Three tier
architecture](https://docs.aws.amazon.com/whitepapers/latest/serverless-multi-tier-architectures-api-gateway-lambda/three-tier-architecture-overview.html).

<img src="https://s.natalian.org/2022-03-29/three-tier-data.png">

The assumption with this legacy (non-Cloud) architecture and specifically its
data layer, is that data required network isolation in a private subnet. Why?
Because **historically SQL databases have simple clear text communication
protocols**.

To meet security shortcomings in the data layer with legacy SQL server
protocols, databases are deployed in private non-Internet
addressable network zones, to limit data breach risks.

# Enter serverless

Serverless isn't only about thinking about "servers" less, it's also about
**thinking about your data layer less**.

[DynamoDB](https://aws.amazon.com/blogs/aws/happy-birthday-dynamodb) and Amazon
S3 - Cloud Object Storage are both disruptive and now mature managed data layer
solutions that are importantly **publicly addressable** on the Internet. Cloud
data layers have the security design and controls to **not require network
isolation**!

Sidenote: AWS RDS / Elasticache / Elasticsearch are not fully managed IAM
integrated services, therefore not considered serverless or Cloud native.

Yes, you can design a "private" Architecture with serverless technologies, which have an:

1. Public facing load balancer - <abbr title="Application Load Balancer">ALB</abbr>
2. Lambda(s) in private subnets
3. S3/DynamoDB connected via a "VPC endpoint"

This private design offers little benefit in exchange for a lot of complexity
and cost to your Infrastructure.

Lets play devil's advocate.

# Arguments to why you need a Private subnet in your serverless Architecture

## Reduce data costs

In a private subnet when you communicate with S3/DynamoDB you don't incur
bandwidth costs, if you're onboarded with a S3/Dynamodb gateway setup (not
easy). If your app needs to communicate on the Internet, you would also need to
setup a NAT gateway and that incurs another set of costs.

Furthermore if you communicate across private subnets you can incur costs. So
this argument is a pretty poor benefit for the complexity of Private
architecture.

## Architect for a DNS firewall

To add a DNS firewall, you need a [private hosted
zone.](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resolver-dns-firewall.html)

## No need to access the public internet

When your application doesn't need access to the Internet, you might argue it
should be in a private subnet. However it's far easier to provision a lambda
without any (API gateway) input events and not worry about lower level network
boundaries.

Lambdas in a private subnet would need to be explicitly onboarded for every
service, which impedes innovation.

There is no real benefit to provision even a lambda that "doesn't use the
Internet" on a private subnet. AWS identity controls are capable!

## Latency

A private subnet with VPC endpoints should be lower latency, though might be
only relevant when downloading / uploading large files.

## Compliance / Audit

<abbr title="System and Organization Controls">SOC</abbr> 2 and <abbr
title="Payment Card Industry">PCI</abbr> <abbr title="Data Security
Standard">DSS</abbr> might require network isolation, depending on your
interpretation.

## Private links

If you require to communicate with other AWS accounts without exposing data to
the Internet, it makes sense to setup a [PrivateLink](https://aws.amazon.com/privatelink).

The performance benefit is moot, as **VPC peering is faster and cheaper**.

AWS mandate secure TLS protocols for communicating between accounts. Private
Links often result in opaque URLs like
https://eu2r4q0h43.execute-api.ap-southeast-1.amazonaws.com/stg/store because
having **named URL hostnames becomes much harder in a private subnet** and
complex routing rules.

AWS **identity based security protocols like AWSv4 signing and API resource
policies**, should be used instead of network based Private Links.

Ultimately don't forget that most likely the other account will be using AWS
Dynamodb and S3 which runs on a public subnet. Was the Private Link worth it?

## Reduce attack surface area

The surface area to address and attack the application as well as the data
layer should be the same in both public (assuming API gateway /
lambda / S3 or DynamoDB) / private designs.

## One off cost to setting up Private subnets

Some will argue that setting up the private subnets is a one off cost and
would be captured as "Instructure as Code", like [CDK](https://bobbyhadz.com/blog/aws-cdk-vpc-example).

In many more cases complex VPCs are setup with
[Clickops](https://www.lastweekinaws.com/blog/clickops/) making it very
difficult to reproduce in a new account.

There is no such thing as a one off cost of complexity. Every lambda needs
private subnets defined and its very easy to make mistakes!

## Security in depth

> Private architectures can be viewed as a layer of protection that's well
> understood, widely adopted in practice, and almost completely manageable with
> automation.

[Reddit: Does your Serverless Architecture need Private Subnets?](https://www.reddit.com/r/aws/comments/tqtl1m/does_your_serverless_architecture_need_private/i2jau6g/)

Unfortunately this is not true in practice. Issues arise from complex network
routing. And the benefits are neglibile if you have conducted a threat model.

# Why stop using a Private subnet?

Using a managed data layer like AWS S3/DynamoDB, means **your data already
exists in a public subnet**.

A cloud service connected on the Internet doesn't mean it will communicate on
the Internet. Major fault situations aside, connectivity between services in
public subnets never use the public Internet.

Why create a complex public-private-public Architecture when a **simpler one can
suffice**?

# Conclusion

Unless you need DNS firewall, in some legacy compliance environment or don't
trust the public Internet for communicating between accounts, you probably **do
not need a Private subnet architecture**.

**Cloud native security is based on identity controls** <abbr title="Identity and
Access Management">IAM</abbr>, not "network zones" like the past.

The complexity of **supporting a Private architecture will hurt your
Availability / reliability** as the Confidentiality, Integrity and Availability
Triad will attest!
