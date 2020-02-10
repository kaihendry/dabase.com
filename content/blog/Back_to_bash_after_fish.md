<img src=http://fishshell.com/assets/img/Terminal_Logo_CRT_Small.png alt="Fish logo">

I tried the <http://fishshell.com/> instead of bash, mainly because my bash
history is continually truncated despite my efforts to keep every command I've
ever successfully (return code 0) typed!

	x220:~$ wc -l .bash_history
	84 .bash_history
	x220:~$ history | wc -l
	82

The fish shell's [85k SLOC](http://ix.io/dp6) versus bash's [225k](http://ix.io/dp7) was also re-assuring. autotools and cpp did make me cringe however.

So porting my aliases and such from [~/.config/fish/config.fish](https://github.com/kaihendry/dotfiles/blob/master/.config/fish/config.fish) from my [~/.bashrc](https://github.com/kaihendry/dotfiles/blob/master/.bashrc) was a bit of a <abbr title="Pain in the Ass">PITA</abbr> since:

* fish's conditional statements are not POSIX shell compatible <--- insane

Nonetheless I got fish up and running... and **I used fish 2.1 for about a month**.

# So... does shell history work in fish?

Yes, yes it does. fishd provided me the commands I typed in, HOWEVER:

* it logged failed commands, I DO NOT WANT FAILED COMMANDS SAVED
* failed commands could be a password. To remove them I had to 'fish_config' and go to history tab.
* ctrl+r (bash's reverse search) doesn't work. Instead you need to toggle between ctrl+f (autocomplete) and ctrl+p (search)

Tbh I could live with this _fishiness_. Simply because I had a working shell history. Seriously.

# Why I stopped using fish

Consider this code from <http://git.suckless.org/dmenu/tree/dmenu_run>

	dmenu_path | dmenu "$@" | ${SHELL:-"/bin/sh"} &

So I would choose a bash script like [screenshot](https://github.com/kaihendry/dotfiles/blob/master/bin/screenshot), to be run by dmenu, which is then piped to $SHELL. $SHELL being /usr/bin/fish when using fish. Screenshot's shebang `#!/bin/bash` does not apply.

IIUC [variable expansion](http://fishshell.com/docs/current/index.html#expand-variable) in fish is done different causing 99% of shell scripts to fail when run by fish. Nevermind the crazy stderr caret stuff. fish being a non-compatible shell is just a **TOTAL FAIL**.

Furthermore setting up PATH on Linux is just generally insane, probably because
I've (wrongly) setup the PATH mainly in my
[~/.bashrc](https://github.com/kaihendry/dotfiles/blob/master/.bashrc), instead
of `~/.profile` or is it somewhere else? Anyway my PATH was consistency broken in fish too and I never figured 100% why. Perhaps because of its variable expansion anti-feature.

# Back to GNU bash

Tbh, `ctrl+r` aka **(reverse-i-search)** is much better & intuitive than fish's `ctrl+f` & `ctrl+p`.

Now if only I could get my bash history working. I miss `fishd` I guess. Tbh I did like fish's `fish_config` and the way it attempted but [kinda failed to integrate with the browser](https://github.com/fish-shell/fish-shell/issues/342).
