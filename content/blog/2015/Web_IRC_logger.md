---
date: 2015-11-04 11:20:10 +0800
---

Upon <http://irc.dabase.com/> I log the `irc://irc.freenode.net/hackerspacesg`
IRC channel. I implemented this as **minimal** as possible! It's **not an
archive**, it's just to see what's the latest _chitter chatter_ for a
[community sign board](http://frame.dabase.com/).

To do this you will need:

1. an always connected VPS with systemd (I use Archlinux upon an AWS EC2 micro instance)
* [ii suckless IRC client](http://tools.suckless.org/ii/) since it's filesystem-based!
* [gotail](https://github.com/kaihendry/gotail) to take the file and stream it to browser using [SSE](https://en.wikipedia.org/wiki/Server-sent_events)

# systemd service files

## ii

Which would live at `/etc/systemd/system/ii.service`

	[Unit]
	Description=IRC logger
	# Start once network is up
	After=network.target

	[Service]
	# NOTE CHANGE hendry to your $USER
	User=hendry
	ExecStart=/home/hendry/tmp/ii/ii -s irc.freenode.net -n iilogbot
	# Join the channel
	ExecStartPost=/bin/bash -c 'sleep 5 && echo "/join #hackerspacesg" > /home/hendry/irc/irc.freenode.net/in'
	Restart=on-failure

	[Install]
	WantedBy=multi-user.target

## gotail

Which would live at `/etc/systemd/system/gotail.service`

Of course you would need to modify this for your IRC channel and $USER too.

	[Unit]
	Description=Log IRC to the browser
	After=ii.service
	Requires=ii.service

	[Service]
	ConditionPathExists=/home/hendry/irc/irc.freenode.net/#hackerspacesg/out
	# This is important for it to find its template
	WorkingDirectory=/home/hendry/tmp/gotail
	ExecStart=/home/hendry/tmp/gotail/gotail /home/hendry/irc/irc.freenode.net/#hackerspacesg/out
	Restart=on-failure
	RestartSec=10s

	[Install]
	WantedBy=multi-user.target

Edit & test them out (start and status systemctl cycles!) and once you are
happy, the final test is to `sudo systemctl enable ii gotail` and reboot!
