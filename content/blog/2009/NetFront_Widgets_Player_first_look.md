---
date: 2009-02-17 16:40:52 +0000
---

<a href="http://www.flickr.com/photos/hendry/3288146844/" title="Netfront with http://gwgt.webvm.net/ by Kai Hendry, on Flickr"><img src="http://farm4.static.flickr.com/3557/3288146844_e3652b7179.jpg" width="500" height="375" alt="Netfront with http://gwgt.webvm.net/" /></a>

With all due respect, [Access
Company](http://en.wikipedia.org/wiki/Access_Co._Ltd.) cannot claim to support
the [W3C widgets specification](http://dev.w3.org/2006/waf/widgets/) with their
latest release 'NFWP20_WMPRO_ENU_R002.CAB' of their [widgets
player](http://widgets.access-company.com/mobile/en/).

Firstly my very poor conformance checker named [widget
validator](http://wgt.webvm.net/) points out some doctype errors. E.g. they use
title instead of name. Ok, minor... but...

Then I tried to get one of my [widget books](http://gwgt.webvm.net/) to load in
NetFront widget runtime. The run time does not seem to understand the [content
element](http://dev.w3.org/2006/waf/widgets/#the-content-element)!

Then I renamed the startfile to a default `index.html` and I did manage to
download and install my widget from Opera. Remarkable. However I was unable to
launch the widget. The run time reports: "Error occurred. Code: 100000004".
Hmm, that error code looks suspiciously like a string.

The [BONDI reference implementation](http://updates.bondi.omtp.org/) amazingly
seems to be the most W3C compliant Widget runtime atm.

If any employees of Access (Disclaimer: <a
href="http://hendry.iki.fi/cv/resume.html">I used to work for Access</a>) are
reading my (new) blog, I encourage you look at some [draft W3C widget test
suite](http://wgt.webvm.net/qa/) cases I am working on.

Otherwise I am impressed. [HTML5 canvas
support](http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#the-canvas-element)
LGTM and it feels quite responsive.

# Looking a little deeper into the Access Company widget configuration document

I downloaded a couple of [NetFront
Widgets](http://widgets.access-company.com/mobile/en/) and peered into them
with <a href="http://en.wikipedia.org/wiki/Vim_(text_editor)">vim</a> and a
helpful `.vimrc` setting:

	au BufReadCmd *.wgt call zip#Browse(expand("<amatch>"))

Besides `config.xml` (widget specification says this is optional btw), there is
often a `config.js`. The config.xml is extended with **xwidget**.


    <access network="true" />
    <xwidget profile="1.0" distributeurl="https://update.access-widgets.com/update_check.php">
        <accessControl>
            <netaccess host="www.google.com"  port="80" />
            <netaccess host="maps.google.com" port="80" />
        </accessControl>
    <display type="VGA" width="300" height="90" />
    <display type="QVGA" width="180" height="60" />
    </xwidget>


* They seem to have additional requirements with screen sizes with `<display>`. I [think scalability](http://lists.w3.org/Archives/Public/public-webapps/2009JanMar/0089.html) might be a problem... esp. when you consider widgets are usually dependent on pixel perfect **canvas** support.
* They should be using the [update element](http://dev.w3.org/2006/waf/widgets/#the-update-element) instead of this proprietary distributeurl attribute

The proprietary netaccess tag, reflects the a similar issue in the [BONDI
Architecture and Security
document](http://bondi.omtp.org/BWiki/BONDI%201.0%20Release%20Candidate.aspx),
which extends W3C widgets with a **bondi** namespace (not xwidget) and elements
like:

	<bondi>
		<resources>
			<network>
			<target>www.google.com</target>
			<target>maps.google.com</target>
			</network>
		</resources>
	</bondi>

So I guess the [access
element](http://dev.w3.org/2006/waf/widgets/#the-access-element) needs a
makeover to meet Access's and Bondi's requirements.
