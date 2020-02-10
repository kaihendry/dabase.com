In Singapore, the <abbr title="National Environment Agency">NEA</abbr>
publishes data about **air quality** in a machine readable format aka an "API".

Currently they publish it with a key, For example:

	http://www.nea.gov.sg/api/WebAPI?dataset=psi_update&keyref=${NEAAUTHORIZATION-KEY}

The actual current [XML
payload](http://s.natalian.org/2015-10-18/NEA_PSI_XML_API_EXAMPLE.txt) is
worthy of a blog in itself. It has **numerous issues**.

Firstly, why do they need a key? You can control access to an API by
**Access-Control-Allow-Origin**, maybe the referrer or IP if access is a
problem.

And why would access be a problem? The load on an API is far lower than a
Website since the API is a fraction of the size & far more efficient.

So please correct me if I am wrong, the current access the NEA PSI API is limited by:

* Key registration process
* Limits the API use to server side only, which is far more complex to deploy to than a [simple static JS app](https://github.com/kaihendry/myhaze)

These are artificial barriers to entry that should be removed to streamline a
"smart nation" that's capitalising on information. Please **do NOT use API keys**.

UPDATE: The workaround is something [like this](https://github.com/kaihendry/jbsg/blob/master/nsg.php) which took me longer to code than I would like to admit. :(
