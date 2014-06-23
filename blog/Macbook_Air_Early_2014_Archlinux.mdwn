I upgraded my Mom's old [11 inch Macbook
Air](http://cgi.ebay.co.uk/ws/eBayISAPI.dll?ViewItem&item=221470328889) since
she said the screen was too small. Enter a 13-inch, Early 2014 model with OS X
10.9.3 and enter an opportunity for me to test how well Archlinux works on this
gorgeous Apple hardware in the month of June 2014. Yes, I am looking to upgrade
from my Thinkpad X220 and [Lenovo sadness](http://www.reddit.com/r/thinkpad).

<iframe src="https://www.flickr.com/photos/hendry/14287478567/player/" width="500" height="334" frameborder="0" allowfullscreen webkitallowfullscreen mozallowfullscreen oallowfullscreen msallowfullscreen></iframe>

Firstly I must say, [Archlinux wiki's Macbook
page](https://wiki.archlinux.org/index.php/MacBook) is a bit of a mess. It
over-complicates partitioning and boot loading. However I don't feel like
wading in there to try fix it.

It's surprisingly simple to Archlinux going on the Macbook Air.

1. Boot into OSX. Upgrade.
* Resize the disk using [Disk Utility](http://s.natalian.org/2014-06-21/DiskUtil.png), amazingly you can resize a running MacOSX install
* [Install rEFInd](http://s.natalian.org/2014-06-21/rEFInd.png), with the all drivers switch, `./install.sh --alldrivers`
* Boot the Archlinux ISO on a USB stick by holding down the [Alt key](https://www.flickr.com/photos/hendry/14287300829/)
* Fdisk, create a new partition /dev/sda4, mkfs.ext4 format it, mount it and pacstrap the mount
* Oops, pacstrap doesn't work without Internet and `03:00.0 Network controller: Broadcom Corporation BCM4360 802.11ac Wireless Network Adapter (rev 03)` is not supported by the 3.15 Linux kernel :( Had to purchase a [USB 3.0 to 10/100/1000 Gigabit Ethernet LAN Network Adapter](http://www.amazon.co.uk/gp/product/B00DNU8Y20/), Apple IIUC doesn't offer USB3 hardware!?
* Reboot and with some luck rEFInd, will pick it up! Hint: Installing refind-efi and `refind-mkrlconf` should give you more control, e.g. for adding "rw quiet" or hitting F2 (twice).

<iframe src="https://www.flickr.com/photos/hendry/14287303290/in/photostream/player/" width="500" height="334" frameborder="0" allowfullscreen webkitallowfullscreen mozallowfullscreen oallowfullscreen msallowfullscreen></iframe>

Wireless is since working well so far with the [broadcom-wl](https://aur.archlinux.org/packages/broadcom-wl/) package from AUR.

# Issues

## Keyboard

The [Alt key is way too small](https://www.flickr.com/photos/hendry/14287300829/) and I am not sure what to make of the fn & cmd key.

**Fixed** with `setxkbmap -option altwin:swap_alt_win`.

Someone needs to tell me where the HELL is the Insert key on a Macbook Air.

## TrackPad

I am familiar with the Thinkpad nipple. I'm struggling with the trackpad. I
can't figure out how to paste!!!

Is it a "three finger click" to paste? Anyone know the keyboard shortcut?

Better with `synclient PalmDetect=1`.

**BETTER** with [xf86-input-mtrack-git](https://github.com/BlueDragonX/xf86-input-mtrack) from AUR.

## caffeinate

Suspending, shutdown etc. works out of the box with Archlinux. I think systemd should get the thanks. Really fast.

When I close the lid, the Macbook Air goes to sleep. But sometimes it's doing a
long upload or download and I do not want it to sleep.

## Sound / Audio output doesn't work

	rain:/etc/modprobe.d$ lspci | grep Audio
	00:03.0 Audio device: Intel Corporation Device 0a0c (rev 09)
	00:1b.0 Audio device: Intel Corporation Lynx Point-LP HD Audio Controller (rev 04)

I'm not sure what I did, but it's [working now with pavucontrol](http://s.natalian.org/2014-06-22/macbook-air-sound.png). Might be my general confusion with [starting pulseaudio](https://bugs.archlinux.org/task/40001).

## Brightness buttons don't work

Pommed dies with `E: Unknown Apple machine: MacBookAir6,2`. [Filed a bug](https://github.com/bytbox/pommed-light/issues/17).

## Is the Thunderbolt port usable? Yes!

<iframe src="https://www.flickr.com/photos/hendry/14288409050/in/photostream/player/" width="500" height="334" frameborder="0" allowfullscreen webkitallowfullscreen mozallowfullscreen oallowfullscreen msallowfullscreen></iframe>

# User Experience notes

The Air doesn't have a fan, so when I come back to using the X220, I find the
X220 noisy.

The Macbook Air so far seems to hover around 51C (~70C with Youtube playback)
and its temperature `/sys/class/thermal/thermal_zone0/temp` doesn't fluctuate
as crazily as the X220 does. Which is good!! Its actually cool enough to be on
my lap without feeling like I am killing my sperm off.

The 1440x900 screen is nicer, but I expected it to a LOT better. I guess I was stupidly expecting Retina.

The battery seems to drain as fast as the old 9 cell in the Thinkpad worryingly. I have [tuned it with PowerTOP](http://dabase.com/blog/Systemd_powertop_tunables/) and still I'm not very confident at all. I suspect the screen on full brightness doesn't help.

# Webconverger

The distro that I maintain and earn a living from, [Webconverger works with the Apple Macbook Air hardware too with the USB network device is attached](http://youtu.be/g-JJioLq_T4).
