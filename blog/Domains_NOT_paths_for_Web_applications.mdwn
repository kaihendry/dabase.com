I was very dissapointed to see <http://news.bbc.co.uk> start to redirect to
<http://www.bbc.co.uk/news/> earlier this year.

Besides the longer URL with the deprecated www. prefix, hosting Web
applications on paths is dumb. Why?

There are several practical reasons why hosting by domain is better.

It forces developers to think exclusively for one particular application. So
one can focus on designing URLs for it, without worrying some other URL
dispatcher getting in the way.

The site is just an A record if you want to transfer the application to another
host.  You **can't do this with paths sanely**.

It is usually much easier to setup a local running application with
`VirtualDocumentRoot` and a simple change in `/etc/hosts`, if it's designed to
sit on a domain.

It's easier to scale with domains hosted by domain. With an application hosted
on an domain it's straight forward to start mirroring it and utilising
[geoDNS](http://serverfault.com/questions/30567/geo-dns-providers/42889#42889).

It's a more resilient model. Again by using DNS you can configure backup hosts
running your application.
