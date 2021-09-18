---
title: Kids Authenticate to Microsoft
date: 2021-09-18T17:24:16+08:00
description: LAN gaming is corrupt on Minecraft
---

LAN gaming with my kids upon Minecraft has been like a death by a thousand
cuts.

Despite running my own Bedrock server `docker run -d -it --name bds-survival -e EULA=TRUE -e GAMEMODE=survival -p 19132:19132/udp itzg/minecraft-bedrock-server`, each client now **needs to sign into a Microsoft account** in order to play.

{{< tweet 1438797861836132354 >}}

You can't share a Microsoft account, you'll get a "Cannot join world. The
account you are signed in to is currently playing in this world on a different
device."

<img src="https://s.natalian.org/2021-09-18/cannot.jpeg" alt="Cannot join world">

It's extra painful when each client has further requirements:

* <abbr title="PlayStation 4">PS4</abbr> client requires an account and a **PlayStation Plus** subscription AND me to purchase Minecraft (again)
* Our other client is the iPad, which of course requires an Apple account and a [purchase of Minecraft](https://apps.apple.com/us/app/minecraft/id479516143) (again) which is shared via my Apple family account from my account to my son's Apple ID

I wonder if it's the same nonsense on the Minecraft Java client (which I've
also paid for). Though I doubt we realistically switch since I don't know how
to replace the convenient PS4 attached to the TV nor the Ipad.

It feels a little insane to create an Apple ID for my five year old, let alone
a Microsoft account.

# Family permissions

<img src="https://s.natalian.org/2021-09-18/xbox-family.png">

Setting up a Microsoft account for a child is an ordeal. It get super complex
because you need to add your childs account to your family and then once they
are added you need to find the right permission to allow them to play a LAN
game of Minecraft.

Essentially by allowing them to play local games, AFAICT you are enabling to
play **any game**, **online**, which as a parent, I really do not want.
