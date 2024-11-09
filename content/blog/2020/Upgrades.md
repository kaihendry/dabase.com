---
title: Updates / Upgrades and breaking the runtime
date: 2020-11-13T08:01:09+08:00
description: Comparing platforms when it comes to breaking compatibility and wasting one's life time
---

I saw a post asking for a **SUSE SLES 12 to SLES 15 migration procedure** and
had that got me thinking about upgrades and updates.

On one corner as long as the ABI and syscall layer is stable, [static binaries
ftw](https://www.youtube.com/watch?v=JSFoFSCTA-M).

However our industry introduces docker, jars, wars, go modules, npms and other
technical debt cruft on top of it, that makes stable migrations extremely
painful thanks to the rolling updates.

Think of the relatively new introduction of systemd and how much unneeded
effort it has created, that now means converting SLES X's init stuff to SLES
Y's systemd stuff etc. This is probably the complex element to the aforementioned
migration.

Was the pain worth the value you got out on the other side? Might you have
been in a better place with a simple standalone init script?

# Windows

Windows has an exemplary record of backward compatibility as far as I can tell.

This is probably a key to their platform's success considering almost
everything around it is a dumpster fire. The filesystem sucks. The security
sucks. The upgrade procedure sucks.

The main issue with using Windows is basically removing the cruft and spyware
that Windows puts in, and the security nightmare that follow suits with a
mountain of unabated complexity which is essentially a black box to you since
its proprietary software.

# MacOS

Lately I critically read a [tweet saying sensibly that Linux wastes time over
MacOS](https://twitter.com/danluu/status/1327016451056619520).

I guess you can say that it's prescribed Desktop environment "saves time", in
the sense it standardises a platform for both novice and expert users.

Though as a life long Linux user, I can't help but think, urm, no, it does have some issues:

* The MacOS window manager sucks - lol how they pushed the natural mouse scroll wheel
* The filesystem sucks - and it can't easily mount pretty defacto good filesystems like ext
* The upgrade procedures sucks - it's slow and every major release seems to break some binaries - idk why
* Installing non-Apple blessed binaries sucks - besides their syscalls being network bound for the sake of security (OCSP), you basically you need pay Apple developer tax to do their own thing

Earlier I bemoaned the churn with Docker / npm which is pretty painful / broken
on MacOS. [The missing package manager - Brew](https://brew.sh/) is incredibly
slow compared to Arch's pacman.

MacOS escapes the requirement that it actually needs to run any Internet
service lets not forget, and worse it appears focused on making you a [share
cropper](https://en.wikipedia.org/wiki/Sharecropping).

# Back to Linux

Besides systemd, the crazy churn in packages with rolling updates being the
defacto hamster wheel way of coping.

Beside the train wreck of the "Linux Desktop" and the fact that you ideally
embrace the choices you have. For example I love dwm on X. I'd hate my Desktop
environment if I was using Gnome or was forced to use it.

Besides the known cruft on Linux and heart breaking GCC issues creating static
binaries, I still think Linux is miles ahead as a productive platform.

* [Linux can emulate MacOS](https://www.youtube.com/watch?v=As3sDrth74o)
* It can run [games faster than Windows using Proton](https://www.youtube.com/watch?v=05Z8wvnJM3Q&lc=UgzPtAk1qqhigTPRUB14AaABAg)
* It has a filesystem that's fast and does not suck
* It's free in cost and in liberty

It can be made less crufty and stable, though Linux is too busy innovating
right now.
