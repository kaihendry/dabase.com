---
title: NixOS at first
date: 2023-01-22T09:59:32+08:00
description: First steps with NixOS
toc: true
---

# Day 1

1. unzstd -c nixos-sd-image-22.11.1611.a83ed85c14f-aarch64-linux.img.zst | sudo dd of=/dev/sdb bs=4M
2. After booting the Raspberry Pi 3, there was [no HDMI output](https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi_3)
3. I didn't know, but there is a sshd running by default. Once I dropping in my [pubkeys](https://github.com/kaihendry.keys) into [/root/.ssh/authorized_keys](https://www.reddit.com/r/NixOS/comments/10f3ic2/first_experience_of_nixos/), I was able to login as root

{{< youtube 1HvY1IMIh_M >}}

## Questions

1. Why is there stuff in /nix/store?
2. Why does it use dhcpd and not systemd-networkd?
3. Why is there no /etc/nixos/configuration.nix?

The break though came with [nixos-generate-config](https://youtu.be/1HvY1IMIh_M?t=1609)

# Day 2

Morning:

{{< youtube nJVFiTQjEjg >}}

Afternoon:

{{< youtube w5kiN0vO51g >}}


## Things I want to figure out

1. What is the default? I.e. the final explicit configuration?
1. How do I get zeroconf working? e.g. rpi3.local
1. How do I get nix formatter / linter working in vim?
1. Why is there stuff in /nix/store?
1. Faster local VM going
1. New NixOS, how do you seed your configuration.nix?
1. How do you handle secrets?

## What did I learn

There doesn't seem to be a cli installer. Even Arch has one! My first install failed

> So umount does take multiple arguments, but if you umount two partitions on the same disk there's a race condition that causes it to say the target is busy! Something I've never discovered before helping you on this stream :D

I didn't know you could have /boot on sda3. https://nixos.org/manual/nixos/stable/index.html#sec-installation-manual-summary

GNU parted actually seems kinda ok from a cli perspective.

tmate with [@MatthewCroughan](https://twitter.com/MatthewCroughan) !!

### extra-experimental-features

    [root@vnixos:~]# nix search rnix-lsp
    error: experimental Nix feature 'nix-command' is disabled; use '--extra-experimental-features nix-command' to override

Solution:

    cat .config/nix/nix.conf
    experimental-features = nix-command flakes

### Zeroconf / Bonjour doesn't seem to work

    [root@vnixos:~]# ping t14g3.local
    ping: t14g3.local: System error

    [root@vnixos:~]# ping t14g3.local
    PING t14g3.local (192.168.1.38) 56(84) bytes of data.
    64 bytes from t14g3.local (192.168.1.38): icmp_seq=1 ttl=64 time=0.135
    ms
    64 bytes from t14g3.local (192.168.1.38): icmp_seq=2 ttl=64 time=0.418
    ms
    64 bytes from t14g3.local (192.168.1.38): icmp_seq=3 ttl=64 time=0.301
    ms
    ^C
    --- t14g3.local ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2103ms
    rtt min/avg/max/mdev = 0.135/0.284/0.418/0.116 ms

----
### Different ways of searching

https://search.nixos.org/options doesn't show any options re `system.stateVersion` comment in `configuration.nix`.

    nix-shell -p nixpkgs#alejandra

versus new flake API:

    nix shell nixpkgs#alejandra


### Getting to the source

Or how things work, oh there is a man page:

    man configuration.nix

Tool to explain what the config `nix-shell -p nixos-option` or `manix` does:

    [nix-shell:~]# nixos-option services.avahi.enable

How does `services.smokeping.enable` implemented?

    [nix-shell:~]# nixos-option services.smokeping.enable
    Value:
    true

    Default:
    false

    Type:
    "boolean"

    Example:
    true

    Description:
    {
    text = "Whether to enable smokeping service.";
    }

    Declared by:
    [ "/nix/var/nix/profiles/per-user/root/channels/nixos/nixos/modules/services/networking/smokeping.nix" ]

    Defined by:
    [ "/etc/nixos/configuration.nix" ]

Which corresponds to:

https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/networking/smokeping.nix

(Not sure how you to know the mapping)

### Getting a nix IDE


Try someone else's neovim config:

    nix shell github:kranzes/nix-config#neovim