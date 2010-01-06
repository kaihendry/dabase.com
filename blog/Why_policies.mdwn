What's the P in [W3C DAP](http://www.w3.org/2009/dap/) stand for?

**Policy** people! There has been some
[discussion](http://lists.w3.org/Archives/Public/public-device-apis/2009Nov/0200.html)
which misses some of the benefits of policies.

So WHY have policy? What's the point? Security should be done intrinsically
with user consent darn it! Just like the file dialog! Good point, though not
every security UI can be done so eloquently.

Let me first "come clean" and confess [I work](http://hendry.iki.fi/cv/) on a
browser plugin called [WebVM](http://webvm.net/). At a browser plugin level, I
can't easily alter the browser UI. I can't realistically create the equivalent
of the file chooser. I can however execute policy with a [simple GTK dialog
prompt](http://www.flickr.com/photos/hendry/2293214419/) or rather deny/permit
rule outcomes.

I'd rather not prompt the user to make security decisions. I'd rather execute
defined policy via WebVM. Though sometimes you have to prompt the user.

Existing Geolocation implementations do
[simplify](http://www.flickr.com/photos/hendry/3642114424/) matters, which is
good. But what happens if you move devices. You don't want to answer the same
Allow or Deny questions again and again. You want your security decisions
saved, your policy **preferences** to be interoperable.

Even if Geolocation was simplified further as an example, you would still want
a policy to act as a simple toggle. Lets pretend the Android power control lets
me toggle the ability to share my location or not. (Currently it just
enables/disables the GPS.)

<a href="http://www.flickr.com/photos/hendry/4127011643/" title="GPS on by Kai Hendry, on Flickr"><img src="http://farm3.static.flickr.com/2573/4127011643_4fb36763f6_o.png" width="480" height="320" alt="GPS on" /></a>

	<rule effect="permit">
		<condition>
			<resource-match attr="device-cap" match="location.position"/>
		</condition>
	</rule>

And if I want to stop sharing my location because I am thinking of walking into
a gift shop and I don't want my girlfriend to know, I just click the GPS icon.
It's off, no application can know my exact whereabouts and this could simply
look like [policy fragment](http://bondi.omtp.org/1.01/security/bondixml.rnc).

<a href="http://www.flickr.com/photos/hendry/4127011651/" title="GPS off by Kai Hendry, on Flickr"><img src="http://farm3.static.flickr.com/2576/4127011651_39d14b012d_o.png" width="480" height="320" alt="GPS off" /></a>

	<rule effect="deny">
		<condition>
			<resource-match attr="device-cap" match="location.position"/>
		</condition>
	</rule>

The same principle applies to camera, sensor, network, bluetooth and whatever
API they dream of next. Policies help user save their control preferences, even
in the simplest (most coarse grained) cases.

# Sometimes it's just not that simple

A simple dialog "prompt-oneshot" policy like that used on the [Apple
Iphone](http://www.flickr.com/photos/hendry/3642114424/) is OK, but what
happens if you require something a little more fine grained? Like a "prompt
session" to stop the prompting or a "prompt blanket" to stop prompting and
persistently store that preference.

For example you may need to go "incognito" temporarily whilst using an
application, i.e. disallow access to your current location for a session and
stop prompting.  A policy standard gives users that consistent ability. The
browser might have that option (or not), however there could be an external
tool to help manage this standard policy file. The policy file allows the user
to express (and save) complex security decisions even if the browser UI doesn't
even support it. This is important on mobiles where you need effective control
over device APIs.

# Network providers require control

So you run an expensive mobile network and you don't want rogue Web
applications going nuts on some experimental new network, messaging or billing
APIs. Operators want to initialise these policies by signing off on their use,
in order to protect their investment.

In order to cut costs in managing the whole network, and make it "compatible"
or "interoperable" with another networks, mobile operators look for a common
policy standard to initiate their devices with.

Therefore a policy standard is very important for the Web on mobiles, since it
meets carriers' conservative requirements.

Or maybe you are a large Enterprise. You want to exercise corporate policy to
stop all your salesman from accessing Facebook all day.  Again you need to meet
their requirements with a policy standard to allow those Enterprises to set up
their policies.

# Security industry

Once we have a policy standard, we could perhaps delegate security decisions to
third parties like stopbadware.org or your security product vendors like Trend
Micro etc.

Security is hard work, so allowing a platform for others to provide a service
can help scale the use of new APIs. The services don't have to be white/black
lists (virus definitions), they could be innovative security UIs, allowing you
to disable location between 8pm and 8am.

# The benefits of policies

* Users: keep a consistent, controlled & safe experience
* Providers: Conservatively trial and control new network APIs
* Third parties: Allows a platform for security products

Admittedly I have simplified the security to API feature level, instead of the
more fine grained API level security that I am not keen on discussing without
details. Hopefully you'll at least the acknowledge the need for a programmable
security API as we've [initially proposed to the W3C](http://wiki.webvm.net/papers/security-ws-pp-2008/).
