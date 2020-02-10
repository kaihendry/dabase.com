---
date: 2013-11-28 17:34:32 +0800
---

<blockquote class="twitter-tweet" lang="en"><p>There is too much configuration. There is too much state. There are too many options. There are too many dot files. Stuff should just work.</p>&mdash; Rob Pike (@rob_pike) <a href="https://twitter.com/rob_pike/statuses/360557625756229632">July 26, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

The most minimal Dovecot IMAP configuration I could find is:

	log_path = /var/log/dovecot.log
	ssl = no

	passdb {
		driver = pam
	}

	userdb {
		driver = passwd
	}

The default [dovecot.sample](http://hg.dovecot.org/dovecot-2.2/file/tip/doc/example-config) sucks <a href=http://ix.io/9bw>(>1000 SLOC!!)</a> and so does <http://wiki2.dovecot.org/QuickConfiguration>.

You need **log_path** or you won't be able to understand why dovecot fails to
come up with `dovecot.service: main process exited, code=exited, status=89/n/a`
typically seen via `journalctl --full -f -u dovecot`.

The Dovecot configuration format is a little painful. This won't work:

		passdb { driver = pam }

Nor this:

		passdb {
		driver = pam }

Feel free to experiment yourself between `sudo systemctl restart dovecot` while
`tail -f /var/log/dovecot.log` on a large screen.

In my [Archlinux system](https://projects.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/dovecot), by default email sanely ends up in ~/Maildir via Postfix handing
mail over to Dovecot's Local Delivery Agent:

	$ grep mailbox /etc/postfix/main.cf
	mailbox_command = /usr/lib/dovecot/deliver

I could just not run the IMAP part I guess and use `mutt -f ~/Maildir/`.

When I use `dovecot -n` to get a canonical view of the configuration I get:

	# 2.2.9: /etc/dovecot/dovecot.conf
	# OS: Linux 3.2.0-0.bpo.4-amd64 x86_64
	log_path = /var/log/dovecot.log
	managesieve_notify_capability = mailto
	managesieve_sieve_capability = fileinto reject envelope encoded-character vacation subaddress comparator-i;ascii-numeric relational regex imap4flags copy include variables body enotify environment mailbox date ihave
	passdb {
	  driver = pam
	}
	ssl = no
	userdb {
	  driver = passwd
	}

That managesieve... stuff is injected from installing the separate [pigeonhole
package](https://projects.archlinux.org/svntogit/packages.git/log/trunk?h=packages/pigeonhole)
btw.

My Dovecot IMAP configuration goals are:

* Have the most minimal configuration possible. Every LOC counts!
* For sent mail to be in the inbox so I can see my replies inline, in the context of a conversation like Gmail
* To get full text search search working
* To get DSPAM integrated, since I don't want SPAM and I don't want Perl on my system ideally
* To get my mailing list traffic in separate folders (I think this is where pigeonhole/sieve comes in), labelled by the listname
* To get SSL stuff working
* To be able to access my mail via Apple IOS client on my Iphone

I want to see Dovecot succeed but there are a couple of obvious problems with it:

* [the moinmoin wiki](http://wiki2.dovecot.org/) sucks, no git backend. Documentation around the Web is terrible / confusing (this blog will probably make matters worse)
* [Source control is in mercurial](http://hg.dovecot.org/dovecot-2.2/) ... urgh, no one wants to work with that anymore since 2013
* No sane bug list AFAICT
* The [mailing list archives are barely usable](http://www.dovecot.org/mailinglists.html), difficult to explore or find useful information
