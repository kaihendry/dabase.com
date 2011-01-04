<a href="http://www.flickr.com/photos/hendry/5323008603/" title="adb &amp; netcat example by Kai Hendry, on Flickr"><img src="http://farm6.static.flickr.com/5125/5323008603_de3c63f4ba.jpg" width="500" height="313" alt="adb &amp; netcat example" /></a>

This guide assumes you have a remote server, called `hetty.webconverger.org`
that you are going to use to avoid any firewall issues.

First make sure you have
[netcat-openbsd](http://packages.qa.debian.org/n/netcat-openbsd.html) and NOT
[netcat traditional](http://packages.qa.debian.org/n/netcat.html) installed.

	sudo apt-get install netcat-openbsd

Then to ensure your system is working try the following [basic netcat
tip](http://www.commandlinefu.com/commands/view/870/sharing-file-through-http-80-port).

Now to share my Android logging output I run on my laptop:

	adb logcat | ssh hetty "nc -v -l 8000"

Now to share my log with a remote collegue, he simply runs:

	curl http://hetty.webconverger.org:8000

or <http://hetty.webconverger.org:8000> in a browser

Now this is a simple connection and it has several problems:

* It can't be shared, only one person can view the external stream. You can view your logs by running `adb logcat` again
* Once the connection has been quit, it closes and `adb logcat | ssh hetty "nc -v -l 8000"` needs to be restarted
* The way ports free up, can be a little slow, so restarting the `nc` process may fail initially, so do **re-try**
