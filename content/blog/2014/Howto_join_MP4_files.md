---
date: 2014-04-30 17:52:18 +0800
---

# What does not work

<a href="http://trac.ffmpeg.org/wiki/How%20to%20concatenate%20(join,%20merge)%20media%20files">ffmpeg has an insane interface</a> for simple use cases like joining two MP4 files.

	cat draw.mp4 draw2.mp4 > draw3.mp4

	ffmpeg -i "concat:draw.mp4|draw2.mp4" -c copy draw3.mp4

	ffmpeg -i draw.mp4 -i draw2.mp4 -vcodec copy -acodec copy draw3.mp4

	mkfifo temp1 temp2
	ffmpeg -i input1.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts temp1 2> /dev/null & \
			ffmpeg -i input2.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts temp2 2> /dev/null & \
			ffmpeg -f mpegts -i "concat:temp1|temp2" -c copy -bsf:a aac_adtstoasc output.mp4

# What works

	ffmpeg -f concat -i <(for f in *.mp4; do echo "file '$(readlink -f $f)'"; done) -c copy output.mp4

With a different sort:

	ffmpeg -f concat -i <(for f in $(ls -1 | sort -r); do echo "file '$(readlink -f $f)'"; done) -c copy output.mp4
