---
date: 2016-07-19 15:22:41 +0800
---

<iframe width="560" height="315" src="https://www.youtube.com/embed/Imeb-_g_CtU" frameborder="0" allowfullscreen></iframe>

# Biggest tip use `ecs-cli`

<https://github.com/aws/amazon-ecs-cli>

This helps setup the instances, setup the tasks via `docker-compose.yml` and scale it!!

[Example ecs-cli usage log](http://s.natalian.org/2016-07-21/ecs-service.txt) where I setup a cluster in Oregon for <https://github.com/kaihendry/letterly>.

# With the Amazon AMI who keeps the host machine uptodate?

	~$ ssh ec2-user@54.255.129.57

	   __|  __|  __|
		  _|  (   \__ \   Amazon ECS-Optimized Amazon Linux AMI 2016.03.e
		   ____|\___|____/

		   For documentation visit, http://aws.amazon.com/documentation/ecs
		   No packages needed for security; 3 packages available
		   Run "sudo yum update" to apply all updates.
		   [ec2-user@ip-172-30-0-233 ~]$ docker ps

Should I be using CoreOS?

# Tip: to debug look at the events log

Here I later found my ELB was in the wrong VPC with "HTTP/1.1 503 Service Unavailable: Back-end server is at capacity".

<http://s.natalian.org/2016-07-19/1468908777_2558x1404.png>

# Tip: Be careful when setting up the EC2

You need to ensure you have right EC2 Role for ECS for a start!

Follow <http://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_container_instance.html> carefully!

Or just use `ecs-cli up --capability-iam` to avoid these problem space.

# What log driver should I be using to get into Kibana?

* awslogs
* fluentd
* gelf
* journald
* json-file
* syslog

Unanswered

# What does CPU unit and memory supposed to mean?

<img src=http://s.natalian.org/2016-07-20/1468980692_2558x1404.png>

I thought one good thing about containers is that they can share all the memory of the host!

# Port mappings are kinda confusing

You map ELB front end ports to the instance ports effectively.

# (service service-name) (instance instance-id) is unhealthy in (elb elb-name) due to (reason Instance has failed at least the UnhealthyThreshold number of health checks consecutively.)

<http://docs.aws.amazon.com/AmazonECS/latest/developerguide/troubleshooting.html#troubleshoot-service-load-balancers>

Your health check is probably pointing to port 80 when you should be checking the port of your container!

# What is the developer work flow?

<https://github.com/aws/amazon-ecs-cli/issues/136> suggests `ecs-cli compose service up`

I realise one could run **Service Update** to deliver an update. However after
pushing changes back to Github, how does a developer deploy to the service
themselves?

# Setting environment up

Sharing environment values between clusters seems pretty hard:

<https://github.com/aws/amazon-ecs-agent/issues/347>

My question RE more env variables: <https://github.com/aws/amazon-ecs-agent/issues/456> & <https://forums.docker.com/t/exposing-image-id-and-hostname-in-the-containers-environment/18634>

# How does one actually scale?

<https://aws.amazon.com/blogs/compute/automatic-scaling-with-amazon-ecs/>

	Because scaling ECS services is much faster than scaling an ECS cluster (of
	EC2 instances), we recommend keeping the ECS cluster scaling alarm more
	responsive than the ECS service alarm.

NOTICE **CPUReservation** and **CPUUtilization** alarms.

<img src=https://s3.amazonaws.com/chrisb/Alarms.png alt="ECS scaling alarms">

NOTICE [EC2 autoscaling](https://us-west-2.console.aws.amazon.com/ec2/autoscaling/home?region=us-west-2#AutoScalingGroups:) & [Service autoscaling](http://s.natalian.org/2016-07-21/1469084154_2558x1404.png) ARE NOT THE SAME!!

<img src=http://s.natalian.org/2016-07-21/1469084164_2558x1404.png alt="ECS alarm">

# What are my Resources? What is my memory limit?

<img src=http://s.natalian.org/2016-07-22/1469173592_2558x1404.png>
