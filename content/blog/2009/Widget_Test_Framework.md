---
date: 2009-05-11 11:14:12 +0100
---

Intro: As part of the [W3C Mobile Web Test Suites Working
Group](http://www.w3.org/2005/MWI/Tests/) I'm co-ordinating in tests of the
Widget runtime, in which W3C compliant Widget run times implement [Widgets 1.0:
Packaging and Configuration](http://dev.w3.org/2006/waf/widgets/).

# WGTQA

To begin with individual tests were written by hand in a [WGTQA git
repository](http://git.webvm.net/?p=wgtqa). My employer
[Aplix](http://www.aplixcorp.com) supported the work (~1 working day a week) as
it would be useful to partake in compliance efforts for both
[BONDI](http://bondi.omtp.org) Widget runtime efforts and our own commercial
[widget runtime offerings](http://webvm.net).

I made a couple of mistakes. They were mostly interactive tests and didn't make
use of Javascript to automate them in several cases. For example:

	5.7-startfile-pass1/
	index.html:
		<h1 style="background: green;">PASSED</h1>

Firstly I tried to pin the name of the test on the section of the
[specification](http://dev.w3.org/2006/waf/widgets/) it was testing.
Unfortunately the numbering changed, so **5.7** had worse than no meaning. It
became confusing and a huge pain to track to keep updated.

**index.html** just has a simple **PASSED** rendering. Great for interactive
tests, though useless for automation. The "start file" should have
been a simple Javascript call to indicate the test case passed.

## Testing Error conditions

The next mistake was assuming a malformed config would halt processing. In
reality a Widget runtime will ignore bogus values. I wrote several [negative
tests for
config.xml](http://git.webvm.net/?p=wgtqa;a=blob;f=wgt/7.1-wrong-namespace/config.xml),
which wrongly assumed that if the index.html was seen, it would be a FAIL.
Assuming the UA would halt and show the widget has been rejected instead, as a
PASS.

A better test would be check the _default values_ were set when a bad one was
given. Unfortunately [Widget APIs](http://dev.w3.org/2006/waf/widgets-api/) are
required to read back and test such values. This API is not available on any
current widget runtime like BONDI or Opera AFAIK.

So you can't really do negative tests, instead you need to check default values
instead.

# [WTF](http://wtf.webvm.net/) !

The "Widget Testing Framework" (WTF) is a [PHP Zend](http://www.zend.com)
powered contribution by [Opera](http://www.opera.com/), which basically deals
with the earlier automation problem. WTF comes without any substantial
tests, though Opera has stated they will share some of their existing Widget tests.

Robert Græsdal from Opera is working on WTF also just one day a week.

For example, lets look at a [test which tests the order in which index files
are run](http://wtf.webvm.net/view//step8/order). So the start files are
modified from the index template from `data/std_includes/index.html` which
references testpass.js:`testcase.result(true);` on the first case and
testfail.js:`testcase.result(false);` on all the others:

1. index.htm -- PASS
1. index.html -- FAIL
1. index.svg -- FAIL
1. index.xhtml -- FAIL
1. index.xht -- FAIL

When the widget is [downloaded](http://wtf.webvm.net/download//step8/order) a
testlib.js & style.css is also included in the widget. `testpass.js` executes
the function implemented by testlib.js which reports the test result with the
magic of AJAX to a configurable **reporturi**. Unfortunately the backend
service for this isn't provided yet by Opera, though it shouldn't be hard to
recreate.

So the framework builds the widget on the fly. Sooner or later, you'll realise
this is good testing framework for mainly checking to see if the Javascript
APIs e.g. [BONDI](http://bondi.webvm.net/apis/) &
[W3C](http://lists.w3.org/Archives/Public/public-device-apis/) for different
features works correctly within a widget.

Though WTF is not good for testing things like broken
[zips](http://git.webvm.net/?p=wgtqa;a=tree;f=gen/5.1-compression-level;) and
odd filenames and screwy encodings and such things, **before** a widget is
actually running. So WTF is not a "silver bullet", a solution for all problems
related to ensuring W3C Widget runtime conformance.

## Non-interactive interactive tests

In terms of processing a test, there are 3 types:

1. Automated
1. Visual
1. Interactive

Automated tests are best. You could run all you automated tests via a test
harness (which you need to write) after every change to your Widget runtime for
example. Hence this would become also known as a regression test suite.

Visual tests are generally written as [interactive tests at
first](http://wtf.webvm.net/view/image_media_support). The tester is basically
looking out for some green blob and then to mark it off with a button control.

You do not want expensive, labour intensive and mind numbing interactive tests.
:) Imagine for every test run after a source check in, having to mark whether
you saw a green blob or not?

Opera has an übercool internal system called SPARTAN which hashes these values
(those green blobs), so that these interactive (bad) tests can become like
automated (good) visual tests. Since SPARTAN isn't public, 'visual tests' will
remain 'interactive tests' for the time being.

Therefore it's a good idea to concentrate on writing automated tests for the
time being.

# How a widget is built up by WTF

The `widget.txt` is not just a description of the test. It also allows some easy feature switches in an INI format.

For example setting `fileio=1` should enable `opera.io` by building an
appropriate `config.xml` to enable that feature.

The idea behind that, is that it's easier for tests to be maintained that way,
than relying on the [feature
element](http://dev.w3.org/2006/waf/widgets/#the-feature-element).

Most of a widget is built up. For example using [standard includes](http://wtf.webvm.net/hgweb.cgi/file/tip/data/std_includes/):

	hendry@x61 tmp$ unzip true.wgt
	Archive:  true.wgt
	  inflating: index.html
	  inflating: style.css
	  inflating: config.xml
	  inflating: testlib.js
	  inflating: widget.txt
	  inflating: test.js

So for a [basic true test](http://wtf.webvm.net/view//basic/true): index.html, style.css, testlib.js was included and config.xml was generated.

# Open issues

## `config.xml` validation

We know what makes an invalid config.xml with [Widget RelaxNG
schema](http://hasather.net/widgets/widgets.rnc). I've written a [widget
validator](http://wgt.webvm.net/) which uses
[rnv](http://www.davidashen.net/rnv.html).

This is what a UA should do before running a widget, though how do you test a
UA (widget runtime) is doing the same as:

	rnv -q widget.rnc config.xml

Please contact me or mail the [public-mwts](http://lists.w3.org/Archives/Public/public-mwts/) if you have some ideas.

## Pinning tests

Anchor names seem to be more stable than section names, but still it seems a
little hard to reference the part of the specification, the test is actually
testing.

Alternatively, HTML5 uses an [annotation
system](http://www.whatwg.org/specs/web-apps/current-work/multipage/status-documentation.html)
for linking to tests from the specification.

## Making the WTF properly opensourced with open SCM hosting etc. etc.

The Widget Test Framework is Opera specific atm and needs several changes.

My debug copy is [publicly available in Mercurial](http://wtf.webvm.net/hgweb.cgi).

## Test harness

Something to run the tests and collect the tests results is needed.

## Visual tests

A system like SPARTAN is needed to make visual tests, less interactive.

# Notes on different Widget runtimes

## Opera

Does not allow `alert()`. [Workaround:](http://twitter.com/ppk/status/1784451212)

	var alert = function (msg) { widget.showNotification(msg); }

Serving from *.opera.com will avoid security prompt. i.e. add `127.0.0.1 foo.opera.com` to /etc/hosts
