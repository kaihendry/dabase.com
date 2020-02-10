---
date: 2016-05-09 15:51:57 +0800
---

<img src=http://s.natalian.org/2016-05-09/local-caddy.png alt="Caddy running in Docker on Archlinux">

Instead of running [Caddy](https://caddyserver.com/) via `go get`, I've opted
on my local machine to use Docker. Why? Because that's how my servers run, so I
thought it would be sensible to reproduce the environment locally on my laptop.

# What is Docker?

I think of Docker as simply a Linux container front end. Like a package manager
like `npm` say. However instead of searching for dependencies, you usually have
the entire self-contained product in a Docker container.

Assuming you have Docker setup, to run a "packaged" Caddy in a container, it can be as simple as running:

	docker run --rm -p 2015:2015 abiosoft/caddy:php

* `--rm` means clean up after exiting (we are just kicking the tyres here)
* `-p 2015:2015` means expose port 2015
* [abiosoft/caddy:php](https://github.com/abiosoft/caddy-docker/) is the name of the "packaged" maintained Docker featuring Caddy

# So why is this cool?

It's cool because we don't have to fiddle with a golang environment or which
binaries we should download and how to setup PHP. It just works!

I don't need to actually know too much about the boring internal stuff. I
supply a config file, some directory and port mappings ... and BOOM ... I'm
away!

Finally & most importantly to me, someone else maintains it &
[abiosoft](https://twitter.com/abiosoft) is doing a good job!

# So how do I integrate this to my system?

Unsurprisingly **linux containers** best run on Linux & I recommend using a
Linux system with [systemd](https://en.wikipedia.org/wiki/Systemd) with Docker.
Most "modern" linux systems do this now. This is what my
`/etc/systemd/system/caddy.service` looks like:

	[Unit]
	Description=Caddy
	After=docker.service
	Requires=docker.service

	[Service]
	TimeoutStartSec=0
	User=hendry
	ExecStartPre=-/usr/bin/docker kill caddy
	ExecStartPre=-/usr/bin/docker rm caddy
	ExecStartPre=-/usr/bin/docker pull abiosoft/caddy:php
	ExecStart=/usr/bin/docker run --name caddy -v /home/hendry/caddy/Caddyfile:/etc/Caddyfile -v /srv/www:/srv/ -v /home/hendry/caddy/caddy-certs:/root/.caddy -p 80:80 -p 443:443 abiosoft/caddy:php
	RestartSec=5
	Restart=always

	[Install]
	WantedBy=multi-user.target

You might be wondering, **why** are there these _pre_ steps to {kill,rm,pull}
Caddy?  It looks really ugly but what we are doing here is checking for updates
and using that update. No more patching! A `restart` is almost all we need to
ensure we are current.

Notice I bind my configuration at `/home/hendry/caddy/Caddyfile` to the
location the container expects that to be in. These little mappings should be
documented in the container's README or in the
[Dockerfile](https://github.com/abiosoft/caddy-docker/blob/master/Dockerfile).

My configuration `/home/hendry/caddy/Caddyfile` looks like:

	natalian:80 {
		tls off
		root natalian
		header / Content-Encoding "gzip"
		log stdout
		errors stdout
	}

	config:80 {
		tls off
		root config
		startup php-fpm
		fastcgi / 127.0.0.1:9000 php
		log stdout
		errors stdout
	}

Since I run Caddy locally on my laptop for development, I don't need Caddy's
awesome **automatic HTTPS** feature.

Notice I use `stdout`, so I can use `journalctl -u caddy -f` to view & most
importantly maintain the logs.

# Hostnames

I manually add the names of my hosts into `/etc/hosts`. **172.17.0.1** in my
case is the IP of the Docker instance. If anyone know how to make this easier,
please let me know.

	172.17.0.1 natalian config

So typically once I edit `~/caddy/Caddyfile` with a new site, I then edit `/etc/hosts` and then `sudo systemctl restart caddy`.

Tip: To have it startup on boot: `sudo systemctl enable caddy`.

# Conclusion

This is my current local laptop configuration, but the production version on
[CoreOS on Digital Ocean](https://m.do.co/c/37b3b1850b32) is almost the same
except the hostnames and the user being **core** instead of _hendry_.
