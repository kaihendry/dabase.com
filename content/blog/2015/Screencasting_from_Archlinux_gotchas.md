---
date: 2015-07-15 11:37:22 +0800
---

## Update: I now use [obs-studio](https://obsproject.com/) for my [videos](https://www.youtube.com/user/kaihendry)!

<iframe width="560" height="315" src="https://www.youtube.com/embed/mLJOv9a_4as" frameborder="0" allowfullscreen></iframe>

This follows up from a blog on [capturing video from HDMI](http://natalian.org/2015/03/13/HDMI_in/)

I've invested a lot of time, money and effort into screencasting from my
Archlinux laptop.

Without going into minutiae, I'll quickly run through the major obstacles to
doing this.

# The laptop's microphone is unusable

Fixed by the Audio-Technica ATR2100-USB Cardioid Dynamic USB/XLR Microphone.
However I find it difficult to mount in front of my mouth, where the best
recordings are.

Obviously I can't hold it, since I'm screencasting and I need two hands to type!

# video4linux .... sucks

On the 4.x Linux kernel I have a lot of issues with /dev/video0 (typically
Webcam) and /dev/video1 (typically GoPro attached via Magewell XI100DUSB-HDMI).

They can disappear, re-appear and cause also sorts of broken recordings. :(

	ffmpeg -f v4l2 -list_formats all -i /dev/video1

# There is no H264 encoding support from Intel on Linux

Intel's hardware acceleration technology is called <abbr title="Video Acceleration API">VAAPI</abbr> and to cut a long story short.. has **poor** support on Linux.

	hendry, if you want to use the intel hw encoder, install Windows. There are a lot of applications that support QSV for encoding. Handbrake for example.

This is my output from [vainfo](http://ix.io/jJO).

The gstreamer implementation at <https://github.com/01org/gstreamer-vaapi/blob/master/gst/vaapi/gstvaapiencode_h264.c> is said to be unstable.

	The point is that libva for encoding is incredibly annoying to use, which is the reason why no usefull implementations exist.

# Without hardware accelerated H264.. prepare to SKIP FRAMES. LOTS OF FRAMES

On my Broadwell Thinkpad X1C3 recording my desktop at 1920x1080 with a
1920x1080 overlay from my GoPro via <abbr title="Video for Linux">V4L</abbr> is
a **non-starter**. Think of reducing the GoPro input to **640x480** maybe. [Sample](https://www.youtube.com/watch?v=_Tp3P3qxdxU)

Remember software encoding multiple video feeds plus audio is **EXTREMELY CPU
INTENSIVE**. Your machine is unlikely to cope and the result will be jittery video
which is unwatchable.

Workaround: Using MKV output format LOWERS my CPU LOAD! Which Youtube actually understands without taking [another step to encode it into MP4](https://github.com/kaihendry/recordmydesktop2.0/blob/master/htmlvideo).

# And the Linux tooling sucks

To work out the optimal recording setup is a LOT OF HARD WORK. Especially since
it can be difficult to grok the load, the **skipped frames** and the resulting FPS
until you finished recording.

For best results, you probably just want to record separately however combining
and syncing audio and video is an INCREDIBLY time intensive manual operation.
The tooling sucks on Linux. Even on FCPX on MacOSX it takes a huge amount of
time to do right.
