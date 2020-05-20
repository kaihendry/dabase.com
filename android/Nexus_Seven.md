So it's [[four_years|The_deprecated_SDcard]] since my last Android post. Ever
since I was given a "free" iPhone from my workplace at the time, all those years
ago, I decided to switch to IOS and I've been a happy camper ever since.

As people will testify who know me, I am not an Android fan. Usability is poor and
I'm a Java language hater. Nonetheless I've set myself a challenge to explore &
develop a Webconverger port. The source code won't be public, though I will
make efforts to document my efforts here.

## 2015-01-11

I want **Android 5** and I need a device. If my memory at Aplix serves me
correctly, running AVD emulator on my aging X220 would be madness.

<a href="https://www.flickr.com/photos/hendry/16254776355" title="Nexus 7 running lollipop aka Android 5 by Kai Hendry, on Flickr"><img src="https://farm9.staticflickr.com/8661/16254776355_2bd458127b_n.jpg" width="240" height="320" alt="Nexus 7 running lollipop aka Android 5"></a>

So I bought a second hand Nexus 7 for 200SGD off <https://carousell.co/>. I'm happy with it.

First impressions of setting up the device is that the wireless "password" prompt is jarringly wrapped. UGLY!

It seems the device is unusable without logging into Google. Tbh I don't use
Gmail anymore and I don't want it to download my old email, nonetheless it went
ahead and did it. :( I'm logged into Youtube, but it seems like I need to
separately log into the Play store et al. What the hell!?

Not sure how I would ever use this device myself in my daily life. Ok, maybe
for watching Youtube videos in bed? :)

