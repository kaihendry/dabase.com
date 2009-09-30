In order for a "Working Draft" specification to become a "Candidate
Recommendation" at the W3C, it is [likely to need a test
suite](http://www.w3.org/2005/10/Process-20051014/tr.html#cfr).

Since the [Widget P&C
specification](http://dev.w3.org/2006/waf/widgets/Overview_TSE.html) is of
profound interest to many, we hope you too will be interested in helping
realise its potential. A [Widget test
suite](http://dev.w3.org/cvsweb/2006/waf/widgets/tests/) would help ensure
compliant and interoperable Widget runtimes(WRTs).

# Grab the W3C widget test sources with [CVS](http://en.wikipedia.org/wiki/Concurrent_Versions_System)

	export CVSROOT=:pserver:anonymous@dev.w3.org:/sources/public
	cvs login

Password is 'anonymous'.

	cvs checkout 2006/waf/
	cd 2006/waf/widgets/tests/test-cases/

Subsequent updates to the checkout can be done with `cvs update -d`

# Bookmark these docs

* [Widget P&C](http://dev.w3.org/2006/waf/widgets/Overview_TSE.html)
* [Widget P&C test plan](http://dev.w3.org/2006/waf/widgets/tests/)

# Tip for [vim](http://en.wikipedia.org/wiki/Vim_%28text_editor%29) users:

	au BufReadCmd *.wgt call zip#Browse(expand("<amatch>"))

# How the tests for the _test assertions_ are tracked

The [Widgets 1.0: Test Suite for Packaging and Configuration](http://dev.w3.org/2006/waf/widgets/tests/) has some Javascript which extracts the test assertions from <http://dev.w3.org/cvsweb/~checkout~/2006/waf/widgets/Overview_TSE.html?content-type=application/xml;%20charset=utf-8>.

Every testable assertion (TA) has a unique id, so ultimately it gets "mashed
up" with a [
test-suite.xml](http://dev.w3.org/2006/waf/widgets/tests/test-suite.xml), which
will have entries like:

	<test for="ta-dxzVDWpaWg" src="test-suite/ta-dxzVDWpaWg/000/test.wgt">
	Test to make sure that the the UA only checks the root of the widget for config files, and not in an arbritrary folder.
	To pass, the user agent must result treat this widget as an invalid widget (config file is not at the root).
	</test>

What is **ta-dxzVDWpaWg** again? You can check the **test assertion** by either:

* Finding the string `ta-dxzVDWpaWg` in [Widgets 1.0: Test Suite for Packaging and Configuration](http://dev.w3.org/2006/waf/widgets/tests/)
* Or by appending it to the Widget packaging specification like so <http://dev.w3.org/2006/waf/widgets/Overview_TSE.html#ta-dxzVDWpaWg>
* Or `wget -q http://dev.w3.org/2006/waf/widgets/tests/test-suite.xml -O /dev/stdout | xmlstarlet sel -t -c "//test[@for='ta-dxzVDWpaWg']" -v '@src'`

[xmlstarlet](http://xmlstar.sourceforge.net/) should be [packaged](http://packages.qa.debian.org/x/xmlstarlet.html) in your Linux distribution. Here is another [tip](http://dabase.com/e/13025/).

# How are these widgets generated from test sources?

1. <http://dev.w3.org/2006/waf/widgets/tests/test-cases/> or the [CVS interface](http://dev.w3.org/cvsweb/2006/waf/widgets/tests/test-cases/)
2. <http://dev.w3.org/2006/waf/widgets/tests/test-cases/make-widgets.sh>
3. <http://dev.w3.org/2006/waf/widgets/tests/test-suite/> or the [CVS interface](http://dev.w3.org/cvsweb/2006/waf/widgets/tests/test-suite/)
4. And some W3C CVS blood, sweat & tears

# WTF !! I'm an implementor and every Widget test FAILS!

Does your WRT accept widgets without the **optional** widget [id attribute](http://dev.w3.org/2006/waf/widgets/Overview_TSE.html#the-widget-element)?
