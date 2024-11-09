---
date: 2010-08-10 00:32:28 +0100
---

Say you handle support emails privately at `support@example.com`.

Ideally this email is distributed amongst at least two employees in different timezones: Tom & John.

Q: How does Tom answer a support email and let John knows he's answered it?
A: Use [BCC](http://en.wikipedia.org/wiki/Blind_carbon_copy)

Q: How do you make sure the inquirer keeps to the support@example.com thread/conversation and not the personal email address of Tom?

A: Use Reply-To:

In [mutt](http://www.mutt.org), you can automate this process like so:

	set include
	reply-hook .  unmy_hdr Reply-To:
	reply-hook "~C support@example.com"  'my_hdr Reply-To: support@example.com'
	reply-hook "~C support@example.com" 'push <edit-bcc>,support@example.com<enter>'
	set edit_headers

Many thanks to [scandal](http://sigpipe.org) on #mutt on irc.freenode.net for
the above `~/.muttc` configuration lines.

In [Gmail](http://en.wikipedia.org/wiki/Gmail), you can setup the Reply-To:
rule, but only for the entire @example.com account which is awkward. Also you
must remember to set the BCC: manually.

Now with some luck, you can handle support/issue requests or "bug reports" as
conversations in your inbox. This is far from perfect as your supportee may
have a crappy MUA and break the thread.

You also would have to manually archive threads to mark them as done. And then
you would only know it's "done", as there is no way of telling John is has been
archived accordingly without sharing a mailbox. Sharing a mailbox AFAIK is
pretty darn hard, though I've heard a rumour of IMAP having such a feature. And
you would probably lose some accountability benefit sharing a mailbox.

Futhermore an interim mail BTS hybrid could be better achieved with
labels/folders to emulate something like Debian's
[tags](http://www.debian.org/Bugs/Developer#tags).
