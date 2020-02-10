---
date: 2014-11-09 23:49:33 +0800
---

	23:19 <hendry> biggest feature missing for me is dockers lack of vhosting support. hosting off a random port is a bit silly, no?
	23:20 <dstufft> hendry: you can't generically do vhosting
	23:24 <hendry> dstufft: not quite sure why vhosting is SUCH a hard feature
	23:24 <niloc132> hendry: for a start, its http-specific
	23:26 <dstufft> and even for the protocols that do support a vhost feature, there isn't a standard protocol agnostic way of getting that information
	23:26 <exarkun> You can set up your own vhosting in a container.  Docker doesn't /have/ to support it.  So it's probably better if Docker doesn't, given the lack of a single, obvious, complete (ie, supporing all protocols) solution.
	23:26 <exarkun> And you can find lots of http vhosting images out there now because people do want to do this and have already solved the problem.
	23:27 <hendry> i don't want to solve it in the container. I guess I need to study some nginx reverse proxy thing
	23:27 <dstufft> nginx can do it
	23:27 <dstufft> or haproxy
	23:27 <dstufft> or any number of things
	23:28 <dstufft> I like haproxy for it, it's a pretty good tool
	23:28 <exarkun> Do you have a reason that you don't want to solve it in a container?  The way you state it, it sounds like an arbitrary constraint.
	23:28 <hendry> dstufft: why haproxy over nginx?
	23:28 <hendry> exarkun: because i would be building more complexity in my container that i want to keep dead simple? or is the functionality running in another seperate container?
	23:29 <dstufft> hendry: haproxy isn't HTTP specific, so if you find yourself wanting to do more you don't need to drop in another thing to handle it
	23:29 <dstufft> it would be running in another seperate container
	23:29 <hendry> dstufft: everything i do is HTTP.... (though does Websockets run over port 80/443?)
	23:29 <exarkun> hendry: As dstufft said, *not* in your container.
	23:30 <exarkun> That's the point.  Independent, composeable units.  Containers.
	23:30 <hendry> exarkun: can you point to such a solution for a container to dispatch vhosts IIUC to another container ?
	23:30 <exarkun> You can find one with two minutes of Googleing, I think.
	23:31 <hendry> "vhost docker container" not looking good
	23:33 <hendry> https://registry.hub.docker.com/search?q=vhost not looking great either
	23:33 <hendry> exarkun: i give up
	23:35 <exarkun> To your credit, you did spend three minutes.
	23:35 <exarkun> I don't know what more effort anyone could be asked to expend than that.
	23:36 <exarkun> (I'm certainly not going to!)
	23:37  * hendry sighs
