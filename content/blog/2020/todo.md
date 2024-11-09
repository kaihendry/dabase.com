---
title: TODO tracking
date: 2020-02-10T15:53:53+08:00
---

Update: Thanks to <https://tech.ingolf-wagner.de/> I am now using [taskwarrior](https://taskwarrior.org/), packaged as [task in Archlinux](https://www.archlinux.org/packages/community/x86_64/task/).

I thought https://jeffhuang.com/productivity_text_file/ and the [HN
comments](https://news.ycombinator.com/item?id=22276184) accompanying post to be
very inspiring.

Then I was thinking what would it take me to adopt this style.

# A shell alias

	todo () {
			cd /home/hendry/wikis/dabase.branchable.com
			hugo new --editor vim todo/$(date +%F).md
	}

Trouble that Hugo removes the dashes of the ISO8601 formatted date. Also adds
`drafts: true`. It needs to effortless to open that todo window.

# The style

The author uses a compact markdown style to record his day:

2017-11-31
11:00am meet with Head TAs
- where are things at with inviting portfolio reviewers?
11:30am meet with student Enya (interested in research)
review and release A/B Testing assignment grading
12pm HCI group meeting
- vote for lab snacks
send reminders for CHI external reviewers
read Sketchy draft
Zelda pick up eye tracker
- have her sign for it
update biosketch for Co-PI
3:15pm join call with Umbrella Corp and industry partnership staff
3:45pm advising meet with Oprah
4pm Rihanna talk (368 CIT)
5pm 1:1 with Beyonce #phdadvisee
6pm faculty interview dinner with Madonna

But as you can see, it doesn't look good in markdown. 🤦

# Lacking calendar integration

The _Prerequisite: A calendar_ really confuses me. **How do I sync this with my [Fastmail calendar](https://www.fastmail.com/help/calendar/calendartroubleshooting.html)**?

It appears it is possible to sync with the [Google suite](https://news.ycombinator.com/item?id=22276793), but I am using Fastmail!

Only [one comment](https://news.ycombinator.com/item?id=22279284) alludes to:

> (Reminds me to figure out how to morph it into iCalendar files (and perhaps
> back)) 

{{< tweet user="kaihendry" id="1226836687247929345" >}}
