---
date: 2015-11-10 15:24:56 +0800
title: Mail from a VPS using AWS SES from sandbox mode
---

Set up <https://aws.amazon.com/ses/> with a [verified
email](http://s.natalian.org/2015-11-10/1447139043_1150x1058.png) so that it
can send as that address and only to that address.

For your sanity keep track of the AWS region you are in! I am using [Oregon aka
us-west-2](http://s.natalian.org/2015-12-10/1449713100_1918x1058.png).

I tested both **ssmtp** and [msmtp](http://msmtp.sourceforge.net/) !

# /etc/ssmtp/ssmtp.conf

	root=foo@example.com
	FromLineOverride=NO
	mailhub=email-smtp.us-west-2.amazonaws.com:587
	AuthUser=AKIAINSHZHYMQYHXD4FQ
	AuthPass=secret
	UseSTARTTLS=yes
	UseTLS=YES
	TLS_CA_File=/etc/pki/tls/certs/ca-bundle.crt
	AuthMethod=LOGIN
	Debug=YES

# /etc/msmtprc

	defaults
	tls on
	tls_starttls on
	tls_trust_file /etc/ssl/certs/ca-bundle.crt
	account default
	host email-smtp.us-west-2.amazonaws.com
	port 587
	auth on
	user AKIAINSHZHYMQYHXD4FQ
	password secret
	from foo@example.com

# Making /usr/sbin/sendmail to send to your verified address only

When you get:

	[root@rojak ssmtp]# send-mail: 554 Transaction failed: Missing final '@domain'
	ssmtp: 554 Message rejected: Email address is not verified.

	send-mail: server message: 554 Transaction failed: Missing final '@domain'
	send-mail: could not send mail (account default from /etc/msmtprc)

Either request for a "Limit Increase: SES Sending Limits" so that your account
moves out of the sandbox, so you no longer need to verify recipient
addresses... or follow the steps below to make `sendmail` to send mail to your
only verified email:

If you use msmtp:

	v=foo@example.com # your AWS SES verified email
	cat | /usr/bin/msmtp -i -- $v

I recommend msmtp since the revaliases is just:

	# cat /etc/msmtp-aliases
	default: foo@example.com

Though `ssmtp` has nicer logging. If you use ssmtp, change the binary:

	cat | /usr/sbin/ssmtp -i -- $v

Also [ssmtp weighs in at 5k SLOC whilst msmtp is 18k](http://s.natalian.org/2016-02-11/1455175273_1912x1036.png)
