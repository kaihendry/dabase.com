---
date: 2014-08-25 15:44:18 +0800
---

<abbr title="Amazon Web Services">AWS</abbr> Singapore kindly gifted
<http://hackerspace.sg/> with 500SGD of AWS credits.

Since the mirrors <http://mirror.nus.edu.sg/> and <http://download.nus.edu.sg>,
which are two separate competing groups from the <abbr title="National University of
Singapore">NUS</abbr> which oddly try to outdo each other in incompetence, have
had [several issues mirroring
Archlinux](https://www.archlinux.org/mirrors/status/) in my two year experience
of using either of them, I thought lets use these credits to host an [Archlinux
mirror](https://wiki.archlinux.org/index.php/Mirroring)!!

After much head scratching with the AWS jargon of {ebs,s3} and
{hvm,paravirtual} [EC2 Archlinux
images](https://www.uplinklabs.net/projects/arch-linux-on-ec2/), I launched an
"ebs hvm" instance of **m3.xlarge**.

I got a nice 80GB zpool going for the mirror and everything was looking good.
However, now to do the budgeting.

[**On demand** pricing is $0.392 an hour](http://s.natalian.org/2014-08-25/1408951785_1364x748.png)

There is roughly 9000 hours in a year. So that's $3528. Eeeek, over budget by just 3000 dollars!

<strike>Ignoring added complexity of Spot and EBS enhancements, a [one year **resevered instance**](http://s.natalian.org/2014-08-25/1408951951_1364x748.png) under "Light Utilization Reserved Instances" (I am not sure what that means) is 497 dollars! Yes!!</strike>

I'm told "Light utilization means that you will not turn it on all the time".
For 1 year I would need **heavy utilization**!

So a m3.xlarge would be: 981 (down payment)  + 24 \* 365 \* 0.124 = **$2067.24**,
about 1500 dollars over budget.

# Oh and bandwidth?

Well, a mirror is going to be a network whore. AWS charges for bandwidth. I
tried their calculator (since I couldn't figure out what they charge per GB)
with a lowball [1TB a month in and out and that costs almost
200USD](http://s.natalian.org/2014-08-25/1408952194_1364x748.png).

Wow that's expensive! AWS EC2 (+ 500SGD credit) isn't suitable for an Archlinux mirror! :(

# Digital Ocean quote

For a machine with at least 50GB of disk, you would need [Digital Ocean's
60GB offering](http://s.natalian.org/2014-08-25/1408952409_1364x748.png), with

* 4GB / 2 CPUS
* 60GB SSD DISK
* 4TB TRANSFER

So that is **40USD a MONTH** or 480USD a year. A lot cheaper than EC2, and bandwidth clearly priced at 2c per GB, so 1TB = 20USD IIUC.

# Lessons learnt

Running a mirror is quite expensive on EC2. It's not really feasible on <abbr title='Digital Ocean'>DO</abbr> either without some free unmetered traffic.
