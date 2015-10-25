I'm a novice API critic after building a [couple](http://bus.dabase.com/)
[of](http://greptweet.com/) [apps](http://jbsg.dabase.com/) that depend on
APIs. I've written before about [[poor API design that hinders client side
Apps|Javascript_API_barriers]] and I've even made a [bad
video](https://www.youtube.com/watch?v=CaSTJM5UEj8).

<blockquote>All data needs a temporal reference point<br>
<cite>Me</cite>
</blockquote>

I've run into two classes of problems of APIs that can be mitigated if the JSON
API response included a **datetime** value in the payload.

	JSON.stringify({ datetime: new Date() })
	"{"datetime":"2015-10-25T08:36:46.263Z"}"

A couple of APIs that do this right:

* `curl -s https://webuild.sg/api/v1/repos | jq . | head`
* `curl -s http://data.hazewatchapp.com/index_v2.json | jq . | head`

# Problem class 1: What's is the server's time?

In the [LTA bus arrival times API](http://www.mytransport.sg/content/mytransport/home/dataMall.html) they give you the arrival **time** of a bus, e.g.

	"EstimatedArrival": "2015-03-03T07:20:24+00:00"

Nevermind how it's formatted. Ideally it would be an epoch to ease
calculations, but what's it is missing here in order to provide a **good
arrival time** considering the calculation is:

	API EstimatedArrival – Singapore Standard Time = 3 mins

Yes **Singapore Standard Time** is missing! Can you rely on
[NTP](http://www.pool.ntp.org/zone/sg)? No, not really, especially if it's a
pure Javascript client side app. Even if your server is correctly configured,
can you be sure that time is the same as the API provider's?!

Solution: API provider shows what they think current time is!

# Problem class 2: When was the payload last updated or accurate from?

Without a time stamp, you have no idea at what point of time that API is giving
you results for.

Solution: API provider includes datetime value for when the data is accurate
from!
