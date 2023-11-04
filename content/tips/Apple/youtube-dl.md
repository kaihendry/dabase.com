---
title: youtube-dl in 2023
date: 2023-11-04
description: Downloading a video off Youtube
---

After trying a bunch of failing alternatives, this worked:

    brew install yt-dlp
    yt-dlp -S vcodec:h264,res,acodec:m4a --recode mp4 "https://www.youtube.com/shorts/1EFwAaF8P4c"
