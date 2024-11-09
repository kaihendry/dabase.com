---
date: 2009-09-29 11:58:34 +0100
---

# Why would you want to sign a widget?

For the same reasons why you would sign a document or an email if you're
[GNUPG](http://en.wikipedia.org/wiki/Gnupg) savvy. To say it comes from **you**
and as an added bonus to show that the files (contents) have their integrity
intact (i.e. they have not been tampered with!).

The [[bigger_idea|blog/JIL_versus_BONDI_on_Security]] with signatures is that
they will be used to control trust in the use of [device
APIs](http://www.w3.org/2009/dap/).

If you want your widget to be distributed by a major operator, you need to have
them sign your widget in order to approve of it. If later the operator has
found your Widget to be malicious, widget signatures can be revoked using [OCSP
verification](http://en.wikipedia.org/wiki/OCSP).

# How does it work

1. You have a Widget package with a list of files
2. Each file gets hashed, e.g. `sha256sum *`
3. Those filenames and hashes are put in a manifest and again all hashed, then signed with a private key

For some godforsaken reason we are using [XML
Signatures](http://www.w3.org/TR/widgets-digsig), however I suggest you read
Java's [jarsigner man
page](http://linux.die.net/man/1/jarsigner-java-1.6.0-openjdk). Ultimately
we're doing everything that `jarsigner` is doing, but using very complex and
fragile W3C XML suite of technologies. Whoops.

# Signing a widget with [xmlsec1](http://www.aleksey.com/xmlsec/)

If you prefer a **user interface** to signing a widget you should instead look
at the [LiMo supported BONDI SDK](http://bondisdk.limofoundation.org/) and
<http://bondisdk.limofoundation.org/docs/Signing_a_Web_Widget/>, instead of the
following textual intercourse:

	hendry@x61 ~$ cd /tmp
	hendry@x61 tmp$ git clone git://git.webvm.net/wgtqa
	Initialized empty Git repository in /tmp/wgtqa/.git/
	remote: Counting objects: 2629, done.
	remote: Compressing objects: 100% (2056/2056), done.
	remote: Total 2629 (delta 1539), reused 586 (delta 235)
	Receiving objects: 100% (2629/2629), 694.33 KiB | 220 KiB/s, done.
	Resolving deltas: 100% (1539/1539), done.
	hendry@x61 tmp$ cd wgtqa/xmldsig/
	hendry@x61 xmldsig$ ls
	dsakey.p12  keys      rsakey.p12           sign-widget.sh       validate-widget-signature.sh
	helloworld  Makefile  signing-template.sh  strip-signatures.sh  xmldsig.rnc
	hendry@x61 xmldsig$ make sign
	rm -f helloworld.wgt
	rm -f example*
	zip -jr helloworld.wgt helloworld/
	  adding: index.html (deflated 12%)
	  adding: config.xml (deflated 15%)
	./sign-widget.sh --pkcs12 /tmp/wgtqa/xmldsig/rsakey.p12 --pwd secret helloworld.wgt
	Key type rsa
	Archive:  helloworld.wgt
	  inflating: /tmp/.6129/helloworld/index.html
	  inflating: /tmp/.6129/helloworld/config.xml
	Do you wish to add author-signature.xml?y
	Do you wish to add signature1.xml?y
	Do you wish to add signature2.xml?n
	  adding: index.html (deflated 12%)
	  adding: author-signature.xml (deflated 50%)
	  adding: signature1.xml (deflated 52%)
	  adding: config.xml (deflated 15%)
	Signed /tmp/wgtqa/xmldsig/helloworld.wgt
	hendry@x61 xmldsig

For purposes of a demonstration I've signed the widget twice, once as an
author `author-signature.xml` and once as a distributor `signature1.xml`, using
the same
[rsakey.p12](http://git.webvm.net/?p=wgtqa;a=blob;f=xmldsig/rsakey.p12).

Typically you would only sign it once in the capacity of just an author or just
a distributor, with your own key. To generate your own self-signed key look at the
**example.p12** target in the
[Makefile](http://git.webvm.net/?p=wgtqa;a=blob;f=xmldsig/Makefile).

# Verifying or validating a widget

Since we are using test self-signed keys and not chaining to a root, we are
strictly speaking not verifying a widget, we are validating its signatures
instead.

If you run `make validate` you'll should see something like:

	./validate-widget-signature.sh --pkcs12 /tmp/wgtqa/xmldsig/rsakey.p12 --pwd secret helloworld.wgt
	Archive:  helloworld.wgt
	  inflating: /tmp/.13485/index.html
	  inflating: /tmp/.13485/author-signature.xml
	  inflating: /tmp/.13485/signature1.xml
	  inflating: /tmp/.13485/config.xml
	./author-signature.xml
	Signature method RSA
	if xmlsec1 verify --pkcs12 /tmp/wgtqa/xmldsig/rsakey.p12 --pwd secret ./author-signature.xml
	func=xmlSecOpenSSLX509StoreVerify:file=x509vfy.c:line=360:obj=x509-store:subj=X509_verify_cert:error=4:crypto library function failed:subj=/C=GB/ST=Surrey/L=Guildford/CN=test.webvm.net;err=18;msg=self signed certificate
	func=xmlSecOpenSSLX509StoreVerify:file=x509vfy.c:line=408:obj=x509-store:subj=unknown:error=71:certificate verification failed:err=18;msg=self signed certificate
	OK
	SignedInfo References (ok/all): 3/3
	Manifests References (ok/all): 0/0
	VALID SIGNATURE: ./author-signature.xml
	dsp:Identifier
	9f53f8e6-acf0-11de-aa47-0016d3ccf4f1

	./signature1.xml
	Signature method RSA
	if xmlsec1 verify --pkcs12 /tmp/wgtqa/xmldsig/rsakey.p12 --pwd secret ./signature1.xml
	func=xmlSecOpenSSLX509StoreVerify:file=x509vfy.c:line=360:obj=x509-store:subj=X509_verify_cert:error=4:crypto library function failed:subj=/C=GB/ST=Surrey/L=Guildford/CN=test.webvm.net;err=18;msg=self signed certificate
	func=xmlSecOpenSSLX509StoreVerify:file=x509vfy.c:line=408:obj=x509-store:subj=unknown:error=71:certificate verification failed:err=18;msg=self signed certificate
	OK
	SignedInfo References (ok/all): 4/4
	Manifests References (ok/all): 0/0
	VALID SIGNATURE: ./signature1.xml
	dsp:Identifier
	a129383e-acf0-11de-b067-0016d3ccf4f1

<http://git.webvm.net/?p=wgtqa;a=blob;f=xmldsig/validate-widget-signature.sh>
validates the widget in one of two ways. It can try validate the
**SignatureValue** using a key you provide, e.g. `--pkcs12
/tmp/wgtqa/xmldsig/rsakey.p12` in this case.

Or it can try extract the public key from the X509Certificate which can get
embedded within the signature.

So in practice a widget verification would be:

1. Extracting out the public key from the Keyinfo-X509Data-X509Certificate part
2. Checking the hashed widget contents against each referenced resources (SignedInfo)
3. Canonicalising that SignedInfo and then using that public key to check the SignatureValue
4. Then **verifying** the key is correctly chained up to a root certificate you trust

In fact I have a **validation** Web service that does the first 3 steps at <http://test.webvm.net/>

# Wait, there's more

What new element <http://www.w3.org/TR/widgets-digsig> introduces to XML
digital signature, is the [SignatureProperty
identifier](http://www.w3.org/TR/widgets-digsig/#identifier-signature-property)
which lies typically inside a `<Object Id="prop">` element. This has to be
unique and in my scripts I simply call a [uuid generator](http://en.wikipedia.org/wiki/Uuid).

So that's basically it. A widget can contain a single author signature and many
several distributor signatures. The signatures are generated the same way with
a:

1. SignedInfo section which is the manifest, filenames and hashes
2. KeyInfo - any details of the key
3. Object bit, for identifying the signature itself (btw this gets hashed too in the SignedInfo as `URI="#prop"`!)

I've modified a [RelaxNG schema for Widget digital
signatures](http://git.webvm.net/?p=wgtqa;a=blob;f=xmldsig/xmldsig.rnc), so you
too can check the signature is correctly structured.

# How do I check my widget runtime (WRT) supports signatures?

The [spec](http://www.w3.org/TR/widgets-digsig/#signature-verification)
stipulates that you must be **notified** if your widget is signed, self-signed
or unsigned, on a widget runtime (WRT) claiming to support signatures.

So you could run these
[tests](http://dev.w3.org/2006/waf/widgets-digsig/tests/test-suite-unstable.xml)
from the [Widgets 1.0: Test Suite for Digital
Signature](http://dev.w3.org/2006/waf/widgets-digsig/tests/), to see how well your WRT performs.

If you widget runtime fails a test, you should report the bug! Thank you!
