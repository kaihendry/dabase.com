---
title: "AI can edit video"
date: 2026-11-01T13:25:13Z
description: "I gave Claude Code three unsynced recordings of me demoing Rex. It cut them into a 55-second multicam edit with graphics, a colour grade, a synthesized score and sound design."
tags: [ai, audio-video]
thumbnail: /blog/2026/claude-can-edit-video.jpg
image_alt: "A four-pane grid styled like a Rex window: the Sony angle, the iPhone angle, the screen recording, and a 'claude' pane logging every cut ending in 'grid ← now'."
---

I recorded a quick demo of Rex, a new terminal multiplexer, from three sources:

- my **Sony** camera, which had the good audio
- an **iPhone** on a tripod by the window
- a **screen recording** of the Mac

None of them were synced, and I didn't start them at the same time. Then I asked [Claude Code](https://claude.com/product/claude-code), running inside Rex:

> can you create a compelling video edit using a multicam of 20261101_a71297.MP4 (use the audio here), 'Screen Recording 2026-11-01 at 12.29.07.mov' and iphone-angle.MOV. Goal is to showcase your video editing skills whilst show case Rex, a new terminal multiplexer. Go wild!

This is what came back:

{{< youtube P3WtGJXLjxc >}}

Here's the Codex variant:

{{< youtube 5aa1c_v00iA >}}

For Claude's version, no video editor was opened. Everything was done with ffmpeg and Python, which Claude wrote and ran itself. Here's the session partway through, running in a Rex tab on my `restless-marsh` session:

![Claude Code running in a Rex tab titled "Rex multicam video edit". It shows the prompt, then progress updates: syncing the three recordings, mapping screen actions to speech, verifying word timings, testing stills, and rendering 1652 frames.](/blog/2026/claude-can-edit-video-session.png)

Below is everything Claude did, taken from the session.

## 1. Working out what it had

It started by probing the files:

| Source | Format | Length |
|---|---|---|
| Sony | 4K 29.97p, 10-bit 4:2:2 H.264 at ~140 Mbps, 24-bit PCM stereo | 99s |
| iPhone | 4K 30p HEVC, SDR | 98s |
| Screen recording | 1080p60 H.264 of the Rex Beta window | 109s |

Then it made a contact sheet of each angle (a frame every 10 seconds) to see what was in the shots.

## 2. Syncing three cameras

The creation timestamps put the screen recording 4s before the Sony and the iPhone 13s after it. **Both were wrong.**

Claude cross-correlated the audio tracks instead: all three mixed down to 16 kHz mono, then matched with an FFT. That gave a clear peak:

- the screen recording started **11.94s** before the Sony
- the iPhone started **4.54s** after it

Later it found the screen recording's audio track starts 89 ms after its video. It corrected for that too: 3 frames.

## 3. Reading the dialogue

It transcribed the Sony audio with Whisper (`mlx-whisper`, large-v3-turbo) using word-level timestamps. To help it spell things, it primed the model with "Rex is a terminal multiplexer".

Word timestamps from Whisper drift, so it also ran `silencedetect` to find the real pause boundaries. Then it re-transcribed 26 short slices, one around each planned cut, to confirm which words fell on which side.

That caught a few things:

- "how to switch here" was actually "how to… *[5 second pause]* …switch here". I'd been fumbling with the session switcher.
- "it's fast" was really "and… *[pause]* …it's fast". The stray "and" was cut.
- "I could probably work" was a false start. It was cut too.
- Whisper heard "random files" as "Brandon Files".

## 4. Lining the screen up with the words

Scene-change detection on the screen recording gave a list of moments when something changed, which Claude mapped against the transcript. Several lined up perfectly:

- I'm running `top` on the remote **t14** host as I say "connected here to my T14".
- The session switcher opens just before "creates these random session names" (`lively-prairie`, `restless-marsh`).
- The switch to `restless-marsh` on **This Mac** happens just before "And then here I'm on my Mac".
- The ⌘K command palette opens right after "I'm still learning the binds", but only for about half a second. Claude used a freeze frame.

