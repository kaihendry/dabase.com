---
date: 2015-08-18 14:34:06 +0800
---

What seems like years ago now, hosters like Dreamhost would offer **shared
hosting** and they would keep PHP updated for you.

This fell out of favour once vendors started to offer whole virtualised
machines cheaply (e.g. Digital Ocean), since now you have more control to run &
install programs that might require superuser privileges! HOWEVER that has
lumped developers now with the headache of maintaining PHP and the rest of the
system.

# Problem

Like some of my dear readers I maintain several
[servers](https://webconverger.org/servers/) over the years and tbh running
either `pacman -Syu` or `apt-get update; apt-get -u dist-upgrade` has become
tiresome... TO SAY THE LEAST!

So picking PHP as a specific example, how do you keep it up to date painlessly?

Tbh I did find [CoreOS update
functionality](https://coreos.com/using-coreos/updates/) to work. There was
some nasty surprises like random reboots, but you can override/control that. I
think it uses somewhat over-complex technology from ChromeOS. Caveat: I helped
develop a update system called
[git-fs](https://github.com/Webconverger/git-fs), but I've yet to adapt it for
server environments.

However the big issue with CoreOS is that the Docker image itself wasn't
updated and tbh [[updating_Docker_images_is_a_PITA|Docker_container_update_workflow]].

# Proposed solution ... using containers

So with some experience of Copy-on-Write filesystem like btrfs under my belt, I
now know I can duplicate a rootfs cheaply.

So the idea in my head is that I could have one "golden" PHP+nginx image and roll
that out across my PHP applications using some systemd-nspawn and btrfs scripting magic.

That maintained "golden" image could and would ideally staged before rolling it
across all Apps, to ensure stability.

Is there a better way? I'm not aware of any tooling to do this, so I guess as
usual I need to develop my own. There is also the question of maintaining the
host system.

I could and probably should use Docker for this, but I'm a bit fed up with
Docker since it's too slow and bloated for my taste. I much prefer
**systemd-nspawn**, however that only really works well on the rolling release
Archlinux at this point in time.
