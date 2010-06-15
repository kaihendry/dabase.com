To me the [W3C DAP](http://www.w3.org/2009/dap/)
[calendar](http://dev.w3.org/2009/dap/calendar) is a reworked [BONDI
calendar](http://bondidev.omtp.org/modules/calendar.html), which simply misses
the mark for me. Nevermind the [proposed added
complexity](http://lists.w3.org/Archives/Public/www-archive/2010Mar/att-0026/Proposal_of_Lunar_Calendar_System_to_Device_API.pdf)
and the "god knows how" the two APIs are going to converge, lets start at the
beginning.

The [DAP](http://www.w3.org/2009/dap/) defined [use cases](http://dev.w3.org/2009/dap/calendar/#use-cases):

* A web application would like to access the device calendar
* A user would like to create/modify/delete a Calendar appointment
* A user would like to enter a birthday of his friend with a recurrence event
* A user would like to set a reminder for upcoming events.

Lets distil what we are trying to do. Because I for one don't care about the
calendar of my mobile device (who does?). I care about the calendar on my Web
service <http://calendar.google.com>. I find out about friends' birthdays on
<http://facebook.com>. What I want my personal mobile device to do, is to
**remind** me about those events in my calendar.

How does one get reminded? The way I have been doing it for years is setting
alarms on my personal mobile device.

Alarms to wake up. Alarms to go to my dentist appointment. Alarms reminding me
about my Mother's birthday. The most basic alarm just sounds or vibrates the
phone at the start of the appointment. More advanced alarms could notify you (in
advance) in a variety of ways.

So what I am saying we don't need a calendar API, we need a **reminder API**. A
good clean native API implementation on an Android smartphone looks like:

<a href="http://www.flickr.com/photos/hendry/4442265961/" title="Alarm by Kai Hendry, on Flickr"><img src="http://farm3.static.flickr.com/2788/4442265961_92e6706511_m.jpg" width="144" height="240" alt="Alarm" /></a>

The dreaded [repeating UI](http://www.flickr.com/photos/hendry/4442265963/) is
very simple and it just works for most cases. I've done this
[before](http://natalian.org/archives/2007/07/30/pimples/).

The easiest way to implement this natively is to leverage [cron](http://en.wikipedia.org/wiki/Cron), for example:

	# m h  dom mon dow   command
	35  7  *   *   sun         alarm
	30  6  *   *   mon         alarm
	5   7  *   *   tue,thu,fri alarm
	40  6  *   *   wed         alarm+vibrate
	0   8  *   *   sat         alarm

# The "Alarmed" Calendar [WebIDL](http://www.w3.org/TR/WebIDL)

	interface Alarm {
	attribute DOMString name;
	attribute DOMString m;
	attribute DOMString h;
	attribute DOMString dom;
	attribute DOMString mon;
	attribute DOMString dow;
	attribute DOMString action;
	};

	interface AlarmFilter : Alarm {};

	typedef sequence<Alarm> AlarmArray;
	typedef sequence<DOMString> StringArray;

	interface Callback {
	  void call(Object ob);
	};

	interface AlarmManager {
	 void set(Callback c, AlarmArray alarms);
	 void get(Callback c, [Optional] AlarmFilter filter);
	 void del(Callback c, [Optional] AlarmFilter filter);
	};


Using [man 5 crontab](http://manpages.debian.net/cgi-bin/man.cgi?query=crontab&sektion=5) as a guide, lets set an alarm for getting up for work:

	navigator.alarm.set(
		function(ob) {
			if (ob instanceof Error) { alert(ob); }
			else { alert("Alarm(s) set " + ob); }
		}, [{ name:"wakey wakey", h : "7", dow: "1,2,3,4,5", action: "sound"}]);

Lets sync our alarms with our service in the cloud, like so:

	$.getJSON("http://calendar.example.com/?auth=" + auth + "&callback=?",
		function(data){
		navigator.alarm.set(
			function(ob) {
				if (ob instanceof Error) { alert(ob); }
				else { alert("Alarm(s) set " + ob); }
			}, data);
		}

If I leave out the filter, I mean all:

	navigator.alarm.del(
		function(ob) {
			if (ob instanceof Error) { alert(ob); }
			else { alert("All alarm(s) deleted " + ob); }
		});

	navigator.alarm.get(
		function(ob) {
			if (ob instanceof Error) { alert(ob); }
			else { alert("Active alarm(s)" + ob); }
		});

Hell, you could implement this [cron in
Javascript](http://elijahr.blogspot.com/2009/03/javascript-cron.html) if you
had [HTML5 audio](http://dev.w3.org/html5/spec/video.html#audio) and some [UI vibrate](http://bondidev.omtp.org/modules/ui.html#startVibrateN10415) and [flash](http://bondidev.omtp.org/modules/ui.html#lightOnN1056A) goodies at your disposal.

I also think it's important to have a mapping to a [RestFUL
API](http://en.wikipedia.org/wiki/Restful), for example:

	POST /set
	Req: {{ m: "*", h: "*", dom: "*", mon: "*", dow: "*", action: "sound+vibrate+flash" }}

	Res: [ 1 ] // affected ids or name

	POST /get
	Req: { m: "*", h: "*" }

	Res: [
			 { m: "*", h: "*", dom: "*", mon: "*", dow: "*", action: "sound+vibrate+flash" },
			 { m: "*", h: "*", dom: "*", mon: "5", dow: "*", action: "sound+vibrate" }
		]

	POST /del
	Req: { "1", "wakey wakey" }

	Res: [ "1", "wakey wakey" ] // affected reminder ids/names/labels

That way I could send an alarm set request (with some auth magic) on my
mobile's httpd endpoint at for example http://192.168.1.10/alarm/set without
even touching my mobile device.

Please let [me](http://hendry.iki.fi/) know what you think.

Cons:

* The Android "clock" interface I said was great can't actually describe a cron job accurately. However, the [repeating UI](http://www.flickr.com/photos/hendry/4442265963/) could be extended for simple representations of 'm,h,dom,mon'
* Cron has issues like not knowing holidays and stuff like that. I guess a clever implementation could mark this.