So far nothing impresses me about the device. I thought there was a VOIP
client, but I can't find it. Seems like I have to use the [proprietary Google
Hangout](https://en.wikipedia.org/wiki/Google_Hangouts).

## 2015-01-12

<img src=http://s.natalian.org/2015-01-12/lib32-android-studio.png alt="lib32 fugliness">

I've earmarked today to setup the [Android development environment on
Archlinux](https://wiki.archlinux.org/index.php/android#Android_Studio). Bonus
points if I manage a Hello World app.

Got android-studio installed after enabling multilib. Why is it 32 bit is beyond me. Especially considering the RAM it consumes.

	Optional dependencies for android-studio
		android-sdk
		android-sdk-platform-tools
		android-sdk-build-tools

<https://bugs.archlinux.org/task/43418?project=1&cat%5B0%5D=2&string=java-runtime-common>

I had some corrupt JDK since I ran out of disk space on /tmp, hence [I wasted some time](https://bugs.archlinux.org/task/43418?project=1&cat%5B0%5D=2&string=java-runtime-common). OpenJDK was unstable with crap outs like `systemd-coredump[20156]: Process 7039 (java) of user 1000 dumped core`. The Oracle JDK works better since I think it's compiled against a newer libc from what I was reading after a frantic Google session.

	x220:~$ sudo archlinux-java status
	Available Java environments:
	  java-8-jdk (default)
	  java-8-jre/jre
	  java-8-openjdk

Worryingly, selecting to create a new project takes seriously 5 minutes of frantic downloading. Scary: <http://r2d2.webconverger.org/2015-01-12/gradle.mp4>

Android studio seems to going mental with "Unregistered Vcs root detected" with
the fact the my homedir is in Git. Configure doesn't seem to point out where my
Project lives. I think I've resolved this now.

<blockquote class="twitter-tweet" lang="en"><p>Is this how <a href="https://twitter.com/Android">@Android</a> Studio really works? Spawning zillions of Java VMs ? <a href="http://t.co/s4froaYKQt">http://t.co/s4froaYKQt</a> :/</p>&mdash; Kai Hendry (@kaihendry) <a href="https://twitter.com/kaihendry/status/554587440871006208">January 12, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Both `wmname LG3D` and `export _JAVA_AWT_WM_NONREPARENTING=1` seems to be
needed to make android-studio behave with [dwm](http://dwm.suckless.org/).

<img width=500 src=http://s.natalian.org/2015-01-12/helloworld.png alt="Got my Android dev environment going!">

## 2015-01-13

First, many thanks to [Wyemun](https://github.com/wyemun) for answering several of my questions.

Things I don't understand about IntelliJ. How to reformat my buffer? (Update:
2015-01-15 Ctrl-Alt-L, Return) Why is finding a class for an import so bloody
slow / not working at time? It makes `goimports` look like genius. How do I
search all the files in a project?

Not sure how Android documentation is organised. Took me hours to find:

<http://developer.android.com/reference/android/app/ActivityManager.html#isInLockTaskMode()> was the way you test <http://developer.android.com/reference/android/app/Activity.html#startLockTask()> is active. Why isn't there a cross reference from `startLockTask`?!?!?!

Furthermore, to be able to query this property, you need to grossly verbose
instantiation: `ActivityManager activityManager = (ActivityManager)
this.getSystemService(Context.ACTIVITY_SERVICE);` Is this normal??!

Creating a URL in Java is a bit weird. Seems to bizarrely demand a try..catch. Really starting to appreciate Golang's [error handling model](http://blog.golang.org/errors-are-values).

So bundles, IIUC, are Android's version of
[localStorage](https://html.spec.whatwg.org/multipage/webstorage.html#the-localstorage-attribute)?
I'm getting to grips with the Android lifecycle and it means saving state
manually between onCreate AFAICT. Haven't quite got a good mental model. TODO: <http://developer.android.com/training/basics/activity-lifecycle/>

### WebView

Why doesn't it prompt that it needs the **android.permission.INTERNET** permission in the IntelliJ (Android Studio) IDE?

Odd how you need to explicitly enable Javascript in the WebView and make links clickable. Why aren't these defaults?

Odd to me, that WebView's `loadUrl` wants a string, not a URL object.

## 2015-01-14

I wish there was a way taking a video capture like you can with IOS attached to
a MBP with Quicktime player "Movie recording".

Had this scary [Default Activity not found](http://stackoverflow.com/questions/18828654/default-activity-not-found-in-android-studio). Restarting Android Studio 1.0.2 fixed it for me.

<http://romannurik.github.io/AndroidAssetStudio/icons-launcher.html> confusingly [generates PNGs with a **mipmap** directory prefix](https://github.com/romannurik/AndroidAssetStudio/issues/38) instead of drawable. WTH. Ok, spending way way too long trying to setup the icons. Sheesh

Bizaare to me that Android just doesn't use SVG and let the SDK build out the PNGs as needed. Whacky.

Annoyingly [romannurik](https://github.com/romannurik) who pissed me off with `s,@drawable,@mipmap,` (nevermind all the stock ic_launcher.pngs laying around my project) change, fronts a [video explaining how to do Android immersive mode](https://www.youtube.com/watch?v=cBi8fjv90E4). Maybe it was because I was upset with him, but I didn't get it. Bit silly how hard it is to hide the {action,status} bar until the App is interacted with.

## 2015-01-15

Today, my mission is to understand how [Device Administrator](http://s.natalian.org/2015-01-15/device-administrator.png) works.

1. <http://android.stackexchange.com/a/85125/90140>
2. <http://stackoverflow.com/questions/26467321>
3. <https://code.google.com/p/android-developer-preview/issues/detail?id=1646> ... ah, if only it could be easy

It seems that you can only setup an [Android Lollipop device with NFC](http://developer.android.com/about/versions/android-5.0.html#Enterprise). A tad bizarre. This means you need at least two NFC capable Android devices. That run Lollipop. Hmmm, Ok.

After a frantic 1-2hr coding session, I managed to root the device and further lock down the App by establishing Device Administrator. Some puzzles remain:

* How to disable Device Administrator? Bizarrely uninstalling the App doesn't work. <http://s.natalian.org/2015-01-15/still-admin.png>
* If the device is powered off, which is quite possible to do when mounted in a public environment, it doesn't return to the (locked) app. Oh dear.

## 2015-01-16

Mission today is explore Android Lollipop's "Tap & Go" feature. I need another NFC Android 5.0 device to this. Arghhhh!!

So I spent a few minutes restoring to locked, non-rooted Android lollipop to
see whether this Device Admin via NFC works. Worryingly I managed to update to
[5.0.2](http://s.natalian.org/2015-01-16/5.0.2.png) when previously I am quite
certain that Android was adamant that 5.0.1 was current.

I couldn't find an official Google source iterating the difference between
5.0.2 & 5.0.1. Best I found was via
[Wikipedia](https://en.wikipedia.org/wiki/Android_version_history).

Signed up for a Google Play account! BOOM!

## 2015-01-19

I'm decided that once I'm done buggering around, I'm going to release this
kiosk app as opensource. I'm still climbing this very steep learning curve,
copying and pasting SO answers and letting Android Studio work its magic. So
many things I don't really understand yet. :/

One thing that took me off guard is the way you can't just simply destroy the
Webview and re-instantiate (not sure if that's correct terminology) it. Motive
here is to ensure an ABSOLUTELY clean slate (just like Webconverger for PC) if
the Webview was interacted with. First destroying it and building it up again
manually in the layout is not straightforward, but more importantly its state
is surprisingly not under the Webview object but somewhere else!

The NFC provisioning is EXTREMELY slow since A) I don't know what I'm doing, so
I need to iterate B) The iterations seem to [necessitate an OTT encryption
step](https://www.flickr.com/photos/hendry/16314353155/). Begs the question,
why isn't it just encrypted by default Lollipop?

Must have wasted at least an hour trying to rename (aka refactor in Android
Studio) my app from *.myfirstapp to *.kiosk. Still have not succeeded. I will
try `sed` next.

Did the mistake of copying a directory of an App example and thinking Android
Studio would just pick up on it. Oh no. Oh hell no.

Why do some projects have such crazy directory structures? e.g.

	app/src/main/java/uk/co/name/codesample/MainActivity.java

Directory **main** seems unnecessary.  Directories like uk/co/name/codesample are pretty pointless too.

## 2015-01-20

I have honestly spent HOURS OF FRUSTRATION with org.apache.commons library. I
put the dependency in the wrong gradle file. Wish creating a SHA1 sum in
Android was slightly saner.

Added some images that [demonstrate the glitches around
provisioning](https://www.flickr.com/search/?tags=lollipop&sort=relevance&user_id=16105436%40N00)
and I've opensourced the code I'm working on since it kinda works:
<https://github.com/webconverger/android> and I'm not too embarrassed about it.

## 2015-01-21

My objective today is make the device unlock via the
<https://config.webconverger.com/> API.

I wish I could say I am feeling more confident about running Android Studio.
Nope... I'm in fear of what craziness will get in my way next.

Don't quite understand the switch statement in Java. Is seems to have been
features in Java7, but am I using a Java7 dialect? I have no idea.

I have a line like: if (bundle.getBoolean("foobar"), false) {, but foobar
doesn't exist. So is it right that I get `java.lang.NullPointerException:
Attempt to invoke virtual method 'boolean
android.os.Bundle.getBoolean(java.lang.String)' on a null object reference`
?!... shouldn't it be just false? Oh, I figured it out. My bundle argument was
someone coming through my PostExecute as null and I needed a null check.

## 2015-01-22

Made slow and steady progress yesterday on <https://github.com/Webconverger/android/commits/master>.

Takes a RIDICULOUS amount of time to provision the App over NFC, watch it encrypt etc etc.

Mission today is to upload to Google Play and try get an update working. So I
need to work out how to embed a version string too.

I am seeing this issue: <http://stackoverflow.com/questions/27826431/activity-startlocktask-occasionally-throws-illegalargumentexception>

## 2015-01-26

My objective today is to get someone to test my App before it goes live on
production. Once it's "live" I want to test updates and such and so forth.

I also want to work out how timers work. i.e. I want the app to do something at
X minutes of inactivity.

It appears that you can't put an App on the play store as "unlisted". Testing
via a Google Group or G+ is kinda crazy.

## 2015-01-27

<img src=http://s.natalian.org/2015-01-27/1422347272_1364x748.png alt="Uploading to Google Play">

I've uploaded the [current alpha quality state](https://github.com/Webconverger/android/commit/f13b04c88345c5b250e758d82210b8a3814fbb1c) to
<https://play.google.com/store/apps/details?id=com.webconverger.KioskApp>. I've
also taken a video with my GoPro that I need to edit in Premiere Pro to
describe the setup steps for an absolute beginner.

I can't take a screenshot of emulator running Webconverger on a 10 inch tablet
since my 4GB Thinkpad X220 seems physically incapable of doing so! :(

# 2015-01-28

Woke up to find the **com.webconverger.KioskApp** still not in the store. I think I must have marked in Alpha. Tried to re-upload straight to production tab to be told I need to increment the versioncode. After some head scratching, I found the variable to increment in <https://github.com/Webconverger/android/blob/master/app/build.gradle>.

Wow, it's in! <img src=http://s.natalian.org/2015-01-28/1422408822_1364x748.png alt="First version on Webconverger for Android">

* <http://s.natalian.org/2015-01-28/storesearchresultwebconverger.png>
* <http://s.natalian.org/2015-01-28/storedetailswebconverger.png>
* <http://s.natalian.org/2015-01-28/readmorewebconverger.png>
* <http://s.natalian.org/2015-01-28/permissionswebconverger.png>
* <http://s.natalian.org/2015-01-28/installedwebconverger.png>

Installed Android Studio on a Mac:

* WTH is Osascript? https://www.dropbox.com/s/ie2i62hrgawza21/Screenshot%202015-01-28%2010.09.59.png?dl=0

Gradle got confused about the build SDK. After a couple of re-installs and reboots of studio, amazingly I can run my project.

Studio got stumped by my VCS root. Shit, is it so hard to realise I've checked out a project into ~/AndroidProjects? Studio alsdo creates an `android.iml` file. Not sure it's worth checking into git since I don't quite understand what it does and it looks like boiler plate to me.

So I launched a 10 inch emulator trying to get that [prized screenshot for Google Play](http://s.natalian.org/2015-01-28/1422413326_1364x748.png), but [everytime I try take a shot, it's just black! :(](https://www.dropbox.com/s/m5wfspzy9i47m4w/Screenshot%202015-01-28%2010.42.17.png?dl=0)

I need to create a video and do some [better screenshots](https://developer.android.com/distribute/tools/promote/device-art.html) to explain how this app works.


1. Launch & lock
* Create config using email address as an identifier
* Confirm email on some other device
* Add Android device to config
* Reset button <--- not sure people realise what that little icon on the top right of the action bar is

# 2015-01-29

Oops, yesterday I did work on
<https://github.com/Webconverger/android/commits/master>, to make the action
bar slink away when not being used and maximise the screen to show the
homepage.

I also took a couple of videos, without thinking how awful they would look in
portrait. So I need to redo them in landscape.

I also had to retweak the signup process on
<https://config.webconverger.com/clients/?id=foobar> since [Bootstrap's modal
Javascript](http://getbootstrap.com/) was way too slow.  As a conseqence signup
video walkthroughs like <https://www.youtube.com/watch?v=aAbIYAbXf5E> probably
make no sense. :/

This morning my main objective was to see the [App auto
update](http://s.natalian.org/2015-01-30/play-update.png). It didn't. Is it
because it's [still running?](http://s.natalian.org/2015-01-30/app-info.png) I
ended up manually updating. :( I miss Web applications.

# 2015-02-02

My object today is to streamline the <https://config.webconverger.com/> on
boarding process for the Android device. Hopefully this will improve the PC
signup process too.

I was messing around with theming the action bar and IIUC Android 5.0 aka
Lollipop is what I only plan to support at this point in time. Which is API
version 21. I've just noticed this directory structure:

* app/src/main/res/values-v21/styles.xml
* app/src/main/res/values/styles.xml

So I assume values-v21 is for Lollipop.... and above? Can I remove
`app/src/main/res/values/styles.xml` since I don't plan to use it? Confusing!

# 2015-02-03

I upgraded my RAM on my Thinkpad X220 from 4GB to 8GB for 54SGD since my
machine was locking up with Android Studio + Emulator.

Now with 8GB it doesn't lock up, but I still [cannot get that elusive 10inch
tablet screenshot](http://s.natalian.org/2015-02-03/nexus-10-fail.png) for the
[Google Play
listing](https://play.google.com/store/apps/details?id=com.webconverger.KioskApp)
to say "Designed for Tablets". Sad. :/

Black screenshots from the emulator, I think it's this bug: <https://code.google.com/p/android/issues/detail?id=60359>.

[Asked for testers for
webc-users](https://groups.google.com/d/msg/webc-users/qXZHvmk1Jgo/3B2lw0mnWqMJ)
and updated the [FAQ entry on touch
screens](http://webconverger.com/faq/#does-webconverger-support-touch-screens).
I think there is a programatic API for changing the IME, i.e. the keyboard for
supporting CJK locales. I'm confident Google have done a good job here and it
would be nice for this port to support it via our existing [i18n
API](http://webconverger.org/i18n/).

# 2015-02-05

Annoyingly the [Google Play listing](https://play.google.com/store/apps/details?id=com.webconverger.KioskApp) STILL says designed for phones, despite my [change yesteday](https://github.com/Webconverger/android/commit/bca4a0a03ffe8aa7a386a9c07ac0c81aa58238c9). Argh!

I wonder if there is a way to get the [list of supported devices of Google
Play](http://s.natalian.org/2015-02-05/1423099789_1364x748.png) ?

Today I want to focus on hiding the version number behind a couple of clicks
and neatening up the Action bar, as per
<https://github.com/Webconverger/android/issues/1>
