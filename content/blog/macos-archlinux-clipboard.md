---
title: Archlinux / MacOS clipboard bindings
date: 2022-10-08T19:30:25+08:00
description: My muscle memory shortcuts that wfm between MacOS & Archlinux
---

<img src="https://s.natalian.org/2022-10-09/thinkpad.png" alt="xmodmap keyboard bindings">

The "Super" key aka [MacOS command
key](https://en.wikipedia.org/wiki/Command_key) aka Super_L (mod4) is **left of
the space bar**, if you find Alt_L (mod1) & Super_L (mod4) reversed (Windows
keyboard).  To join my world you need to transpose the two keys:

	setxkbmap -option altwin:swap_alt_win

You can check the bind using `xev` or `screenkey`.

A "Mac" style keyboard like these "MX Keys for Mac" are nice, big and don't
have the Function key confusing matters:

<img src="https://s.natalian.org/2022-10-08/mac.png" alt="MX keys for Mac on Arch">

# Terminal

I like the cross-platform Terminal https://alacritty.org though since it can
freeze on my Xorg Arch machine whilst idle 🤷, I also use
https://st.suckless.org which is more reliable for me on Xorg.

## Copying text on the Terminal

    selection:
      save_to_clipboard: true

Over the years I've used computers, I'm most familiar with copy on selection
when using a terminal and using [one
clipboard](https://st.suckless.org/patches/clipboard/) instead of [Fredesktop's
maddening PRIMARY, SECONDARY, and
CLIPBOARD](https://specifications.freedesktop.org/clipboards-spec/clipboards-latest.txt).

I don't use vi bindings for visual selection or tmux etc.

## Pasting on the terminal

Historically it's a middle mouse click for pasting, though I'm now more
familiar with:

    mod4 + v

If you use alacritty on Arch it needs the configuration:

    key_bindings:
      - { key: V, mods: Super, action: Paste }

In <abbr title="Simple Terminal">st</abbr> it is:

	{ Mod4Mask,             XK_v,           clippaste,      {.i =  0} },

# Browser

## Copying text

Here I do not expect the Terminal's copy on selection behaviour. I rely on
`mod4 + c` to copy text. It works in Archlinux google-chrome-stable and it works on MacOS. 👍

## Pasting text on a browser

    mod4 + v - works in google-chrome-stable on the URL bar

And it matches the behaviour of my terminal.

However on Archlinux I have to remember for general pasting to switch to Ctrl+v 🤦

# Clipboard manager

This is a huge piece of mind for me. On Linux it's long been the case if you
**kill a window** with your text selection, you might lose your selection. A
clipboard manager is hence a necessity for me.

- https://github.com/cdown/clipmenu on Archlinux
- https://www.alfredapp.com/help/features/clipboard/ or the slower [maccy](https://formulae.brew.sh/cask/maccy) on MacOS

They are bound the same keys, Shift+Mod4+v on Arch and Mac! On Arch I wire this
up in [dwm](https://dwm.suckless.org/):

	{ MODKEY|ShiftMask,             XK_v, spawn,               {.v = clipcmd } },

# vim

Tbh I do not integrate vim with my clipboard, it's too much of a hassle.

# Conclusion of compromise

My compromise thanks to MacOS usage is to use the Mod4 modifier to consistently
copy and paste. This is especially important as my workflow is to use Arch and
MacoS with a KVM like https://github.com/debauchee/barrier

I don't have any "rich" clipboards with formatted text or images between the
two platforms.

My workflow between Arch/MacOS is not perfect and it's still confusing for most
other common shortcuts like focusing the URL bar (Ctrl+l on Arch, Mod4+l on
Mac) or using the command palette between the two operating systems
(Ctrl+Shift+p on Arch, Mod4+Shift+p on Mac).

Lastly the **Function key** on Thinkpads and Apple hardware wastes precious
modifier real estate.  My workaround is using an external keyboard **without a
Function button**. 
