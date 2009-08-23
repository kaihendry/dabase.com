<a href="http://www.flickr.com/photos/hendry/3848844048/" title="Scan with your mobile by Kai Hendry, on Flickr"><img src="http://farm4.static.flickr.com/3420/3848844048_123e5e9f56.jpg" width="375" height="500" alt="Scan with your mobile" /></a>

Whilst passing through Waterloo station, I usually buy some fresh fruit juice
from the Marks&Spencers (M&S) store. This time I noticed my bottle had some
sort of 2d barcode on it.

I spent a few uncomfortable minutes trying and trying again to scan the code
with the "Barcode Scanner" application on my Android G1. Didn't work. :(

Later I [found out](http://2d-code.co.uk/marks-and-spencer-2d-code) that this a
<a href="http://en.wikipedia.org/wiki/Data_matrix_%28computer%29">Data Matrix
code</a> and not a <a href="http://en.wikipedia.org/wiki/QR_Code">QR code</a>.
ARGH!

Unsurprisingly 'Data Matrix' support is 'alpha' quality according to the [ZXing
library](http://code.google.com/p/zxing/) powering the Barcode application on the UK T-mobile Android G1.

# WAP is CRAP

In the small print it says **WAP enabled mobiles only**. Eh? Have I gone back
in time 8 years? To add insult to injury there is a link to the T&Cs:
<http://www.mands.mobi/ftg> worryingly using a
<http://en.wikipedia.org/wiki/DotMobi> address!

<http://www.mands.mobi> reveals some suspects to this crime: [Incentivated](http://www.google.co.uk/#hl=en&q=Incentivated's+WAPsite+Publisher)

	Welcome to Your M&S
	Our new corporate mobile internet site is coming soon. Please check back later
	Site built using Incentivated's WAPsite Publisher

OMG. How piss poor M&S. :(

# 2d codes suck too

<img src="http://upload.wikimedia.org/wikipedia/commons/5/5d/UPC-A-036000291452.png" alt="barcode" />

Regular [barcodes](http://en.wikipedia.org/wiki/Barcode) are OK in my book,
because they have a **human readable** 13 digit fall back (036000291452) running along the
bottom. I remember when 'Checkout dollies' (as we call them in the South West),
typed in that that number in case the **barcode failed to read**.

Where is the fall back to 2d codes??

As a 2d-code fallback I suggest clearly printing a short (hopefully meaningful)
URL e.g.  `m&s.co.uk/oj` (12 characters) and markup your content in
[HTML5](http://www.whatwg.org.com/html5).
