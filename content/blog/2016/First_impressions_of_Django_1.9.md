---
date: 2016-03-04 19:12:53 +0800
---

	~$ python2 -c "import django; print(django.get_version())"
	1.9.2

Using python2.

* [tutorial is good](https://docs.djangoproject.com/en/1.9/intro/tutorial01/) - I think
* This app within a project, but an app can be in many projects seems a bit wierd. Prefer just "app" (KISS).
* Where's the `.gitignore` file and the `Dockerfile`?
* sqlite seems fine, so at what point is it worth taking the leap to postgres? Really not looking forward to devops headaches here
* manage.py is good. `manage.py runserver` auto-reloading is great. So is the debug. So is the shell (didn't expect that!).
* admin interface is great, except for that wierd `---------` default action. I hope I can fine tune it though.
* change history in the admin interface is a very welcome surprise. But sadly if the change didn't happen in the admin interface it's not tracked. :(
* the [double underscore thing](https://docs.djangoproject.com/en/1.9/intro/tutorial02/) was a bit jarring.
* following the tutorial, i.e. copying and pasting into vim was a gigantic PITA. there must be a better way. Remembering to `:set paste`... arghghghgh
* the [vim django tips on the wiki](https://code.djangoproject.com/wiki/UsingVimWithDjango) are good. ditched [python-mode](https://twitter.com/kaihendry/status/705696319789096960) for [syntastic](https://github.com/scrooloose/syntastic) and I'm happier (for some minutes)
* Noticed that Django community can't seem to decide on a project layout

How do you figure out that `reverse` comes from `from django.core.urlresolvers import reverse`? Need something like goimports!

* the [power of the admin page](https://docs.djangoproject.com/en/1.9/intro/tutorial07/) make me think I should be using that as a basis of my customer facing forms.
* the section on [reusable apps](https://docs.djangoproject.com/en/1.9/intro/reusable-apps/) was bit beyond remit of a tutorial I feel. Are all these [Github search results](https://github.com/search?q=django&ref=simplesearch&type=Repositories&utf8=%E2%9C%93) sort of apps I can drop into my project?

* struggling to understand how `models.py` maps to JSON schema
