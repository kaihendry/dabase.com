---
title: "Failed the AWS Certified Solutions Architect professional exam"
date: 2020-03-18T09:48:37+08:00
description: The professional AWS exam is one hell of an exam!
---

# UPDATE: Just passed the Pearson Vue online exam!

Read the FAQ on <https://home.pearsonvue.com/aws/onvue#additional-information>
Just copying interesting section out here since it's in a silly UI FAQ
accordion:

> During the check-in process, you will be asked to take photos of your work
> area, which will be checked by security prior to exam launch. Please ensure
> that your desktop is clean and that you are not within arm’s reach of books,
> notepads, sticky notes, papers, pens, pencils, and other writing
> instruments/objects. Additional monitors and computers must be unplugged and
> turned off, and all smart accessories and devices must be removed and turned
> off. Items on the wall with writing on them, such as whiteboards, will be
> inspected. If your workspace does not pass a room scan, you are not permitted
> to proceed with taking the exam.
> Please ensure that you are in a well-lit room for the proctor to see you and
> your workspace. Avoid exam locations with a light source behind you (such as a
> window or bright lamp). An artificial light source is recommended, as the
> availability of natural light may change over the course of your exam
> appointment. Remember that no third party may enter the room during your exam.
> If this occurs, your exam session will be terminated. This room will need to be
> a quiet space without any noise or other distractions. Exam candidates are
> ultimately responsible for ensuring the workspace meets all of the
> requirements.

Couple of things about the home examination experience:

* Email to prepare three days before
* Only works on MacOS or Windows since it takes over the computer's Desktop
* Requires a mobile phone to take pictures of your ID and surroundings
* One of the pictures was flagged for showing another human, it was actually some family pictures behind me
* After taking the pictures with your phone, I then ran out the room to put the phone away. Bit awkward.
* During the exam, the Proctor _Jobin_ started a chat with me saying that I shouldn't cover my mouth
* Wish there was sane line wrapping on the questions and perhaps ctrl+f search
* When trying to complete the exam, it said it was missing an answer from the survey section, weird.
* My result said **Pass** and I immediately left the room to tell my wife in exhilaration. That was a violation and the Proctor said he'll make an exception. I failed to click End exam in the bottom left corner (inconsistent UI from bottom right)
* Been more than an hour since I finished my exam. No confirmation of my result.
* Received a **CertMetrics** email with my results 3AM the next day
* Adding my [certificate](https://www.youracclaim.com/badges/4225b0a3-ad90-43d2-a22d-25d274da0e84/public_url) to [LinkedIn](https://www.linkedin.com/in/kaihendry/) via a Digital Badges (new) seems [even more awkward](https://s.natalian.org/2020-04-29/cert-linkedin.mp4)!

Just for the record I failed three times before passing:

1. 2018-11-28 643 FAIL
2. 2019-05-29 654 FAIL
3. 2020-03-17 730 FAIL
4. 2020-04-28 879 PASS

# Failed the AWS Certified Solutions Architect – Professional

Yesterday I took and failed the SAP-C01 exam. You may have noticed I scribbled
some [preparation notes earlier](/blog/2020/AWS_Pro_exam_notes/).

Candidate score was 730 and I needed 750 to pass. So I was close, but it showed
at least to me some gaps in my knowledge.

The 3 hour test is pretty gruelling. Not looking forward to retaking it in to
two weeks on the 2nd of April (Update: Cancelled due to COVID-19), since I need
it for my employer <https://www.corexpert.net/> who are AWS partners.

## VIRTUAL PRIVATE NETWORK (VPN)

Carrying on with my revision notes.

### Customer Gateways

An Amazon VPC VPN connection links your data center (or network) to your Amazon
Virtual Private Cloud (VPC). A **customer gateway** device is the anchor on
your side of that connection. It can be a physical or software appliance.

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

## Deployment options

<https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html>

There is a [cheatsheet](https://tutorialsdojo.com/aws-codedeploy/) but I find the AWS documentation clearer.

[All at once Elastic Beanstalk
option](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.deploy-existing-version.html#deployments-newversion)
results in down time, so avoid it to minimise disruption.

## Will I have enough capacity to scale?

You can make a [On-Demand Capacity Reservation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-capacity-reservations.html)