It picked camera angles from more contact sheets taken at each planned cut point:

- I look into the Sony on "I got this angle from my Sony" and lean in for "Does that look the best?"
- I point at the iPhone on "this angle here from my iPhone".
- I'm facing the iPhone for "I'm curious if Claude can…", then turn back to the Sony for "Who knows? You tell me."

## 5. The concept: multicam as a multiplexer

Rex splits a terminal into panes, so the edit splits the cameras the same way. Whenever more than one angle is on screen, the layout is drawn as a Rex-style window:

- traffic lights
- a session pill named `spliced-angles` on host `claude`
- a `multicam ~` tab
- panes headed `❯_ sony ~`, `❯_ iphone ~` and `❯_ screen ~`

Panes grow out of a full-frame shot the way a terminal splits, with eased motion.

## 6. Shot by shot

The final cut is 35 shots, 44 cuts and 1,652 frames: **55 seconds** from about 98 seconds of raw footage.

| Time | What happens |
|---|---|
| 0:00 | **Cold open.** My camera setup at 3.7× speed. The Sony pane splits to add the iPhone (2.6×), then the screen recording (7×) joins as a third pane, and the shot pushes into it with a zoom-blur. |
| 0:03 | **Title.** `rex▌` types itself on a dark card, then "a new terminal multiplexer". |
| 0:05 | "Right, I've been just experimenting with…" on the Sony, with a slow push-in. |
| 0:07.9 | Zoom-blur cut to the screen on "Rex". It starts tight on the *Rex Beta* menu bar and pulls back. |
| 0:09.3 | Whip pan to the iPhone over my shoulder: "it's connected here…" |
| 0:11 | Glitch cut to `top` running on the remote box. |
| 0:12.2 | 2.6× zoom on the session switcher. An animated box marks **t14**, labelled *remote host*. |
| 0:14 | Boxes on `restless-marsh` and `lively-prairie`, labelled *auto-named sessions*. |
| 0:16 | The actual switch to `restless-marsh` happens, with a flash. *This Mac* gets a callout. |
| 0:17.9 | "It's fast." 11 session flips, 3 frames each, with a tick on every flip. |
| 0:19 | "I don't want to just show…" Sony, with a punch-in to hide the jump cut. |
| 0:20.4 | "…random files of my thing." A 3.3× zoom on the `ls` I'd typed, struck through in red with *not today*. |
| 0:21.7 | "The windows seem to be the marker between." Splits into screen \| iPhone panes. |
| 0:24.6 | "If I could just somehow work out how to…" Screen zoom, with a Sony face-cam picture-in-picture sliding in. |
| 0:27.3 | My 5-second fumble played at **4×**, with a `▶▶ 4×` badge and the real audio tape-sped underneath. |
| 0:28.6 | "…switch here." The switcher opens on the word. |
| 0:29.5 | "I'm still learning the binds." The command palette (frozen) with **⌘ K** keycaps popping in, labelled *change session*. |
| 0:31.8 | "And I got two angles here." Sony \| iPhone split. |
| 0:33 | "I got this angle from my Sony." Full-frame Sony with a viewfinder overlay: corner brackets, blinking REC, `CAM A · SONY`, `4K · 29.97p` and running source timecode. |
| 0:34.7 | "Does that look the best?" 1.45× punch-in as I lean into the lens. |
| 0:36.2 | Whip to "…from my iPhone", with a `CAM B · IPHONE` overlay. |
| 0:38.8 | "I'm curious if **Claude** can simply…" iPhone, with a 1.65× punch-in on "Claude". |
| 0:42.2 | Cuts land on the words: "**switch**" Sony, "**between**" screen, "**these**" iPhone… |
| 0:43.9 | "…**angles.**" Opens into a 4-pane grid with a boom. The fourth pane, `claude ~`, scrolls a live log of every cut so far, ending `cut 00:43.90 grid ← now`. |
| 0:45.4 | "Who knows?" The music stops dead. |
| 0:46.4 | "You tell me." A snap zoom to 1.75× on my face, then a freeze frame. It desaturates and types **`❯ it can.`** with "44 cuts · 3 angles · edited by Claude" underneath. |
| 0:49.7 | **End card.** `rex▌`, "a new terminal multiplexer", "sessions · tabs · panes · remote hosts". |
| 0:52.5 | **Post-credits.** "Okay, let's stop… Stop." with a REC dot that turns to STOP and a two-beep camera stop sound. |

