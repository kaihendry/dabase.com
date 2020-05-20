After rooting my UK T-mobile G1 and then flashing with [JesusFreke’s ADP
1.5](http://jf.andblogs.net/2009/05/01/when-is-your-15-coming-out/), I was able
to install [android wifi
tether](http://code.google.com/p/android-wifi-tether/).

Previously I tethered using the `adb forward tcp:1080 tcp:1080` socks trick,
but that sucked because:

* DNS didn't work
* if it did, you could only use HTTP easily
* bit of a pain to setup

Ideally I would have liked to tether via a USB cable, though I couldn't quite
figure out how to create a USB based network. Anyway a Wireless access point
(AP) is better for sharing and being social, though it does need to be
physically tethered to a power source since the device sucks battery juice
whilst tethering.

# Ad-hoc Wireless Networking Debian to the Android G1

This is a bit tricky, as I couldn't seem to get a DHCP IP over ad-hoc mode. So
here I set up everything manually, after inspecting the device with `adb shell
ifconfig tiwlan0`.

I added to `/etc/network/interfaces`:

    iface wlan0 inet static
        wireless-essid G1mobile # configure this in 'Wifi tether' on your G1
        wireless-mode ad-hoc
        address 192.168.2.20
        netmask 255.255.255.0
        gateway 192.168.2.254
        dns-nameservers 192.168.2.254 # you need to install [resolvconf](http://packages.qa.debian.org/r/resolvconf.html)

And commented out the existing _wpasupplicant_ configuration. Next `sudo ifup wlan0` and you should be away.

# Comparing England's T-mobile, Orange and Vodafone 3G

I borrowed a Vodafone SIM card, but I couldn't get it working until I manually
chose the Vodafone network and setup the APN with **wap** crap:
    wap.vodafone.co.uk
    user: wap
    pass: wap

T-mobile don't use the loaded legacy **wap** word, but their APN is confusingly
called 'general.t-mobile.uk'.  User: 't-mobile', Pass: 'tm'. I need to
experiment with APNs as I hope I get around [content
transformation](http://www.flickr.com/photos/hendry/3000417670/) and crappy
looking images.

Orange nicely just requires 'orangeinternet' to hop on. They give Vodafone a
run for their money from Guildford! Orange also don't seem to run content
through any transformation on my test. So images look decent! Orange WINS!

<img src="http://www.speedtest.net/result/473330924.png" />
<img src="http://www.speedtest.net/result/473331849.png" />
<img src="http://www.speedtest.net/result/473338841.png" />
<img src="http://www.speedtest.net/result/473339432.png" />
<img src="http://www.speedtest.net/result/473548630.png" />

Just 12 months of poor T-mobile service to go of my 18 month contract... then
PAYG for me! PAYG deals for mobile data are getting seriously reasonable of
late. So much so, I might switch SIMs where I know T-mobile will suck.

I'm not quite certain if the aforemnetioned APNs are
[HSDPA](http://en.wikipedia.org/wiki/HSDPA). The 3G icon is present on Android
during all the tests.

<a href="http://www.flickr.com/photos/hendry/3530750193/" title="Wifi tether by Kai Hendry, on Flickr"><img src="http://farm4.static.flickr.com/3587/3530750193_29e170f695.jpg" width="480" height="320" alt="Wifi tether" /></a>
