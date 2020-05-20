---
date: 2009-02-01 20:29:32 +0000
---

# Maintain URL integrity (including HTTPS!!!)

Entering https://paypal.co.uk into a mobile Android browser should take you to
a secure payment site. There you should be secured and stay secured.

What happens currently is that Paypal UA (Browser) sniffs the mobile UA and redirects you
to an unsecured http://paypal.co.uk/m. Attackers can exploit this by
overriding UA strings so that Web sites use insecure connections.

When you do log in to Paypal, it does redirect you again to HTTPS, though this
is confusing. Maintain the [SSL protocol](http://en.wikipedia.org/wiki/Transport_Layer_Security).

# Mobile content transformation (ct) can break security

Content transformation proxies deployed on several mobile IP networks might
[rewrite a HTTPS
link](http://www.w3.org/TR/ct-guidelines/#sec-https-link-rewriting) and hence
lose security.

This is insane.

# Maintain wildcard HTTPS certificates

Some sites like paypal.co.uk only have a valid certificate for
**www.paypal.co.uk**.

Hence a dangerous mess if someone goes to https://paypal.co.uk from any device,
as SSL won't work!

# Title is redundant

* HTML title's get buried in iframes and like it or not this is how a lot of mashups will work (sandboxing)
* Titles often maintain identity. This is better done by URLs (domain names). When you go to Yahoo.co.uk, your tab should read yahoo.co.uk, not "Yahoo! UK &amp; Ireland"
* HTML titles should instead be a heading **h1**. This is very often the case already.

UAs should show the full URL at the top of the page. So people know where they
are and can use this information to switch between devices and guard against
phishing attacks. The URL also can provide powerful input mechanisms.
[Example](http://traintimes.org.uk/wok/wat) URLs are the corner stone of the
Web, do **not hide** or obfuscate them!

# http:// is redundant

URL links should not promote typing of http://.

It's **seven** unnecessary characters which really harms the take up of the mobile Web.

UAs currently will take users to an unsecured http:// domain, especially if
they bother to type in this redundant prefix.

UA should check for HTTPS site first, before redirecting to http://, though no
UAs unfortunately do this currently.

If you need to point out a link in a billboard, I suggest underline the <u>example.com</u>.

# www. prefix is redundant

[Honestly!](http://no-www.org/) Purists can use CNAMES.

Typing these **four** extra characters harms the mobile Web! :(

Typing **google.com** into the URL bar will redirect the user to **www.google.com**. NO!

# Notice the HTTPS padlock takes up room

I suggest using [colours](http://q.dabase.com/) like a gold or
[green](http://www.flickr.com/photos/jamiekitson/3176790336/) bar like Firefox
does already.

However the padlock is well supported and recognised. Probably just leave this
one as it is.

# Fix dot com

Far too many useful dotcom domains are squatted upon. This is ridiculous and
greedy. We need a bigger namespace (with shorter URLs), however without
promoting fragmentation, like the uncool device specific
[dotMobi](http://en.wikipedia.org/wiki/Dotmobi)
[TLD](http://en.wikipedia.org/wiki/Top_level_domain).

If the domain is not in use, it should be thrown back into the pool.

Domain names need to become much shorter, to make them usable on the mobileWeb.

Unicoded URLs with
[IRIs](http://en.wikipedia.org/wiki/Internationalized_Resource_Identifier)
might ease the situation, but it's still really really bad. Worryingly Unicode
glyphs can confuse and allow for even more phishing attacks.

# Search is a dangerous form of identity

One can argue the mess with domain names is largely solved by **URL search**.
Submit "Paypal" in the search bar and Google will redirect you to
"Paypal.co.uk" (if you live in the UK).

Search is **more usable** than domain URLs, but people must be aware of the
risks and clearly be shown the resulting URLs by UAs.

Google is essentially an identity broker.

Want to become the domain for when someone enters "Paypal" into the URL bar?
Pay Google for it and it could likely be the case.

# Silly TLD suggestion of my own

Have a TLD for every year. Effectively this is the site's founding year.

* dabase.2000
* google.1998
* yahoo.1994

Though I don't think they should be necessarily backdated like the above examples.

.com should be mapped to .2009 and then next year, 2010, one could register
google.2010. People should keep in mind when a company was formed or founded to
know the correct identity of the domain. Through use, I don't think it will
that difficult to remember that Google's domain is google.1998 as opposed to
google.2020. Some fool could register google.2020 in Bangkok in the year 2020,
though who cares?

If the google.2020 business is better at searching than the company behind
google.1998, which shouldn't we use google.2020? :P

# Certificate fragmentation

Different devices. Different trusted roots. Complete nightmare.

What's worse is that many devices like the Iphone and Android [[G1]] do not
allow you to manage certificates. This could well be a super disaster.
