---
date: 2009-11-18 12:53:12 +0000
---

Update: Marcos has replied to all my concerns <http://lists.w3.org/Archives/Public/public-webapps/2009OctDec/0943.html>

This late rant is prompted by [Widget interface spec (Last Call)](http://twitter.com/widgetspecs/status/5799561554).

Widget APIs or rather [Widgets 1.0: The widget
Interface](http://www.w3.org/TR/widgets-apis/) is largely about exposing what's
defined in the widget [configuration
document](http://dev.w3.org/2006/waf/widgets/Overview.html#configuration-document)
to the Widget developer.

**WHY?** You may rightly ask. The widget developer should know his own name and
email address whilst writing a function to mail him a [bug
report](http://www.w3.org/TR/widgets-apis/#metadata-attribute-values). I guess
someone has argued that slapping new `widget.` attributes makes it easier for
library developers. [BONDI](http://bondi.omtp.org/) incidentally rightly (imo),
didn't bother with this mapping.

Another reason WHY pointed out by
[robin](http://twitter.com/robinberjon/status/5825994237) is that the simple
Widget interface exposed by the widget runtime, would implement [locale support](http://dev.w3.org/2006/waf/widgets/Overview.html#locale-folder0)
and give you the localised interface. I.e. it's doing a bit of work behind the
scenes for the convenience of Widget developers and well...  non-English
speakers. However again, one can argue that Widget developers can implement
their own locale support, which isn't that hard (they have probably done it
before), but it would probably suck.

Ok, in an [example](http://dev.w3.org/2006/waf/widgets/Overview.html#configuration-document) Widget configuration file, like `config.xml`, you might find:

	<widget xmlns="http://www.w3.org/ns/widgets" id="http://bondisdk.limofoundation.org/widget/webcmd" version="0.4.2" viewmodes="fullscreen">

Which maps onto the [Widget interface](http://www.w3.org/TR/widgets-apis/) as:

	widget.id = "http://bondisdk.limofoundation.org/widget/webcmd";
	widget.version = "0.4.2";

Though what about viewmodes? Hmm...

Then:

	<name short="WebC">Web Commander</name>

Maps as:

	widget.name = "Web Commander";
	widget.shortName = "WebC";

Ok, the attribute `short` was used as a prefix to `name` which has become capitialised in order to make it easier to distinguish. Ok, fine. However this is there is _an inconsistency_ with:

	<author href="http://bondi.limofoundation.org/" email="sdk@bondisdk.org">LiMo Foundation</author>

Maps to the Widget interface like so:

	widget.author = "LiMo Foundation";
	widget.authorEmail = "sdk@bondisdk.org";
	widget.authorHref = "http://bondi.limofoundation.org/";

Now the author element attributes like `email` and `href` become suffixed to `author`. You see how `shortName, should be **nameShort**?

Other elements can be found on the `config.xml` such as:

	  <feature name="http://bondi.omtp.org/api/ui" required="true"/>
	  <license href="http://bondi.omtp.org/BONDI-LICENSE-2.0/"/>
	  <content src="index.html"/>
	  <feature name="http://bondi.omtp.org/api/appconfig" required="true"/>
	  <feature name="http://bondi.omtp.org/api/filesystem" required="true"/>

However there is no mapping to the [Widget
interface](http://www.w3.org/TR/widgets-apis/). Who decides what gets mapped
and what doesn't? Wouldn't it be simpler and more consistent to just map
everything?

It does get tricky especially thinking about the possible multiply nested <http://dev.w3.org/2006/waf/widgets/Overview.html#the-param-element>.

Also some punks might overload the `config.xml` with  _openURL_ which would clash.

I understand some elements like the [feature elements](http://dev.w3.org/2006/waf/widgets/Overview.html#feature) and undefined (proprietary) elements like:

	<access network="false" localfs="false" remote_scripts="false"/>
	<billing required="true"/>

..are perhaps only relevant and used by particular runtimes, though shouldn't there be convention and reasoning for why (and why **not**) certain interfaces are exposed in the [widget interface specification](http://www.w3.org/TR/widgets-apis/)?


If the <http://www.w3.org/TR/widgets-apis/#the-preferences-attribute> was
mandatory, which I think it should be since many widgets I've come across rely
on **setPreferenceForKey** and **preferenceForKey** conventions, wouldn't it be
sensible to put the interfaces all into this **preference** [Web
storage](http://www.w3.org/TR/webstorage/) mechanism?

Consider read-only keys like:

	widget.getItem("name")
	widget.getItem("nameShort")
	widget.getItem("authorEmail")
	widget.getItem("licencseHref")

Though perhaps ideally when you did a `widget.getItem`, you received the JSON
representation of the XML fragment. Though I'm not entirely sure if there is a
standard way to map XML onto JSON. You might as well canonicalise the whole
`config.xml` as a JSON string bound to **widget.config**. There, simple.  Or
`innerXML` if a JSON translation isn't possible.

Btw the Widget interface as it stands are all readonly except for
[preferences](http://www.w3.org/TR/widgets-apis/#the-preferences-attribute) and
[openURL](http://www.w3.org/TR/widgets-apis/#the-openurl-method).

# widthxheight

It's unclear to me if
[width](http://www.w3.org/TR/widgets-apis/#the-width-attributes) and
[height](http://www.w3.org/TR/widgets-apis/#the-height-attribute) map to the
`config.xml` or the real actual viewport size. Surely one can defer to
`window.screen.width` and `window.screen.height` instead? I know it says
`screen`, but just imagine it says `viewport`?

# My final proposal Widget interface proposal after thinking about it for two hours


	interface Widget {
		readonly attribute DOMString     config; // innerXML or rather JSON representation of configuration document
		readonly attribute Storage       preferences; // key value
		void openURL(in DOMString iri);
	};


