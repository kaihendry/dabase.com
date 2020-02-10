Er, why doesn't HTML5 just use [ISO 8601](http://www.iso.org/iso/support/faqs/faqs_widely_used_standards/widely_used_standards_other/date_and_time_format.htm)?

Why the HELL have [they](http://whatwg.org) gone and invented their own [datetime specification](http://www.whatwg.org/specs/web-apps/current-work/multipage/infrastructure.html#valid-date-string)?

Several reasons:

* [ISO8601](http://en.wikipedia.org/wiki/Iso8601) does not define how to handle invalid strings for example
* ISO8601 actually allows three different forms for the date

Thanks to #whatwg guys for informing me. Again.

* [Background HTML5 'time date' discussion on IRC](http://krijnhoetmer.nl/irc-logs/html-wg/20081202#l-100)

The same reasoning could be applied to [XSD dates](http://www.w3.org/TR/xmlschema-2/#isoformats).
