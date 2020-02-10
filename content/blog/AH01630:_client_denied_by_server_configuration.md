---
date: 2012-02-23 13:01:02 +0800
---

After installing [Apache 2.4](http://httpd.apache.org/download.cgi#apache24) in `/usr/local/apache2/`, I struggled to get my
VirtualHost setup going.

After plonking in at `conf/extra/virtual.conf`:

	<VirtualHost 127.0.0.1:80>
	UseCanonicalName    Off
	VirtualDocumentRoot /srv/www/%0
	Options All ExecCGI FollowSymLinks +Includes
	</VirtualHost>

Then enabling `LoadModule vhost_alias_module modules/mod_vhost_alias.so` and restarting the httpd, I kept getting these messages:

	AH01630: client denied by server configuration: /srv/www/webconverger/

Turns out there seems to be a new permission model, whereby this policy:

	<Directory />
		AllowOverride none
		Require all denied
	</Directory>

Stops access to `/srv/www`. To alleviate this, after that "deny all" stanza above you add the exception:

	<Directory "/srv/www">
	Options All
	AllowOverride All
	Require all granted
	</Directory>

Read the [Access Control](http://httpd.apache.org/docs/2.4/upgrading.html#access) bit in the caniocial Apache httpd documentation for more.
