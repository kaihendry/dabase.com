---
date: 2010-01-21 16:05:12 +0000
---

<a href="http://www.flickr.com/photos/hendry/4292443879/" title="Install maemo-geolocation"><img src="http://farm5.static.flickr.com/4001/4292443879_4cf04f0655.jpg" width="500" height="300" alt="geo.webvm.net on n900" /></a>

Despite my initial
[disappointment](http://twitter.com/kaihendry/status/7945670330) with the Nokia
N900, I enjoyed working on the device today. He's what I learnt about [Maemo5](http://en.wikipedia.org/wiki/Maemo#Maemo_5_2).

* Update the device straight away. It takes an hour or so (30 mins to download, 30 mins to actually APPLY). :/ You need at least **2.2009.51**
* Enable extras in application manager
* Install openssh server and client and set root password
* Find ip from terminal `/sbin/ifconfig`
* Put ip into your machine's `/etc/hosts` under [n900](http://en.wikipedia.org/wiki/Nokia_N900)
* `ssh-copy-id root@n900`
* Add `deb http://repository.maemo.org/extras-devel fremantle free non-free` to `/etc/apt/sources.list.d/that-is-not-ham.list`
* `apt-get install rsync` and other stuff that you fancy :)
* ctrl+shift+p to take a screenshot
* `rsync -art root@n900:/home/user/MyDocs/.images/Screenshots .` to get the [screenshots](http://www.flickr.com/photos/hendry/tags/n900/)

WTF **.images** ?? See this [blog](http://viper.haque.net/~timeless/blog/170/) and blame GNU.

## Web application development on maemo

	Nokia-N900-42-11:~$ cat ~/.mozilla/microb/user.js
	user_pref("browser.consolelogfile",
	"/home/user/MyDocs/browser-logfile.txt");

Now `tail -f /home/user/MyDocs/browser-logfile.txt` and you get the invaluable JSconsole.

Thanks to #maemo and especially timeless for addressing my complaints and increasing my Nokia brand loyalty. :)
