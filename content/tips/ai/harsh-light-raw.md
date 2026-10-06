---
title: Let an AI agent rescue your backlit raw photos
date: 2026-10-06T14:41:00Z
description: How Claude Code culled and developed Sony ARW files shot in harsh light, then saved them as AVIF for sharing
tags: [ai]
---

I photographed a family celebrating their new roof, shooting up at them against a bright afternoon sky. The camera JPEGs were silhouettes. Instead of opening a raw editor, I gave [Claude Code](https://claude.com/product/claude-code) this prompt:

> there is a number of raw images taken yesterday upon /Volumes/Untitled/DCIM/100MSDCF/\*.ARW, since they were taken in the harsh light, can you use the Sony raw images to better the image and save the final outputs as AVIF for sharing? I took several so please whittle down the family pictures celebrating their new roof to a handful please.

Minutes later I had five good photos.

## What it did

1. **Found "yesterday"** by reading the capture dates with `exiftool`, which left 27 of the card's 50 frames.
2. **Made a contact sheet** from the JPEG previews embedded in the ARW files. This split the frames into family bursts and shots of just the building.
3. **Culled each burst** by decoding the raws with the shadows lifted and comparing faces at 100% (open eyes, smiles, nobody hidden behind a scaffold pole). It kept the best frame from each of 5 bursts.
4. **Developed the raws** using exposure fusion (details below).
5. **Saved AVIFs** at full resolution, around 1.1–1.9 MB each, then copied the capture date and camera/lens tags back from the ARWs. It also checked for GPS before sharing; there was none.

## The development trick

A raw file holds several stops more than the JPEG shows. The agent decoded each ARW to linear 16-bit with [rawpy](https://github.com/letmaik/rawpy) (LibRaw), then made synthetic exposures from −1 to +3 EV out of that one file. It blended them with OpenCV's Mertens exposure fusion, which keeps the well-exposed parts of each version:

```python
base = 0.95 / np.percentile(luminance, 99.7)  # brightest sky just under clipping
stack = [to_srgb(linear * base * 2.0 ** ev) for ev in (-1, 0, 1, 2, 3)]
fused = cv2.createMergeMertens().process(stack)
```

After that came a light finish: set the black and white points, add a gentle S-curve, a shadow lift on the backlit frames and some vibrance to bring the sky back to blue. Pillow 12 writes AVIF natively, so no extra encoder was needed:

    uv run --with rawpy --with opencv-python-headless --with pillow python develop.py

## Why this works well as an AI task

- **It looks at the photos.** The agent reviewed contact sheets and face crops itself, so the cull was based on expressions, not filenames.
- **It checks its own work.** It compared before and after, noticed its sky was paler than the camera's, and fixed it in a second pass.
- **No editing software.** LibRaw, OpenCV and Pillow are installed on demand with `uv`, so there's no Lightroom catalogue and nothing to tidy up afterwards.

The tip: when you have a card full of difficult raws, describe the result you want, not the slider settings. Ask the agent to show its picks, and you get a curated, shareable set.
