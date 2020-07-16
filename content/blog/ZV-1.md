---
title: Sony ZV-1 notes from Singapore
date: 2020-07-16T16:44:25+08:00
---

From Cathay Photo on the 14th of July 2020 I upgraded from my [Canon G7X mkiii](https://sg.carousell.com/p/canon-g7x-mark-iii-%E2%80%94-can-be-used-as-a-high-quality-webcam-1014586590/)

1. Sony ZV-1 SGD999
	* Free: 64GB card
2. Purchase with Purchase: Sony VCT-SGR-1 SGD97


Prices quoted above are GST inclusive and valid till 2 August 2020.
Warranty is 15 months upon online registration and non-transferrable.

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

Solution: Switch to NTSC from PAL

Oddly this requires a reformat

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

Videos bizaarely end up in PRIVATE/M4ROOT which [MacOS
Photos](https://www.apple.com/sg/macos/photos/) doesn't see for import.
[FCPX](https://www.apple.com/sg/final-cut-pro/) is however able to find the
videos to import.

Here is a sample structure https://s.natalian.org/2020-07-16/zv-1.txt which interestingly includes the model serial number in the XML.

## 4k recording cuts out

I think it just cuts when it's over heating around the 10 minute mark. The problem is doesn't tell you
it's stopped recording very clearly. :(

## Menu volume / shutter sound is annoying

Not sure how to turn this off!

## Wide angle

As many have complained a lens adaptor is sorely needed. I'm not sure where to
source the Len adaptor mentioned in https://youtu.be/qY8yVDZV70s in Singapore.
Cathay are of no help. [This lens adaptor doesn't ship to Singapore](https://www.amazon.co.uk/gp/product/B07ZVJ6TDF/ref=as_li_tl?ie=UTF8&tag=christophelan-21&camp=1634&creative=6738&linkCode=as2&creativeASIN=B07ZVJ6TDF&linkId=7ea384a637d8ca5c2e91f204dec1dbfb).
