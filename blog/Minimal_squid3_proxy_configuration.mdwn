Setting up a Web proxy might be needed to evade censorship and [geo
restrictions](http://dabase.com/e/04052/). I'm using
[squid3](http://www.squid-cache.org/) packaged in either Debian or Ubuntu.

Out of my frustration of dealing with the crazy bloated default squid3
configuration, I've spent a good hour or two reducing it to the ABSOLUTELY
minimal configuration possible.

# Install squid3

	sudo apt-get install squid3

# /etc/squid3/squid.conf

	auth_param digest program /usr/lib/squid3/digest_pw_auth -c /etc/squid3/passwords
	auth_param digest realm proxy
	acl authenticated proxy_auth REQUIRED
	http_access allow authenticated
	http_port 3128

On Ubuntu 14.04, digest_pw_auth has been renamed to digest_file_auth, i.e. use:

	auth_param digest program /usr/lib/squid3/digest_file_auth -c /etc/squid3/passwords

These 5 lines, sure beats the INSANE 5539 <abbr title="Lines of Code">LOC</abbr> of `squid.conf.dpkg-dist` and I found a [bug in the process](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=681122)!

# Setting up a user

	htdigest -c /etc/squid3/passwords proxy user

Drop the `-c` for your subsequent users.

`tail -f /var/log/squid3/access.log` to see who is using your proxy.
