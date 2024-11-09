---
date: 2015-05-19 17:45:03 +0800
---

I have used Adobe Premiere, iMovie, Final Cut Pro X and a myriad of other video
editors.

I think it's possible to create a simple localhost video editor, using
opensource software, for telling a story. I think there are projects like
[html5-videoEditor](https://github.com/casatt/html5-videoEditor), but I do not
like the dependencies like MongoDB.

# Basic Requirements

* Replacing audio
* Marking in and out, essentially trimming the video
* Arranging & concatening several trimmed clips

I don't need a ton of other features for my basic video editing flow. Besides
many features such as colour grading & stabilisation are being offered by "the
cloud" aka Youtube nowadays.

## Trimming and concatenating the video

Like my earlier video experiment; <http://video.geekout.org.uk>, what I imagine
happening is listing your videos by source locations, for example:

* gopro/104GOPRO/GOPR1685.MP4
* gopro/104GOPRO/GP011713.MP4
* gopro/104GOPRO/GOPR2258.MP4
* gopro/104GOPRO/GP012260.MP4
* gopro/104GOPRO/GOPR1728.MP4
* gopro/104GOPRO/GP032260.MP4
* gopro/104GOPRO/GOPR1699.MP4
* iphone6/105APPLE/IMG_5593.mp4
* iphone6/105APPLE/IMG_5594.mp4
* iphone6/105APPLE/IMG_5592.mp4

Here you would mark intersections of the video you want to keep. Hopefully the
video player can be programmed to not playback these sections as if they has
been cut away. So you could basically make a **jump cut** quickly.

Now all these edits could be described in a simple JSON file like so:

	[ "filename": "gopro/104GOPRO/GOPR1685.MP4", edits: [ "00:00:03-00:00:08", "00:00:10-00:00:22" ],
	[ "filename": "iphone6/105APPLE/IMG_5592.mp4", edits: [ "00:00:01-00:00:07", "00:01:00-00:01:42" ],

Two filenames for example above have both been edited/cut/trimmed down to two
clips.

Now that simply data structure can hopefully be fed into ffmpeg where it would
[make the edits](http://stackoverflow.com/questions/18444194) and then
concatenate to a **final.mp4** consisting of the 4 clips concatenated in time
order.

## What about sound?

Audacity can import MP4 and you can edit sound. You can accomplish complex
tasks like replacing the audio with say a better copy recorded with a
non-camera microphone. The big issue with Audacity is that it seems to have
issues outputting the edited MP4.

This needs to be crucially fixed.

I imagine MP4s being edited before doing the cuts. And once again after the
cuts have been made to **final.mp4**.

Of course video / audio synchronisation is totally missing, but I think I could
live with that to begin with.
