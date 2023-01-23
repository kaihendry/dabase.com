---
title: NixOS at first
date: 2023-01-22T09:59:32+08:00
description: First steps with NixOS
---


1. unzstd -c nixos-sd-image-22.11.1611.a83ed85c14f-aarch64-linux.img.zst | sudo dd of=/dev/sdb bs=4M
2. After booting the Raspberry Pi 3, there was [no HDMI output](https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi_3)
3. I didn't know, but there is a sshd running by default. Once I dropping in my [pubkeys](https://github.com/kaihendry.keys) into [/root/.ssh/authorized_keys](https://www.reddit.com/r/NixOS/comments/10f3ic2/first_experience_of_nixos/), I was able to login as root

{{< youtube 1HvY1IMIh_M >}}

# Confusion

1. Why is there stuff in /nix/store?
2. Why does it use dhcpd and not systemd-networkd?
3. Why is there no /etc/nixos/configuration.nix?

The break though came with [nixos-generate-config](https://youtu.be/1HvY1IMIh_M?t=1609)

# Day 2

{{< youtube nJVFiTQjEjg >}}

## Things I want to figure out

1. What is the default? I.e. the final explicit configuration?
1. How do I get zeroconf working? e.g. rpi3.local
1. How do I get nix formatter / linter working in vim?
1. Why is there stuff in /nix/store?
1. Faster local VM going
1. New NixOS, how do you seed your configuration.nix?
1. How do you handle secrets?

## What did I learn

There doesn't seem to be a cli installer. Even Arch has one!

I didn't know you could have boot on sda3. https://nixos.org/manual/nixos/stable/index.html#sec-installation-manual-summary

GNU parted actually seems kinda ok from a cli perspective.

tmate!
