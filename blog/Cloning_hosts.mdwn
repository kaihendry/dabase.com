So, I have unenviable task of moving a VPS from Bitfolk to Linode.

Both run Debian 7 (wheezy).

So the general practice I find is to **rebuild from scratch**. Argh, doing it
by hand takes a long time.

Doing it with [Configuration
Management](http://en.wikipedia.org/wiki/Configuration_management#Operating_System_configuration_management)
would be quicker, if you bothered to spend even MORE TIME developing the
recipes to setup the machine. Nevermind the crap load of code that goes into
running Puppet or Ansible and their crazy crazy dependencies.

## Configuration management for user accounts sounds quite tricky

Previously I've something like [[create-account-with-ssh-pub.sh|e/13036]], a short ~20 line shell script.

Followed up for disabling password authentication / only allowing key based
authentication with `PasswordAuthentication No` in `/etc/ssh/sshd_config`.

I recommend maintaining a list of your users ssh public keys online to make
things easier, e.g. <http://hendry.iki.fi/hendry.pub>

Doing this in any CM tool seems absolutely non-trivial!!

# Enter rsync

In an ideal world I could just rsync everything as root. But as this
[resource](http://serverfault.com/a/490077/7798) points out, there are loads of
traps. Many mount points that shouldn't be copied over. Network configurations
and perhaps VPS specific settings that cannot be overwritten.

	root@li524-199:~# cat exclude.txt
	/boot
	/proc
	/sys
	/tmp
	/dev
	/var/lock
	/etc/fstab
	/etc/mdadm.conf
	/etc/mtab
	/etc/resolv.conf
	/etc/conf.d/net
	/etc/network/interfaces
	/etc/networks
	/etc/hostname
	/etc/HOSTNAME
	/etc/hosts
	/etc/modprobe*
	/etc/modules
	/etc/udev
	/lib/modules
	root@li524-199:~# cat rsync.sh
	rsync -aPzx --exclude-from=/root/exclude.txt root@uk.webconverger.com:/ /

