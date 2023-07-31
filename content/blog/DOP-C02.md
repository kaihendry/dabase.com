---
title: AWS Certified DevOps Engineer Pro Preparation
date: 2023-06-28T09:46:03+01:00
description: Studying for AWS Certified DevOps Engineer - Professional
---

Three years have passed since certifying the rather painful
[SAP-C01](https://dabase.com/blog/2020/AWS_Pro_exam_notes/) on my _second try_.
My certification has since expired and I thought lets challenge myself to <abbr
title="Certified DevOps Engineer - Professional">DOP-C02</abbr>.

* [X] Block time in Calendar
* [X] Buy the exam slot
* [X] Arrange learning resource (videos)
* [X] Practice Exam

I've given myself a solid week to prepare since I'm not assigned to a client
project. Confident by the fact I re-certified
[SAA-C03](https://www.credly.com/users/khendry/badges) & obtained a 50% exam discount last week and with my [SAA-C03 learning notes](/blog/2023/SAA-C03/) that helped me pass
first time.

Furthermore:

> Get a FREE exam retake (if you need it) when you book your AWS Certification
> exam through Pearson VUE through July 15, 2023.

Lets checkout what [Reddit has to say](https://www.reddit.com/r/AWSCertifications/search?q=DOP-C02&restrict_sr=on).

* READ THE QUESTION Cost effective/low overhead/operational efficiency parameters will shape the answer.
* KNOW THE CODE* suite
* When in doubt, the answer is either Config or EventBridge

Bought the 96USD [@adriancantrill](https://twitter.com/adriancantrill) **learning resource** https://learn.cantrill.io/, since it came recommended on Reddit:

<img src="https://s.natalian.org/2023-06-28/cantrill.png">

And of course I bought <abbr title="Tutorial Dojo">TD</abbr> Jon-Bonso's **Practice Exams**:
<img src="https://s.natalian.org/2023-06-28/bonso.png">

I also have access to https://learn.acloud.guru/search?query=DOP-C02&page=1 which I will use too.

# Learning process

I like <abbr title="Tutorial Dojo">TD</abbr>'s **Review mode** and taking
notes for incorrect answers. I  dip into [Cantrill's
course](https://learn.cantrill.io/courses/enrolled/1101198) as and when I feel
like being a bit more passive / absorbant. I typically time box about 4 hours a
day to revision.

I take notes on paper and then write them up on my blog to re-enforce the
learning / memorisation. I've scheduled this exam for a morning 8AM slot when
my brain is the freshest, after a good nights sleep.

# Exam day 2023-07-05

I failed, with candidate score of 735, annoyingly I needed 15 points more to reach the passing score of 750! 

This is like my [SAP-C01 experience](/blog/2020/failed-the-SAP-C01/). 💩

Now I want to take the exam ASAP, but I am struggling to book with the AWSRETAKE code. 

{{< tweet user="kaihendry" id="1678368014314397696" >}}

Some areas which I need to improve on:

* AWS S3 replication - need to try this out
* Cloudformation templates / stacksets
* Running through a scenario like how to check for untagged resources across regions/accounts
* Rolling update ASG examples
* When and where to use Cloudwatch alarms vs Eventbridge
* How logging works on the ALB, is it done with the target groups?
* [ForAllValues policy condition](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_multi-value-conditions.html)
* [AWS EC2 warm pools](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-warm-pools.html)
* How failure works in an ASG
* Run through scenario of settings up operations Admins across an organisation's accounts

# Exam day 2023-07-28

Sadly I wasn't able to use the AWSRETAKE code!

> As we can see you scheduled the first exam which was partially paid for with a discount coupon and credit card. As per policy, no other scheme can be combined with this scheme. but you used a discount code, hence free retake scheme is not applicable to you.


Nonetheless I booked a retake with an older 50% discount and this time I passed! 🎉

<img src="https://s.natalian.org/2023-07-31/passed.jpeg" alt="782 score">