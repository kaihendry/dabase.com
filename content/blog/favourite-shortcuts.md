---
title: Archlinux / MacOS Shortcuts
date: 2022-10-08T19:30:25+08:00
description: My muscle memory shortcuts
---

<img src="https://s.natalian.org/2022-10-09/thinkpad.png" alt="xmodmap keyboard bindings">

The "Super" key aka Super_L (mod4) is **left of the space bar**, if you find
Alt_L (mod1) & Super_L (mod4) reversed you need to fix it like so:

    setxkbmap -option altwin:swap_alt_win

You can check the bind using `xev`.

A "Mac" style keyboard like these "MX Keys for Mac" are nice, big and don't have the Function key confusing matters:

<img src="https://s.natalian.org/2022-10-08/mac.png" alt="MX keys for Mac on Arch">

# Terminal

I like the cross-platform Terminal https://alacritty.org though since it can
freeze on my Xorg Arch machine whilst idle 🤷, I also use
https://st.suckless.org which is more reliable for my on Xorg.

## Copying text on the Terminal

    selection:
      save_to_clipboard: true

Over the years I've used computers, I'm most familiar with copy
on selection when using a terminal.

I don't use vi bindings for visual selection or tmux etc.

## Pasting on the terminal

Historically it's a middle mouse click for pasting, though I'm
more familiar with:

    mod4 + v

In alacritty it needs the configuration:

    key_bindings:
      - { key: V, mods: Super, action: Paste }

## Scrolling the terminal

I'm used to using the mouse and ideally searching with <kbd>Ctrl+f</kbd>.

    key_bindings:
      - { key: F, mods: Control, action: SearchForward }

## Links on the Terminal

Alacritty's default behaviour of underling links on hover and clicking them is
best for me.

# Browser

## Copying text

Here I do not want copy on selection, but this happens automatically on a Linux machine. To prevent unwanted overwriting of my clipboard, I rely on a clipboard manager.

- https://github.com/cdown/clipmenu on Archlinux
- https://www.alfredapp.com/help/features/clipboard/ on MacOS

## Pasting text on a browser

    mod4 + v - works in google-chrome-stable
