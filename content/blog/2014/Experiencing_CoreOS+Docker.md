---
date: 2014-10-20 13:50:34 +0800
---

<embed style="width: 30%" type="image/svg+xml" src="http://s.natalian.org/2014-10-20/coreos_logo.svg" />
<img src=http://s.natalian.org/2014-11-14/docker-logo.png alt="Docker Logo">

Once upon a time there was
[chroot](http://git.suckless.org/sbase/tree/chroot.c) (notice, it's just
50LOC?!). `chroot` was a simple way of sandboxing your application, namely just
[filesystem isolation](http://unix.stackexchange.com/a/141595). `chroot` lacked
some features people wanted and alongs came [Docker](https://www.docker.com/),
which is a front end to <abbr title="Linux containers">LXC</abbr>. It works,
though it has a LOT of SLOC/complexity/features. Docker is monolithic and
**depends on Linux**.

Today we have general packaged distributions like Debian & Archlinux. Their
main fault was probably being **too general**, poor abilities to upgrade and
downgrade. Along comes CoreOS, a lightweight Linux OS with (a modern, but
hugely controversial init) [systemd](https://en.wikipedia.org/wiki/Systemd),
[heavyweight btrfs](http://dl.garbe.us/The_suckless_org_universe.pdf) & docker.
CoreOS is also monolithic and **depends on Linux**.

I've attempted to [understand
CoreOS](http://dabase.com/blog/Understanding_CoreOS/) before, though since I
needed to move [Greptweet](http://greptweet.com/) to a VPS with more disk
space... quickly... I "deep dived" into CoreOS & Docker and here is my writeup
of the experience. Tip #1, the default user for CoreOS is "core", e.g. `ssh
core@178.62.119.197` once you get for e.g. your CoreOS droplet going.

# Dockerfile

The 20LOC
[Greptweet Dockerfile](https://github.com/kaihendry/greptweet/blob/master/Dockerfile) took
me almost all day to create, though this was my favourite accomplishment. I studied other [Archlinux](https://github.com/search?utf8=%E2%9C%93&q=%22FROM+base%2Farchlinux%22+filename%3ADockerfile&type=Code&ref=searchresults) and [Ubuntu](https://github.com/search?utf8=%E2%9C%93&q=%22FROM+ubuntu%3Alatest%22+filename%3ADockerfile&type=Code&ref=searchresults) docker files on Github to give me guidance how to achieve this.

So now I have a succinct file that describes Greptweet's environment to function. I [found it astonishing the container for running a PHP app on Nginx is almost 1GB!](https://twitter.com/kaihendry/status/522336431251791873)

Yes, I need to re-implement greptweet in Golang to greatly reduce this huge bloat of a dependency!

# Read only filesystem on CoreOS means no superuser or what?

I was hoping CoreOS would do away with root altogether. I'm seriously tired of
`sudo`. I noticed [read only
mounts](http://s.natalian.org/2014-11-05/1415193358_1362x740.png), whilst trying to disable password ssh logins to avoid loads of:

	Failed password for root from $badman_IP port $highport ssh2

In my `journalctl`. Ok, if they are going to fix the config of `sshd_config` I thought, maybe they would do away with root?! PLEASE.

Update: If you discover WHERE `sshd_config` is managed in git by the CoreOS, I
will give you a MAN HUG. CoreOS have totally obfuscated how they maintain
configurations, compared to [Archlinux
packages](https://projects.archlinux.org/svntogit/packages.git/)!!

# Haunting permissions

I hate UNIX permissions, hate hate hate. So with Docker your data is mounted on the
host IIUC and your app stays firmly _containerized_.

But when your app writes data out on to a mount point, what THE HELL should the
permissions be? I ended up just `chmod -R 777` on my Volume's mountpoint, though I should probably have used [setfacl](/e/01178/) What a mess!

<img src=http://s.natalian.org/2014-10-20/33-perms.png alt="User/group 33">

# How am I supposed to log CoreOS/Docker?!

I'm confused about Volume mounts. I run Greptweet like so: `/usr/bin/docker run --name greptweet1 -v /srv/www/greptweet.com:/srv/http/u -p 80:80 greptweet`, and `/srv/http/u/` is where the data lives. But HOW am I supposed to get at my [container's logs](http://s.natalian.org/2014-10-20/diff.txt)? Another volume mount?

How does CoreOS envision managing httpd logs? I don't understand. And how am I
supposed to run `logrorate`!? ["One step forward, two steps
back"](http://youtu.be/xweiQukBM_k) is playing in my mind.

# Init

A jarring thing is that when you run a docker container, you <abbr title="if I
understand correctly">IIUC</abbr> are expected to run one process, i.e. the
httpd.

Unfortunately with nginx, to get PHP working you need to run a separate
(FastCGI) PHP process to nginx httpd, hence [the Greptweet
Dockerfile](https://github.com/kaihendry/greptweet/blob/master/Dockerfile) uses
Python's **supervisor** daemon to manage both processes. Urgh. I copied this
paradigm from another Dockerfile. Tbh I was **expecting to manage the process
with systemd** inside the container. Now I have Python crapware in my container
for managing nginx/php processes. Suck.

# NO Cron

Greptweet used cron to create backups, [relay stats](https://github.com/kaihendry/sg) and generate reports. Now
AFAICT I don't have the basic utility of cron in my container. Now what?!

WTF IS CRON IN COREOS, I NEED IT BACK!

Update: We are suppose to use [systemd timers](https://wiki.archlinux.org/index.php/Systemd/Timers)

# Update_engine

As mentioned in my [previous blog on
CoreOS](http://dabase.com/blog/Understanding_CoreOS/), I was quite excited
about have "free" updates to my core host system. Sadly after looking at the
logs, I'm not impressed.

There is **little visibility to the actual update**. I have recently found <https://coreos.com/releases/> but it uses some horrible XML manifest to layer on the updates. Why can't the whole rootfs just be in git ffs?

Furthermore I noticed `locksmithd` which I think reboots the machine, but I'm not sure.

	Oct 18 03:11:11 dc update_engine[458]: <request protocol="3.0" version="CoreOSUpdateEngine-0.1.0.0" updaterversion="CoreOSUpdateEngine-0
	Oct 18 03:11:11 dc update_engine[458]: <os version="Chateau" platform="CoreOS" sp="444.5.0_x86_64"></os>
	Oct 18 03:11:11 dc update_engine[458]: <app appid="{e96281a6-d1af-4bde-9a0a-97b76e56dc57}" version="444.5.0" track="stable" from_track="
	Oct 18 03:11:11 dc update_engine[458]: <ping active="1"></ping>
	Oct 18 03:11:11 dc update_engine[458]: <updatecheck targetversionprefix=""></updatecheck>
	Oct 18 03:11:11 dc update_engine[458]: <event eventtype="3" eventresult="2" previousversion=""></event>
	Oct 18 03:11:11 dc update_engine[458]: </app>
	Oct 18 03:11:11 dc update_engine[458]: </request>

I've glanced over <https://coreos.com/using-coreos/updates/> several times now
and it's still not clear to me. As an operating system maintainer myself for
[Webconverger updates](https://github.com/Webconverger/webc/commits/master),
our [gitfs upgrade system](https://webconverger.org/upgrade/) is MUCH CLEARER
than how CoreOS updates are handled. I wonder <abbr title="when the
hell">wth</abbr> Docker 1.3 is going to hit CoreOS stable.

Keeping my Archlinux docker container uptodate is also a [bit of a mystery to me](http://s.natalian.org/2014-11-07/1415343815_1362x740.png)...

# CoreOS packaging is just WEIRD

<blockquote class="twitter-tweet" lang="en"><p>My mind is BLOWN by `docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter` <a href="https://twitter.com/jpetazzo">@jpetazzo</a> <a href="http://t.co/ZLrHZLFDVS">http://t.co/ZLrHZLFDVS</a></p>&mdash; Kai Hendry (@kaihendry) <a href="https://twitter.com/kaihendry/status/522632031864254464">October 16, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

It took me way too long to figure out how to enter a Docker 1.2 container and
have a look. nsenter will be replaced by Docker 1.3's `docker exec`, but the
way it installed was very intriguing.

In fact package management in CoreOS eyes _I think_ means starting a
share/privileged container and mapping it back to the host system. That's a
pretty darn wild way of doing things <abbr title="in my opinion">imo</abbr>.

I've been BATTLING TO GET TMUX running. It was suggested that this [screen
CoreOS install guide](https://gist.github.com/crawford/62e1bf8e4f6c6bdd21e7)
might help me. There is also an odd "toolbox" alias to a Fedora container with
tools, but it doesn't map back to the host. All this for a terminal
multiplexer. OMG.

# Starting your Docker container in CoreOS was non-trivial

Here is [Greptweet's service file](https://github.com/kaihendry/greptweet/blob/master/greptweet.service).

[CoreOS's launch
guide](https://coreos.com/docs/launching-containers/launching/getting-started-with-systemd/)
was a bit strange to me. Am I supposed to publish my Greptweet image, so the
`docker pull` works? It could be a lot simpler I feel. I.e. why doesn't the
docker daemon manage/start the containers itself!?

# Conclusion

I think the basic idea of lightweight host OS (CoreOS) and containers (Docker)
has legs. I just wish it was as simple as `chroot`. Now I'm left thinking how
Ansible/Chef/Puppet/Vagrant did such a bad job compared to the
[Dockerfile](https://docs.docker.com/reference/builder/). Or perhaps blaming
VPS hosters who never really got a decent API together to move/expand/inspect
their VPS volumes.

Gosh, how did we get into this mess?!

So now system administrators now run hypervisors aka CoreOS and spin up VPSes
aka Docker containers all by themselves. Seems like another level of
abstraction that empowers system administrators but at the same time there is
going to a raft of bugs/pain to enjoy with this "movement". It's also slightly
concerning that CoreOS/Docker seems to fly in the face of the Unix philosophy.

My rating for CoreOS: 1 out of 5 stars
