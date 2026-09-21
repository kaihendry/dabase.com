---
title: "The Hybrid Meeting Problem"
date: 2026-09-21T13:28:04Z
lastmod: 2026-09-21T15:23:02Z
description: "Hybrid meetings need identifiable speakers, a usable audio mix, preserved recordings and a chair responsible for the conversation and its record."
tags: [audio-video, ai]
thumbnail: /blog/2026/hybrid-meeting-overview.png
image_alt: "Eight people share local cues around a table while five remote participants reach them through one shared call connection."
---

Eight people in a room. Five dialled in. One agenda, but two different experiences. The room has eye contact, quick asides and its own rhythm. Everyone else has to find a gap in the call.

Three familiar failure modes:

- **Audio:** several laptops with speakers and microphones active in one room can create echo and feedback. One room audio connection reduces that risk, but can obscure who said what.
- **Participation:** remote people struggle to enter a conversation whose turns are negotiated in the room.
- **Breakouts:** the room splits into smaller conversations while the remote participants wait, or get grouped separately just because they're remote.

[![Eight people share a room and local cues; five remote participants reach them through one room tile and shared audio.](/blog/2026/hybrid-meeting-overview.png)](/blog/2026/hybrid-meeting-overview.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/SYiSdbHRZy)*

## Start with one computer per person

