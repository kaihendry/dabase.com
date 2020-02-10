---
date: 2015-05-19 17:11:28 +0800
---

<http://git-annex.branchable.com/> by my definition is a ground breaking addon
to git to help archive / replicate and optionally add metadata to large files
by the esteemed [Joey Hess](https://joeyh.name/).

It doesn't do several things which I've learnt the hard way:

1. doesn't play well with S3 if you care about using original filenames
* doesn't actually efficiently store your binary files or diff them
* taxes my puny earth brain

Here are my complaints in detail:

# Difficult to deploy

It's a large, monolothic, complex Haskell implementation. Basically you need
the static binary release. Ideally it was just some C extending the existing
git C code base.

I still haven't managed to get it running on my [alarm device](http://archpi.dabase.com/).

# Making modifications to files is really difficult without replicating beforehand

If you are in the school of thought of making changes **in** your media file
and not externally, you will hit the problems I have with git-annex.

Say you want to describe your images by [adding exif
tags](https://github.com/muennich/iptckwed) to your images, you will need
unlock and lock the file. Very cumbersome.

## Direct mode sucks

[Direct Mode](http://git-annex.branchable.com/direct_mode/) makes it simple to
change files, but direct mode has very bad disadvantages. For example, AFAIK if
you delete the file in direct mode, you lose the file. No way to undo, unless
you taken the time to replicate the original beforehand. ARGH!

One workaround is setting tags with [git annex
metadata](http://git-annex.branchable.com/design/metadata/). However what
happens if you want to next edit (e.g. crop) the image? You will face the same
problems...  i.e. no way to back out sanely!

Furthermore I have an issue whereby when you a copy in a file to a direct mode
git-annex repository, you can't seem to check whether it's tracked by git-annex
or not, before making changes. I don't want to discard a file I don't have a
back of yet.

# The transcoder workflow

If you want to [transcode a film.mov to
film.mp4](https://github.com/kaihendry/recordmydesktop2.0/blob/master/htmlvideo)...
that basically replaces film.mp4... again you will have a LOT of pain doing so.

# Create an annex from a S3 bucket and vice versa

Lacking:

* Make bucket public and add corresponding URLs as alternative downloads
* Configure bucket policy to expire to glacier

# The big workaround

Tbh I just want to use git commands without having to worry about:

* how I've added it... whether `git add` or `git annex add`
* worry about `git annex sync`
* worry about how to [undo / back out of changes, because they differ slightly](http://dabase.com/e/15006/)
* worry about file name objects and how their names get obfuscated

For me, I **require** my files to be on S3 on a sane URL, like <http://s.natalian.org/2015-04-22/supersmash.mp4>

My approach until maybe [git-lfs](https://github.com/github/git-lfs/) matures,
is to just check the large file. The big draw back is that I can't drop the
files to free up disk space on my limited SSD on my laptop.

I might be able to work around that by working from an attached USB3 2TB drive.
I will have an non-bare repository that I will `s3cmd sync` to S3.
