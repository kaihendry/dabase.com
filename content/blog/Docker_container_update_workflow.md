I setup [Greptweet](https://github.com/kaihendry/greptweet) a few months ago on
a <abbr title="Digital Ocean">DO</abbr> "Droplet" aka <abbr title="Virtual
Private Server">VPS</abbr> in London running [CoreOS](https://coreos.com/)
stable.

Over that period of time, there was at least one PHP update (as per bloody usual) and a [cache bugfix](https://github.com/kaihendry/greptweet/issues/52) <a href=https://twitter.com/kaihendry/status/539308862461865984>(backstory)</a> I need to rollout.

# How do I test the fix?

This fix was to do with the [nginx.conf](https://github.com/kaihendry/greptweet/blob/master/nginx.conf), not the actual code, so it was easy to build the docker image locally, e.g. `sudo docker build -t g5 .` & `sudo docker run -v /srv/www/greptweet.com:/srv/http/u -p 80:80 -ti g5`

NEED A SOLUTION: What I found difficult to do however, is test any local code
changes, like a Bootstrap update. Since the
[Dockerfile](https://github.com/kaihendry/greptweet/blob/master/Dockerfile)
checks the source code out from git, but I need to **test my working changes**.

UPDATE: Neerav Kumar from [DockerSG](https://www.facebook.com/groups/dockersg/) suggested I [use ADD instead of git clone in my Dockerfile](https://github.com/kaihendry/greptweet/commit/18cdf60aaeb4bbb8a76aa4d22629f6ff7f527a7b).

# How did I deploy the fix

On my CoreOS droplet, I built a new image (from scratch) with `docker build
--no-cache -t greptweet .` from a git checkout. I wasn't too sure what was
going to happen, since there was already an image called "greptweet" there and
in fact running.  The new build seemed to simply replace that currently running
build and all I then needed to do was `sudo systemctl restart
greptweet.service` for the [systemd service
file](https://github.com/kaihendry/greptweet/blob/master/greptweet.service) to
serve it.

NEED A SOLUTION: Er, so what happened to the old build of Greptweet? Seems to
have disappeared by the build that replaced it. What happens if I want to
downgrade, just `git checkout oldversion` and Docker build from there??

UPDATE: People suggested tags and [updating the service
file](https://privatepaste.com/efca12aa5f) but I think git checking out and
older version is a better approach for me.

# Gotchas

WTH: Initially I built like so `docker build -t greptweet .` and noticed no
changes on restart and an old version number on the
[app](http://greptweet.com/). It seems that Docker caching can't seem to tell
when a step is actually likely to change (new changes in git) and invalidate
it.

UPDATE: I'm told Docker can sense changes with ADD but not the RUN. So hopefully [the change](https://github.com/kaihendry/greptweet/commit/18cdf60aaeb4bbb8a76aa4d22629f6ff7f527a7b) will make the builds better.

Had some issues with [nginx configuration syntax
error](https://twitter.com/kaihendry/status/540428915911557120), independent of
Docker.