## 7. Picture

- **Framing:** both cameras are 4K, so every punch-in is cropped from the 4K source and stays sharp at 1080p.
- **Screen zooms:** these go up to 3.3× on a 1080p recording. They're upscaled with cubic interpolation, plus an unsharp mask so the UI text stays readable.
- **Grade:** the Sony was backlit by the window, so its shadows are lifted, colours warmed a little and saturation raised 12%. The iPhone ran warm, so it's cooled slightly with 6% less saturation. Camera shots get a gentle vignette.
- **Transitions:** whip pans (a shift plus horizontal motion blur), zoom-blur, RGB-split glitches, white flashes, and punch-ins to hide jump cuts.
- **Type:** everything is set in JetBrains Mono with one blue accent.

## 8. Sound

I used only the Sony audio for dialogue:

- **Cleanup chain:** mono, high-pass at 85 Hz, FFT denoise, −2 dB at 240 Hz, +2.5 dB at 3.5 kHz, then 3:1 compression.
- **Cuts:** an 8 ms fade on every edit to avoid clicks.

**The music and every sound effect were synthesized in NumPy.** No samples or stock music were used.

- **Score:** 112 BPM, Am(add9) → Fmaj7 → C → G. It has a soft sine pad, a plucked arpeggio with ping-pong delay, a pumping sub-bass, and kick, hat and clap in the cold open and end card.
- **Under speech:** a quiet half-time pulse. An envelope follower ducks the music about 8 dB whenever I talk.
- **Shape:** it rises into the "angles" grid, stops dead on "Who knows?" and comes back for the end card.
- **Effects:**
  - whooshes and risers, made from band-passed noise swept in frequency
  - sub booms and keyboard clicks for the typing
  - UI pops on callouts and bit-crushed bursts on glitch cuts
  - a camera shutter on the flash cuts into the viewfinder shots
  - a two-beep "stop recording" at the very end
- **Room tone** sits under the freeze frame so it never drops to digital silence.
- **Master:** −15 LUFS, with a soft limiter at −1.2 dBFS.

## 9. How it was built

There was no editing timeline, only code:

- **Edit list:** a Python list of 35 shots, each with its cut points on the Sony clock, the angle, zoom keyframes, transitions and graphics.
- **Renderer:** ffmpeg decodes each source at just the size needed. Then NumPy and OpenCV do sub-pixel affine warps for the zooms, and Pillow draws the graphics. This ffmpeg build had neither `drawtext` nor `libass`, so all text is drawn in Python.
- **Output:** each shot renders to ProRes, seven at a time in parallel. The shots are joined with ffmpeg and encoded to H.264 (CRF 16) with AAC at 320 kbps.

Claude can't watch video or listen to audio, so it checked its work in other ways:

- **Pictures:** by rendering stills and contact sheets.
- **Sound:** with loudness meters and a spectrogram.

It caught and fixed its own mistakes along the way:

- The `ls` and the ⌘K palette were each on screen for only half a second, so the first render showed the wrong frames. It switched both to freeze frames.
- The keycaps covered the palette, so it moved them.
- A peak-normalisation bug turned the whole mix down. It replaced that with a proper limiter.
- The 89 ms offset inside the screen recording.

The only thing it flagged for me was that it couldn't *hear* the result, so the music balance was the first thing to check.

## So, can Claude switch between these angles?

I asked "Who knows? You tell me." The edit answers that itself: **it can.**
