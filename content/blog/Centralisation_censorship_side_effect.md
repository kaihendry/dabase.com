[[!meta title="Side effect of centralisation WRT censorship"]]

UPDATE 2016-01-28: Unsurprisingly Sarawak Report moved to
[Medium](https://medium.com/medium-legal/the-post-stays-up-d222e34cb7e7#.6p7uuhxmo)
and the Malaysian government proceeded to block medium.com hilariously. If only
Sarawak Report moved to http://s3.amazonaws.com ... lol

I'm no fan of massively centralised services such as Google's Youtube,
Facebook, Twitter and Reddit, since I feel there is too much power in one
place.

Then it occurred to me that if content is hosted on any of these services (e.g.
Amos Yee's infamous Youtube channel in Singapore), then it becomes bureaucratic
for government to remove the content.

Consider the <http://www.sarawakreport.org/> which is banned in Malaysia. Since
[Internet in Malaysia](https://en.wikipedia.org/wiki/Internet_in_Malaysia) is
largely controlled by the Government, they just need to block the domain
www.sarawakreport.org. To block further domain variations and IPs is quick and
easy.

However if the Sarawak report's content was hosted upon Facebook, then
Malaysian network administrators cannot censor it. Blocking a URL path of
Facebook page is not easy and impossible over HTTPS. Of course the Malaysian
government can make a request to Facebook, though that request is logged, like:

* <https://govtrequests.facebook.com/country/Malaysia/2014-H2/>
* <http://www.google.com/transparencyreport/removals/government/MY/?hl=en>

As you can see, there isn't much transparency. We don't know any details like who,
what, when. Can we assume the information was available for days or months
before it was taken down?

I wonder can we assume content disagreeable to governments hosted a centralised
service can maybe be a little resilient to removal requests?

# When you host on your own... you are at a distinct disadvantage

You could rely on your visitors accessing your site via a VPN or Tor, but both
those options exclude anyone not computer savvy.

New domains and IPs as mentioned before are easy to block and trace for that
matter... and worse... hard to find or discover! (Nevermind cost of getting IP
and domain registration.)

## What's opposite to `rel=canonical`?

When you host your own Website: `rel=canonical` is the way to tell Google do
not index me..  `mirror.dissentdaily.com/` (a copy of some content), index
`www.dissentdaily.com/` (authoritative)! But what happens if
`www.dissentdaily.com/` is blocked?

I have never known Google to properly index a mirrored site. In the case of
[The Pirate
Bay](https://en.wikipedia.org/wiki/The_Pirate_Bay#Domain_blocking_by_countries),
sites pointing to mirrors are indexed, but as mentioned earlier blocking domain
variations and IPs is quick and easy if you control a state network, like a
state power. Furthermore Google might be indexing sites that would be blocked
and give a bad user experience... how would it know?

## Mix in centralisation again... the cloud !

I was thinking that creating a S3 bucket is fast and easy to do for a content
publisher. For example creating
`https://s3-ap-southeast-1.amazonaws.com/dissentdaily` would take just moments
to do and is hard to block. Notice how the content is on the `/dissentdaily`
path on SSL? That's practically impossible to block without breaking a lot of
sites dependent on Amazon's S3!

Update: Found an re-assuring blog on [Amazon's stance to privacy and security](https://blogs.aws.amazon.com/security/post/Tx35449P4T7DJIA/Privacy-and-Data), however their version of the [transparency report](http://d0.awsstatic.com/certifications/Information_Request_Report.pdf) is a bit lacking!

# So what's missing for Dissent Daily on `https://s3-ap-southeast-1.amazonaws.com/dissentdaily`?

There is still a discoverability problem on Google and hence a problem for
users seeking that banned content. If Google could redirect to a mirror of a
Website in case the authoritative one failed.. that would be useful for
dissenters of a particular country. Unfortunately it doesn't do that. And
obviously if it did that, it might be breaking local law.

For my fictional example: DissentDaily.com now on
https://s3-ap-southeast-1.amazonaws.com/dissentdaily`. Is it statically built?
Is it using **relative URL path** structure? Controversial publishers might want to
address that.

Enough food for thought for now. Do let me know if I've missed anything.
