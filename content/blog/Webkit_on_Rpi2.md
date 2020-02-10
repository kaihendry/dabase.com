UPDATE 2017-04-02: <https://twitter.com/anholt/status/840753745721937920> there might be a working driver now...

UPDATE: Latest OpenGL work status seems to be here, <https://dri.freedesktop.org/wiki/VC4/> which is **Required** for Webkit2.

Since creating a [Webconverger Rpi2 port](https://webconverger.org/rpi2/) based
upon [Archlinux-Arm](http://archlinuxarm.org/) (Alarm) I've run into the issue whereby
Webkit2 stops working after an upgrade.

The canonical issue is raised upon
<https://bugs.webkit.org/show_bug.cgi?id=143817>, since the [Alarm
project say its an upstream
issue](http://archlinuxarm.org/forum/viewtopic.php?f=60&t=8740&p=46442).

**THE MISSION**: Get Webkit2 working on the [Alarm
Rpi2](http://archlinuxarm.org/platforms/armv7/broadcom/raspberry-pi-2)!

<img style="max-height: calc(100vh - 260px);" src=http://s.natalian.org/2015-10-29/Pi2ModB1GB_-comp.webp alt="Rpi2">

# Does Webkit2 work on Raspbian? Yes... but without hardware acceleration for compositing

So upon [Webkit2](http://webkitgtk.org/) the Stable tarball is WebKitGTK+
**2.10.3**. Alarm's [webkit2gtk is good at being
current](https://github.com/archlinuxarm/PKGBUILDs/blob/master/extra/webkit2gtk/PKGBUILD),
however Debian's packaging is a bit odd.

<s>Firstly their package is called **libwebkitgtk-3.0-0**. The source package from
where it is built from is confusingly called **webkitgtk** and their current
version at time of writing is **2.4.8-2+rpi1**, which is about 6 months old.

After grabbing the source, you can see a scary amount of patches. [314](http://ix.io/lF0) to be exact.

	pi@raspberrypi ~/webkitgtk-2.4.1/debian/patches/rpi $ ls -1 *.patch | wc -l
	314

So one of these patches probably might make **Webkit2** work on **ARMv7h**.
Well... actually I am not confident at all since I know for a fact
**webkit2gtk-2.6.5-1** works fine in [Webconverger's Rpi2
port](https://webconverger.org/rpi2/), and Raspbian's **heavily patched**
version is _2.4.8_... which is older!
</s>

[Raspbian](https://www.raspbian.org/)'s **libwebkit2gtk-4.0-37** and the source package **webkit2gtk** of version
2.9.3, which is newer than the last known Webkit2 in Alarm, **2.6.5**.

Here there are **thankfully** only 12 patches (down from 314):

	pi@raspberrypi ~/webkit2gtk-2.9.3+dfsg1/debian/patches/rpi $ ls -1
	0001-GTK-Crash-performing-drag-and-drop.patch
	0002-GTK-Empty-gtk-font-name-setting-causes-WebProcess-cr.patch
	0003-CairoGL-should-be-checked-unconditionally.patch
	0004-GTK-Forcefully-disable-gtk-doc-and-gobject-introspec.patch
	0005-GTK-The-Missing-Plug-in-buttons-are-not-showing-up-o.patch
	0006-GTK-Crash-when-spell-checker-returns-no-guesses.patch
	0007-Fix-build-with-ENABLE-DATABASE_PROCESS-and-ENABLE-IN.patch
	0008-RPI-Demote-GCC-4.9-requirement-if-ENABLE_DATABASE_PR.patch
	0009-Fix-ENABLE_OPENGL-OFF-builds.patch
	0010-CMake-Trigger-the-memory-reduction-tricks-on-armhf-t.patch
	0011-CMake-Reduce-debug-info-on-32bit-arches-using-g1-to-.patch
	0012-RPI-Disable-AC-by-default.patch

<s>My next step now is to</s> [I have been in
contact](https://twitter.com/CollaboraLtd/status/659398938068393984) with
<https://www.collabora.com/>.

Summary: Emanuele tells me the **proprietary GL stack for the Rpi2 is not
[reliable enough (Webkit may stress it too
much)](https://bugs.webkit.org/show_bug.cgi?id=147258#c3) for Webkit2**.

So the work around is to build with `-DENABLE_OPENGL=OFF` which means **no
accelerated composition at all**. Emanuele is working upon a [software only
compositor](https://bugs.webkit.org/show_bug.cgi?id=147258), but it's far from
finished.

# Workaround that breaks accelerated composition for everyone else

So the Rpi2 which is a Arm7 board differs say to the
[ODROID-XU4](http://archlinuxarm.org/platforms/armv7/samsung/odroid-xu4)
because it uses the [Broadcom
VideoCore](http://archlinuxarm.org/platforms/armv7/samsung/odroid-xu4) GPU
instead of the ARM reference GL hardware called <a
href=https://en.wikipedia.org/wiki/Mali_(GPU)>Mali</a>.

Obviously a Archlinux Arm7 package for Webkit2 with `-DENABLE_OPENGL=OFF` would
be detrimental to working GL implementations like Mali, so at this present time
the Alarm [package
PKGBUILD](https://github.com/archlinuxarm/PKGBUILDs/issues/1155) is unlikely to
be fixed for Rpi2! Since the fix would disable GL working acceleration for the
likes of ODROID-XU4 and make them slow!

I asked Emanuele Aina about the possibility of fallback within Webkit runtime
itself and not a build switch and he said there is a
`WebCore::Settings::setAcceleratedCompositingEnabled()` setting but he has had
issues with it. There needs to be a custom check, though since he works on
Raspbian, he may not find time to implement it. :(

# The future for Webkit on Rpi2

It doesn't look promising in the short term. Emanuele added on 2015-10-07 that
it looks like [**one or two years** from having a GL implementation we can rely
on](https://bugs.webkit.org/show_bug.cgi?id=147258) on the Broadcom based
Raspberry Pi platform ! :(
