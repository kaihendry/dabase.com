Part 2 in the series, please see the [[first_part_of_the_JIL_BONDI_comparison|JIL_versus_BONDI]].

Widgets need to be signed, because in many cases they take advantage of new
experimental Device APIs that must be authorised (or checked over, like a MOT),
else they might harm your privacy and security. You should not use a
potentially harmful service unless you know **who** accounts for it, so you
have some sort of recourse if things go bad. If Widgets go bad, the idea is
that the signature can be revoked and the harmful widget can be disabled.

## JIL

Assuming [JIL](http://www.jil.org/), has one operator root authority your
widget can be in one of three security domains:

* Unidentified (~not signed)
* Identified (~author signed, though with JIL as the Certificate Authority most likely)
* Operator (~signed and approved explicitly by a JIL operator)

This is documented in section four "API Support Levels" of their JIL Widget
System API Specification - Handset API v1 1 Revision 4.pdf from
<http://www.jil.org/#DOCUMENTS>.

JIL API policy outcomes (security profiles) are actually the same as BONDI's:

* Unrestricted (allowed)
* One shot (prompt everytime the API is used)
* Session (prompt once in the session)
* Blanket (saved preference)
* Disallowed (deny in BONDI)

The difference between JIL and BONDI, is that JIL's "security profiles" are
simply fixed to each handset API under each security domain.

For example, [Geolocation](http://dev.w3.org/geo/api/spec-source.html) or JIL's
version of it **DeviceStateInfo.requestPosistionInfo** is "Allowed" if you are
an "Operator" signed widget.  "Session" if your widget is only author signed
and "Oneshot" if not signed/identified. Now ask yourself if you trust your
operator enough to make decisions whether applications know your location or
not?

JIL's API support levels are too rigid and ultimately makes the
[operator](http://en.wikipedia.org/wiki/Wireless_carrier) have all the power.
This makes the same mistakes as the Java security model does, as we all know
developers have had problems getting their widgets signed by one particular
operator.

## BONDI

BONDI has adopted [Widgets 1.0: Digital
Signatures](http://www.w3.org/TR/widgets-digsig/) and contributed to the
specification
[rnc](http://bondi.omtp.org/1.0/security/xmldsig-core-schema.rnc). The
specification allows for one [author
signature](http://www.w3.org/TR/widgets-digsig/#author-signatures) and several
[distributor
signatures](http://www.w3.org/TR/widgets-digsig/#distributor-signature).
Therefore a BONDI widget can end up in many several arbitrary domains. You could
for example trust a certain distributor or author and certain groupings of
them.

[BONDI's security
model](http://bondi.omtp.org/1.0/security/BONDI_Architecture_and_Security_v1.0.pdf)
can implement the JIL model, however BONDI allows the flexibility to trust
different signers in a [decentralised trust
model](http://en.wikipedia.org/wiki/Web_of_trust). This helps make Widgets work
seamlessly across networks. With BONDI widgets you might begin to explicitly
trust a certain author's signature and if it is not signed by the distributor,
it doesn't matter. You'll be able to finally enjoy a seamless install and
update process, without completely losing trust, verification and API
functionality if a certain distributor is slow or reluctant to sign a new
widget.

Perhaps you're a high security government institution. You can verify and start
using a widget that has had it's entire chain verified potentially with many
several signatures of concerned parties. BONDI's security model extends to
allow this use case, whilst JIL's simpler one does not.

The acronym DAP for the new [W3C DAP
WG](http://www.w3.org/2009/05/DeviceAPICharter), stands for Device APIs and
**Policy**. Again BONDI has pioneered with a [security policy
proposal](http://bondi.omtp.org/1.0/security/bondixml.rnc).

JIL does not have a standard policy format. So for all the stored "Blanket"
decisions an end user has made about his/her security/privacy settings with
certain APIs, these preferences cannot be moved between devices or widget
runtimes like BONDI's compliant widget runtimes can.

BONDI allows the user to have full control of his/her privacy if the user wants
to. You could delegate the decision to a trusted party (your operator) to
decide whether or not an application should know your location or not (like
JIL). However in some cases it's a privacy requirement that **you** alone want
to decide this preference / security decision based on a whole host of factors.
Once your decision has been made, BONDI's security model can record your
particular preferences as a standardised XML policy fragment. And you can take
these security settings around with you and customise them over time.

Unfortunately privacy and security considerations are complex and differ from
person to person and API to API. BONDI's security model can accommodate JIL's
simpler security model, though in the reality you will need BONDI's flexible
fine grained approach to security to accommodate users changing individual
needs.