**Everyone joins the call individually, with their own computer, camera and headset.** Even the people in the office. Each person has a named presence, access to chat and hand-raising, and can join a mixed breakout. [GitLab recommends this](https://handbook.gitlab.com/handbook/company/culture/all-remote/meetings/#7-avoid-hybrid-calls), preferably with people moving into separate workspaces.

It's a clear solution, and often an impractical one. An office may not have eight quiet spaces available. Headsets around one table still pick up neighbouring voices, and people hear each other both directly and through the call. It also gives up some of the reason for gathering in a room.

There is already a useful alternative: [**Google Meet's adaptive audio**](https://support.google.com/meet/answer/14263133?hl=en-GB) coordinates the microphones and speakers of several laptops in the same room to prevent echo. It requires an eligible Workspace subscription and doesn't work alongside Meet hardware devices. One computer per person needn't always mean separate rooms or headsets. However, Meet merges the room's audio and highlights its participants collectively; this isn't a promise of separate recordings or named speaker attribution.

[![One computer per person gives everyone access to a shared call and agenda, but needs quiet spaces and headsets. A hybrid fallback uses one room audio connection, individual laptops without audio, and a remote advocate.](/blog/2026/hybrid-meeting-setups.png)](/blog/2026/hybrid-meeting-setups.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/64nCha7ZB7R)*

Another arrangement is one room audio connection with individual laptops joining **without audio** for chat and questions. [Zoom warns that muting microphones alone leaves speakers active](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0061720). Use a [shared live agenda](https://handbook.gitlab.com/handbook/company/culture/all-remote/live-doc-meetings/) and give someone responsibility for bringing remote contributions into the discussion. Breakouts still need physical space and planning.

## Separately: record everyone

For me, the bigger opportunity is **capturing everyone's contributions so we can work with them afterwards**. A requirements discussion could become material for an agent to extract constraints, find contradictions, ask follow-up questions and build something. That's much more useful than a summary nobody reads.

The capture needs to include the room, remote participants and breakouts, with participants agreeing to it. Two requirements are easy to confuse: **identifying who spoke** and **saving separate audio tracks**. A transcript can name people whose voices still share one recording.

[![Two people speak through one microphone. Separating their voices in a transcript is different from identifying their names and confirming action owners.](/blog/2026/hybrid-meeting-speaker-identity.png)](/blog/2026/hybrid-meeting-speaker-identity.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/4JoK3WQeoBW)*

## The capture problem already has solutions

These are documented product features; their accuracy needs testing in the actual room:

| Setup | What it already offers | What needs configuring |
| --- | --- | --- |
| [Microsoft Teams speaker recognition](https://learn.microsoft.com/en-us/microsoftteams/rooms/voice-recognition) | Names individual speakers sharing room audio. Microsoft also documents a laptop with a USB speakerphone option. | Voice enrolment, meeting invitations and administrator settings. Teams Rooms needs a Pro licence; the laptop host needs Teams Premium or Copilot. Check the calendar requirements. |
| [Zoom Rooms smart name tags for voice](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0077409) | Attributes room speech to individuals in captions, transcripts and summaries. | Supported room setup, administrator enablement, and voice enrolment/invitations for automatic names. It doesn't work when the room joins another platform's meeting. |
| [Ordinary Zoom desktop recording](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0076922) | Saves a separate audio file per connected participant, including on the free plan. | Enable the separate-audio-files option. Several humans sharing one room connection still share that audio stream. |
| [Otter](https://help.otter.ai/hc/en-us/articles/21665587209367-Speaker-Identification-Overview) | Distinguishes speakers after processing; naming them helps it recognise their voices in future. | Review and correct the names. It also supports [audio export](https://help.otter.ai/hc/en-us/articles/360047733634-Export-conversations), so the transcript needn't be the only surviving record. |

Turn on actual recording as well as transcription: [Teams can retain meeting audio](https://support.microsoft.com/en-us/teams/meetings/start-stop-and-find-meeting-recordings-in-microsoft-teams), and [Zoom cloud recording offers mixed or per-participant audio files](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0064676). Check retention settings. Breakouts require extra care: [Zoom cloud recording captures only the main room](https://www.zoom.com/en/blog/using-zoom-breakout-rooms/); recording each breakout needs a participant recording locally in it.

So this doesn't require waiting for future technology. The work is choosing and configuring a setup, then checking that it captured everyone correctly. Better attribution still doesn't make room participants notice a remote colleague trying to interrupt.

## Does Granola solve this?

[Granola](https://www.granola.ai/) is more than a shared notepad. It transcribes microphone and computer audio without a meeting bot, combines the transcript with your notes to produce [AI-enhanced notes](https://docs.granola.ai/help-center/taking-notes/ai-enhanced-notes), and makes meeting material available through [MCP](https://docs.granola.ai/help-center/sharing/integrations/mcp).

But its desktop [speaker tags cannot distinguish people sharing a meeting-room device](https://docs.granola.ai/help-center/taking-notes/speaker-attribution). Its mobile app can distinguish speakers face-to-face, yet Granola [doesn't save the audio](https://docs.granola.ai/help-center/taking-notes/transcription). There is no recording to replay or re-transcribe.

That makes Granola useful for notes, but a poor fit for my requirement to preserve the source. I'd first test the recording and speaker-recognition features in the meeting platform we already use.

## The non-negotiables

A meeting we intend to build on increasingly needs the discipline of a recording studio: check the inputs, listen to the mix and keep the source recordings. My requirements would be:

- **Who said what, when.** Identifiable speakers in a timestamped transcript linked to the recording. Check the names; flag uncertain attribution rather than guessing.
- **A usable audio mix.** Room and remote voices must both be clearly audible in the call and recording. Monitor what is actually being captured. Keep separate tracks alongside the mix where available.
- **Sources available afterwards.** Preserve the recordings, transcript and referenced documents in a shared location, with working links and access for the people and tools that need them.
- **Checked outcomes.** Participants confirm decisions, action owners and open questions while the meeting is fresh. Keep unresolved disagreement visible.
- **A named chair.** Someone must manage participation and ensure the records are checked, complete and accessible afterwards. Recording and note-taking can be delegated; responsibility for their quality must be explicit.

As transcription models improve, we can revisit the same audio and potentially recover words or speaker distinctions an earlier model missed. A summary alone loses that opportunity: it has already selected what mattered and discarded the rest. Better models still can't guarantee recovery of speech the microphones never captured clearly.

We still need to synthesise early so people can approve a manageable account of what was agreed. Keep both: **the source recording for reprocessing, and the approved outputs for acting on**. Better transcription can inform a correction; it shouldn't silently change what was agreed. The chair's job now extends to the meeting's record.
