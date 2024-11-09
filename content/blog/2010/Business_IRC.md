---
date: 2010-06-15 18:43:03 +0100
---

In a modern distributed company in order to communicate, businesses use tools
like teleconferences (urgh), email, instant messaging (which one?) and more
integrated packages like [campfire](http://campfirenow.com).

Or you can be a little old school and use **existing platforms for real time
chat** like Inter Relay Chat (IRC). IRC does exhibit quite a learning curve,
though if your company are engineers, it shouldn't be too much a problem to
learn [how to use IRC](http://www.irchelp.org/irchelp/ircprimer.html).

Here is a **guide to setting up your company with a private channel** on
[Freenode](http://freenode.net/using_the_network.shtml). Whilst running your
company on Freenode is not strictly [on
topic](http://freenode.net/policy.shtml#ontopic), it certainly isn't [off
topic](http://freenode.net/policy.shtml#offtopic).

I think [Freenode](http://freenode.net/pdpc.shtml) should definitely discreetly
host company channels, since it will only encourage companies to contribute to
open source software projects down the line.

# NickServ - user authentication

First you need to register with nickserv, `/msg nickserv help register`

Then you need to configure your IRC client to authenticate (identify) to the
nickserv on [startup](http://www.irssi.org/documentation/startup). Ideally all
your employees need to do this, though you can restrict your channel to IPs
instead.

# ChanServ - restricting your channel to your employees

Setup a dialog with chanserv and then begin like so:

	help
	help register

Which provides help how to register your channel. For the purposes of this tutorial, I'll use #example.

	register #example

Then (providing your registered and identified with NickServ), you will become the founder of this channel.

So lets assume all your employees come in from the IP `nat.example.com`, you
can now restrict the channel to those personnel, like so:

	FLAGS #example *!*@nat.example.com +V
	set #example RESTRICTED ON

So FLAGS sets up the access control list. To see who is on the list:

	access #example list

To add an additional admin user:

	FLAGS #example ircusername +votsriRfAF

If a user tried to join your restricted channel, the user will be immediately kick banned.
So if that user is for example later added on the access list, you need to
unban that user for that user to rejoin the channel.

To see the current bans in place for the channel:

	/mode #example +b

To remove a ban for say 8.8.8.8:

	/mode #example -b *!*@8.8.8.8

# Transcripts

What about transcripts? If you run a decent IRC client like
[irssi](http://irssi.org), with screen and Apache httpd vhost on `/web` it's as
painless as:

	/SET log_create_mode 755
	/LOG OPEN -targets #example /web/irc.example.com/%Y-%m-%d

Then if we to refer to our chat yesterday I would simply say check out
<http://irc.example.com/2010-06-14>. To password protect the site, simply use an `.htaccess` like so:


	irc.example.com$ cat .htaccess
	Order deny,allow
	Deny from all
	AuthType Digest
	AuthName "acme"
	AuthUserFile /web/digest-password
	Require valid-user
	Satisfy Any
