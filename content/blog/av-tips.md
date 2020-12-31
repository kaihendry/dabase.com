---
title: Audio Visual tips for Zoom, OBS, Youtube etc
date: 2020-12-31T09:07:08+08:00
description: Practical tips to improve Internet, Lighting, Sound and Video for online calls and presentations
toc: true
---

**Record yourself** to **benchmark your setup**.

Make recordings, **organise media** into YYYY-MM-DD folders and scrutinise the
A/V quality! You will make mistakes and have learn along the way.

Use `ffprobe` from the <https://ffmpeg.org/> to work out the resolution of your
recording btw. Aim for 16:9 aspect ratio and a minimum of 1920x1080 resolution.

## Network 🔌

Go wired! [Get connected 🎶](https://www.youtube.com/watch?v=k3RzQ1b_c9w)

<a href="https://smokeping2.dabase.com/">
<img title="wireless" src="https://s.natalian.org/2020-12-31/wireless.png" alt="typical GOOD wireless connection">
</a>
<a href="https://smokeping.dabase.com/">
<img title="wired" src="https://s.natalian.org/2020-12-31/wired.png" alt="wired connection">
</a>

Be wary of routes with ☠️PACKET LOSS☠️  [Exhibit A](https://smokeping.dabase.com/?target=Malaysia.TM) [Exhibit B](https://smokeping2.dabase.com/?target=Malaysia.TM) ... only really noticed with [monitoring](https://hub.docker.com/r/linuxserver/smokeping).

Good options to getting **wired** (single USB-C) for Apple <abbr title="Macbook Pros">MBP</abbr>:

- ~100SGD [Anker](https://www.lazada.sg/products/i377938838-s5140908513.html) with my [video review](https://www.youtube.com/watch?v=0D6cqMbeleI)
- ~30SGD [Aliexpress](https://www.aliexpress.com/item/32954358411.html)
- [Flat CAT6](https://www.lazada.sg/catalog/?q=flat+rj45) to get under doors

<img src="https://s.natalian.org/2020-12-31/under.jpeg" alt="Under the door">

## Lighting 💡

Entry level suggestions:

- ⭕ 42SGD [Ring light](https://www.carousell.sg/p/zomei-zm128-led-ring-light-3200k-5500k-camera-photo-dimmable-1001158668/) -- best all-in-one for reducing face shadows
- 41SGD [Panel light](https://www.lazada.sg/products/free-stand-youtube-light-led-panel-mm-240-suitable-for-desktop-youtube-zoom-lighting-i1412992382.html) versus 200+SGD [key lights](https://www.lazada.sg/catalog/?q=elgato+light) - you often need more than one to reduce shadows

5600K colour temperature seems to be a sweet spot.

You _will_ get used to a bright light in your face.

## Audio 🎤

**Avoid wireless**. I love my Air Pod Pros too, but they are not as good as you might think!

- "Condenser microphone" (reduced pick up pattern) - ~100SGD [Audio-Technica AT2005USB Cardioid Dynamic USB/XLR Microphone](https://amzn.to/37YFNVC)
- When using <abbr title="Open Broadcaster Software">OBS</abbr> do experiment with the noise gate / noise filters! They work well.
- Advanced: ~150SGD [Microphone boom](http://www.rode.com/accessories/psa1)
- Advanced: Make a separate recording with for example a lapel microphone ~75SGD and an iPhone

Best **sound treatment** for a room is **soft furnishings**: Curtains, carpet,
pillows, throws ... a bedroom can be pretty good. Hard surfaces suck.

👏 [Clap test](https://rslspeakers.com/cheap-way-test-rooms-acoustics/) 👏

## Video 🎥

- <abbr title="Network Device Interface">NDI</abbr> Virtual Input - [use your iPhone](https://youtu.be/cX8fo74m6nc) at a pinch with some latency
- Super advanced: 1000SGD [Sony ZV-1](https://www.cathayphoto.com.sg/cameras/sony-zv-1-digital-camera) - can tether over USB
- A virtual background isn't a novelty

## Test your setup

1. Record yourself!
2. What could be be better? FOCUS ON AUDIO. Is there something distracting?
3. Go to step 1

Practice makes perfect.

## Really next level stuff

The problem of "making eye contact" is quite difficult to solve if your camera isn't mounted on your screen

* Teleprompter / Glidecam is ~200SGD - you can mount a (small) HDMI output screen with Zoom gallery below it
* Try set you camera a few meters back from your desk, if you have the space

Green screen - less distracting than a virtual background. Pull up and under-the-bed storable indicative prices:

1. 5m x 2m  $189SGD
2. 3m x 2m $249SGD

<p style="background: green">Remember you only need to green screen <strong>your outline/silhouette</strong>, not your back wall!</p>

## Take aways - #priorities

**Record yourself** to **benchmark your setup**.

1. Wired Network
2. Audio
3. Lighting

TODO: Watch some Zoom tutorial videos for [understanding some advanced features like Spotlight](https://www.youtube.com/watch?v=rW3U2Fv2CY8&feature=emb_title) and hand gestures
