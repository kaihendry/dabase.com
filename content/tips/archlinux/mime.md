---
date: 2021-07-01
title: Setting the default browser
description: How to setup terminal mime association so that xdg-open URL opens the right browser profile
---

{{< youtube IiafBlweCbs >}}

	$ xdg-mime query default x-scheme-handler/http
	firefox.desktop
	$ xdg-settings get default-web-browser
	firefox.desktop
	$ xdg-open https://example.com

Will open Firefox of course

You can create your own .desktop files like so:

	$ cat ~/.local/share/applications/firefox-personal.desktop
	[Desktop Entry]
	Version=1.0
	Name=Firefox
	GenericName=Web Browser
	Exec=/usr/lib/firefox/firefox -P hendry %u
	Icon=firefox
	Terminal=false
	X-MultipleArgs=false
	Type=Application
	MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;application/x-xpinstall;
	StartupNotify=true
	StartupWMClass=firefox
	Categories=Network;WebBrowser;

My profile name is `hendry`, though it's not clear this is the name from Firefox's `about:support`. You have to parse this out of Profile Directory's [SALT](https://www-archive.mozilla.org/start/1.5/faq/profile.html). In Chrome you can figure out the Profile directory from `chrome://version/`.

I'm unsure of the .desktop format (like what is the difference between %u and %U?), though it can be linted like so `desktop-file-validate ~/.local/share/applications/firefox-personal.desktop`

You might also need to run `update-desktop-database ~/.local/share/applications`

Set it like so:

	$ xdg-settings set default-web-browser firefox-personal.desktop

Ultimately your system's application associations are stored in `~/.config/mimeapps.list`

	$ xdg-settings set default-web-browser firefox-personal.desktop
	$ XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query default text/html
	Checking /home/hendry/.config/mimeapps.list
	firefox-personal.desktop

Bizarrely there doesn't seem to be a way to easily track down the location of `firefox-personal.desktop`.

I have not figured a way to easily switch profiles on google-chrome-stable yet with `--user-data-dir`. I [asked in the Google Chrome forum](https://support.google.com/chrome/thread/115710399/how-do-i-choose-a-specific-profile-from-the-cli?hl=en). Perhaps I should file a bug next!

# More info

* https://wiki.archlinux.org/title/desktop_entries
* https://www.reddit.com/r/archlinux/comments/obd301/xdgopen_url_choose_browser_profile/
* [Mack Criswell on setting default applications video](https://www.youtube.com/watch?v=VOR1sZ58HzY)
