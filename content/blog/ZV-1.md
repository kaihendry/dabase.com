---
title: Sony ZV-1 notes from Singapore
date: 2020-07-16T16:44:25+08:00
description: Upgraded from a G7X mk3 to the Sony ZV-1 for my Youtubing ambitions
---

**tl;dr if you are an image quality nazi, consider this. If you value convenience, get an iPhone 12**

From Cathay Photo on the 14th of July 2020 I upgraded from my [Canon G7X mkiii](https://sg.carousell.com/p/canon-g7x-mark-iii-%E2%80%94-can-be-used-as-a-high-quality-webcam-1014586590/)

1. Sony ZV-1 SGD999
	* Free: 64GB card
2. Purchase with Purchase: Sony VCT-SGR-1 SGD97


Prices quoted above are GST inclusive and valid till 2 August 2020.
Warranty is 15 months upon online registration and non-transferable.

# Memory card

<img src="https://s.natalian.org/2020-07-16/zv-1-memory.jpeg">

This memory card include the bundle is quite astonishing really. It's much faster than the Sandisk Extreme (150 MB/s) to import data.

I think the key difference is the **SDXC mark II** moniker.

# Focus

This is the key difference over the Canon G7X mk III for me. The focus speed on this Sony is astonishing.

I'm still an owner of a Panasonic GH5, so it's double impressive!

# Support issues

I don't know who to turn to for Sony support. Cathay are not very helpful. There isn't any Reddit channels. Quite a few Youtubers have covered the ZV-1, but I feel daft for asking questions in their comments.

## Unable to record at 30fps 4K

<img src="https://s.natalian.org/2020-07-17/25p.jpeg" alt="25p options on PAL">

Solution: [Switch to NTSC from PAL](https://helpguide.sony.net/dc/1910/v1/en/contents/TP0002847077.html?search=NTSC)

Oddly this requires a reformat ...

## Directory structure

On a freshly formatted disk there is already a ton of files:

	.
	├── AVF_INFO
	│   ├── AVIN0001.BNP
	│   ├── AVIN0001.INP
	│   ├── AVIN0001.INT
	│   └── PRV00001.BIN
	└── PRIVATE
		├── AVCHD
		│   └── BDMV
		│       ├── CLIPINF
		│       ├── INDEX.BDM
		│       ├── MOVIEOBJ.BDM
		│       ├── PLAYLIST
		│       └── STREAM
		├── M4ROOT
		│   ├── CLIP
		│   ├── GENERAL
		│   ├── MEDIAPRO.XML
		│   ├── STATUS.BIN
		│   ├── SUB
		│   └── THMBNL
		└── SONY
			└── SONYCARD.IND

Videos bizarrely end up in PRIVATE/M4ROOT which [MacOS
Photos](https://www.apple.com/sg/macos/photos/) doesn't see for import.
[FCPX](https://www.apple.com/sg/final-cut-pro/) is however able to find the
videos to import.

Here is a sample structure https://s.natalian.org/2020-07-16/zv-1.txt which interestingly includes the model serial number in the XML.

## 4k recording cuts out

I think it just cuts when it's over heating around the 10 minute mark. The
problem is doesn't tell you it's stopped recording very clearly. :(

Is there a workaround??

## Menu volume / shutter sound is annoying

Not sure how to turn this off!

Can't find a "Silent Shooting" option. Ah, it's under **Audio Signals**!

{{< youtube r3G0-V20uH0 >}}

## Wide angle

As many have complained a **wide lens adaptor** is sorely needed. I'm not sure where to
source the Len adaptor mentioned in https://youtu.be/qY8yVDZV70s in Singapore.
Cathay are of no help. [This lens adaptor doesn't ship to Singapore](https://www.amazon.co.uk/gp/product/B07ZVJ6TDF/ref=as_li_tl?ie=UTF8&tag=christophelan-21&camp=1634&creative=6738&linkCode=as2&creativeASIN=B07ZVJ6TDF&linkId=7ea384a637d8ca5c2e91f204dec1dbfb).

So [I am asking around in Singapore](https://www.clubsnap.com/threads/sony-zv-1-wide-lens-adaptor-wanted.1789396/)

## Turning on

Some times I put it in my pocket and the camera turns on and lens extends. Why? I am not sure what triggered it!

## Shooting grip

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/-NcNqtOFIgs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

I **cannot recommend the VCT-SGR-1 shooting grip** since it's unreliable. I do
not understand ...  sometimes when plugged in, it simply does not work!!!

## Videos have a JPG thumbnail when importing

Not sure how to turn this feature off.

## Poor mobile connectivity

<img src="https://s.natalian.org/2020-07-17/pairing.jpeg" alt="Failed to pair the Sony ZV-1 over Bluetooth">

I'm unable to control the camera with Imaging Edge Mobile, the Sony IOS camera app.

I'm also unable to get it join my wireless LAN to avoid the inconvenient direct WiFi steps.

## Can't fit the Peak Design Cuff

<img src="https://s.natalian.org/2020-08-25/zv1-cuff.jpeg" alt="Peak design has smaller cuffs as well as large">

Peak design sent me [smaller cuffs for free](https://twitter.com/kaihendry/status/1298220112185499648). Whoa, what incredible customer service.

## Digital stabilisation

Sadly not nearly as good as the Canon G7X out the box. **Active stabilization** mode crops like crazy!

## No time lapse movie option

You can only take a series of photos and join them later into a movie on your computer:

<https://support.d-imaging.sony.co.jp/support/tutorial/dc/zv-1/en/08.php>

The UI is just terrible in this regard.
