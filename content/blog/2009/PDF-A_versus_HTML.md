---
date: 2009-06-24 21:33:40 +0100
---

[[!meta title="PDF/A versus HTML" ]]

2016 update: <https://shkspr.mobi/blog/2016/07/pdfs-are-the-cheques-of-the-21st-century/> has a good summary why PDF is a bad format

Latest: Leonard Rosenthol has since posted a [followup on the discussion](http://acroeng.adobe.com/leonardr/PDFA_vs_HTML.html).

[PDFSAGE](http://twitter.com/pdfsage/status/2313664922) wondered what the cons
are with PDF/A compared to simple HTML for **document archival**. The debate
generally comes down to what **you** think a document is. If it's an A4 page
for printing, you probably want PDF. If a document is an arbitrary unit of
information, I would suggest HTML.

Lets start why the [PROS of
PDF/A](https://share.acrobat.com/adc/adc.do?docid=1667083f-6cad-44d8-8c06-1a15f25090f4).
You'll need Flash to view this PDF preview. Actually to do mostly anything with
PDF, you need proprietary tools monopolised by [Adobe](http://en.wikipedia.org/wiki/Adobe_Systems).

You can't just assume people have a PDF viewer installed. Hence [PDFSAGE shared
his PDF document assuming I had Flash installed](http://bit.ly/66iJr). Another
proprietary tool. Great, what a start!

# Cons of PDF/A

* The PDF viewer isn't nearly as pervasive as a Web browser. Is there a PDF viewer on your mobile? No, I thought not.
* The PDF viewer is slower than a Web browser.
* A PDF is many times larger than an HTML file. Imagine Wikipedia as a PDF/A file? That would be CRAZY.
* Since the viewer and content are much larger than HTML counterparts, PDF/A demands a faster internet connection. Have a slow connection? You're out of luck!
* PDF isn't part of the Web. It's non-trivial to get PDF content on the Web. People end up converting it into a PNG and that's a terrible loss of information.
* It's non-trivial to index and parse out information from a PDF
* "Protected PDFs" break common computing paradigms of <a href="http://twitter.com/bengoldacre/status/3733462935">copying&pasting</a>
* It's non-trivial to edit content in a PDF. Indeed, PDFs are often designed to be static for archival and reproducible results. Though if information can't be maintained, one can argue it's dead.
* Only accurate representations of stored content can be produced if you embed the font. Bloat!
* A document is of little use unless it's transcribed into text. Scan a STASI file into a PDF. Great, now what? Storing it as a PNG would be even better as people would at least been able to view it easier.
* [PDF has a poor accessibility record](http://www.usability.com.au/resources/pdf.cfm)
* Non-trivial to diff, track, merge and compare PDF documents
* An open standard? That you need to [pay ISO](http://www.iso.org/iso/iso_catalogue/catalogue_tc/catalogue_detail.htm?csnumber=51502) 200GBP for?! Are there at least two interoperable implementations of PDF/A?
* Probably only one **conforming** implementation (Guess who!). Is there a test suite or validator? No
* [Not as secure](http://www.theregister.co.uk/2010/03/09/adobe_reader_attacks/) as Web technologies
* [OMG WTF PDF](http://www.youtube.com/watch?v=54XYqsf4JEY)

# Pros of HTML

* You can read HTML in the simplest of text editors
* [An algorithm for parsing HTML is openly defined](http://www.whatwg.org/specs/web-apps/current-work/multipage/syntax.html#parsing)
* You can "sign" an HTML file by using [XML digital signatures](http://www.w3.org/TR/xmldsig-core/). Widgets in fact use a subset called [Widgets 1.0: Digital Signatures](http://www.w3.org/TR/widgets-digsig/).
* Scalable. Want text on big or small? Sure thing.
* Easy to edit and maintain. Anyone can edit HTML with a plethora of tools and support.
* Simple to index, find and use the information marked up within an HTML file. Same is not true of a PDF.
* HTML is space efficient. PDF isn't.
* HTML can include "marginalia" like comments and notes.
* HTML has several ways of adding [metadata support](http://wiki.whatwg.org/wiki/Generic_Metadata_Mechanisms), though Google search generally does not rely on them for best results
* HTML _can_ convey critical information. It's done so more effectively that PDF has ever done.
* Need to package some HTML content? (i.e. self-containment) Use a [[widget|blog/Widgets_are_simple_offline_packages]]!
* You can generate static snapshots of HTML to formats like [PDF](http://en.wikipedia.org/wiki/PDF/A), with tools like [Prince](http://princexml.com/). You can't do the reverse very easily!
* HTML is already the primary medium for archival of information! Checkout the [waybackmachine](http://www.archive.org/web/web.php)
* Worried about data being tampered with? Mandate source control like [git](http://en.wikipedia.org/wiki/Git) where each document can be explicitly tracked since HTML can be treated as plain text for this purpose.

# Cons of HTML

* Can't be rendered consistently across devices or mediums -- HTML is not a (static A4 print) presentation format, it's a publishing format
* [[Printing|blog/Web_browser_printing_comparison]] is particularly tiresome, which is good news for trees
* [HTML is living markup](http://whatwg.org/html) and it ideally needs to be maintained
