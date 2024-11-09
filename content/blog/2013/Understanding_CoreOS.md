---
date: 2013-11-02 14:17:34 +0800
---

[CoreOS](http://coreos.com/) has come up on my radar a couple of times and I
decided to see what all the fuss about especially when they were soliciting
companies to pilot their software for 5000USD!

<img src=http://s.natalian.org/2013-11-02/1383370072_1366x768.png>

All credit to them for managing that.

# What's the attraction of running CoreOS over say Archlinux?

1. Automatic updates keep the base OS of CoreOS secure <http://coreos.com/using-coreos/updates/>
2. It runs Docker and Etcd

Ok, automatic updates are easy to understand. Right now I periodically run
`pacman -Syu` across the [servers](http://webconverger.org/servers/) I manage.
I update my laptop before my servers and obviously keep a close eye on
<https://www.archlinux.org/news/>. It's not absolutely bleeding edge since I
don't use `[testing]`. For the last years my Archlinux servers have been
wonderfully stable and productive. I'm also enjoying Archlinux's pioneering
work with [systemd](http://www.freedesktop.org/wiki/Software/systemd/), so all
my services are now sanely managed!

I am trying to forget the days of using hopelessly out of date software on
Debian. For example you can't do interesting stuff with multimedia on Debian if
you running ancient versions of ffmpeg.

CoreOS implements an automated upgrade mechanism along the lines of ChromeOS.
Tbh I don't have experience of ChromeOS updates, though they must work. My big
criticism of this approach is that they might as well use gitfs like
[Webconverger uses for upgrades](http://webconverger.org/servers/). Automatic
upgrades are the future, so big thumbs up from me here.

I'm also having a hard time understanding what CoreOS means by "base". In
Webconverger, our [base is the entire
rootfs](https://github.com/webconverger/webc). With gitfs you can even roll
back, as well as get updates.

Is "base" LAMP? I.e. Apache/MariaDB/PHP?! Or all the databases and other crud
people think they need to run Node, Rails, Django or some other bloated Web
framework?  Personally I prefer just **one** highly tested canonical system
(not just base, everything to run that Web app), otherwise things get complex.
Supporting different types of configurations via packages sucks, because there
is a permutation explosion when it comes to variations in how to do this. Maybe
they'll propose a "base system" for Rails, and another for "NodeJS & MongoDB"
etc etc. At least that avoids a "permutation explosion" via packages.

I am not so sure if I trust CoreOS developers to make the "base" choices for
me. Ultimately people get conservative and start running older and older
software. It will probably get bloated too. Suck.

Update: I think the base OS is just for running several instances of say Ubuntu
in docker containers. Tbh I thought the containers would inherit the base
system OS entirely, but this doesn't seem to be the case.

On a further IRC discussion, Brandon Philips seemed to envision lightweight
containers running almost a static build of a Web application:

	10:32 <philips> hendry: the applications would talk to etcd. A container isn't
	exactly like a virtual machine guest. For example you could have a node.js
	application or go application that runs just fine in a container that is just
	libc, resolv.conf and a few other required files

# Wtf is Docker?

IIUC [Docker](http://www.docker.io/) is a fancy name for <abbr title="LinuX
Containers">LXC</abbr> aka "chroots done right" (but with a ton more
complexity).

So I think the idea is that you `git push` into a Docker container with the
underlying "standardised" / "stable" CoreOS OS and out pops your hosted vhost
Web application. I think this is the model OpenStack pushes hard. It's a good
model for the unwashed, but I find it a little claustrophobic.

I really miss doing some iterative development from the remote ssh shell.
Anyway, most "developers" push out using FTP, so this is a marked improvement,
for sure.

# And Wtf is etcd?

[Etcd](http://coreos.com/blog/distributed-configuration-with-etcd/) as I understand it, is used for two things:

1. Key value store for configuration data like the Windows Registry, for services running on CoreOS
2. Some tools to manage the distribution / control of the services

Key, value store is easy to imagine. But how does that map to `/etc/nginx/nginx.conf` one might be thinking?

Well ideally I'm told that services talk directly with etcd, but if they can't
like most Linux services currently, they need to talk via
[confd](https://github.com/kelseyhightower/confd), so you end up with something
like:

	etcd -> confd -> /etc/nginx/nginx.conf

Tbh I don't like this at all. I think you could simply manage [service
configurations in git](https://github.com/Webconverger/sg.webconverger.com) and
use some sort of hook to expand macros like HOSTNAME or whatever you need
machine by machine.

The abstraction or mapping between etcd and a services config file, e.g.
`/etc/postfix/main.cf` is obviously going to be
[leaky](http://en.wikipedia.org/wiki/Leaky_abstraction). The only positive
point I can think of, is that it maybe over time... services like postfix,
nginx, apache et al to talk directly with etcd and gets rid of their particular
crufty configuration languages. I.e. make things much simpler for admins!

## What about this "tools to manage the distribution / control of the services" feature of etcd

Ok, you would think they would split this out to another tool name. Anyway, as
I understand it, etcd **also** gives you **automation** abilities.

Lets pretend you are spinning up 30 machines to serve some Web service.
Without getting trapped into the <abbr title="Amazon Web services">AWS</abbr>
suite of tools, you would face lots of problems like:

1. monitoring the instances
2. knowing when the instances are online
3. adding instances to your load balancer

These are the use cases etcd is said to solve. You can't use Avahi for service
discovery when VPSes are spinning up around the world, CoreOS proposes
[Chubby](http://static.googleusercontent.com/external_content/untrusted_dlcp/research.google.com/en/us/archive/chubby-osdi06.pdf)
instead.

I'd be interested to see how or if etcd developers will integrate with systemd.

So with that preamble, a good summary is given at the bottom of the <http://coreos.com/> page:

* minimal - linux + systemd (and their base OS they don't mention)
* containers - chroots ... yay
* service discovery ... like AWS's pioneering stuff but open

<img src=http://s.natalian.org/2013-11-02/1383372510_1366x768.png>

Good luck to the CoreOS team. I will be keeping a very close eye on their developments!

Update: I am now [[experiencing_CoreOS+Docker]] !
