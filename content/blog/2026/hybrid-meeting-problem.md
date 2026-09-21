---
title: "The Hybrid Meeting Problem"
date: 2026-09-21T13:28:04Z
lastmod: 2026-09-21T14:53:20Z
description: "One computer per person is a starting point for fairer hybrid meetings. Capturing everyone's contributions is the bigger opportunity. Can Granola help?"
tags: [audio-video, ai]
thumbnail: /blog/2026/hybrid-meeting-overview.png
image_alt: "Eight people share local cues around a table while five remote participants reach them through one shared call connection."
---

Eight people in a room. Five dialled in. One agenda, but two different experiences. The room has eye contact, quick asides and its own rhythm. Everyone else has to find a gap in the call.

Three things go wrong:

- **Audio:** several laptops with speakers and microphones active in one room can create echo and feedback. One room audio connection reduces that risk, but can obscure who said what.
- **Participation:** remote people struggle to enter a conversation whose turns are negotiated in the room.
- **Breakouts:** the room splits into smaller conversations while the remote participants wait, or get grouped separately just because they're remote.

[![Eight people share a room and local cues; five remote participants reach them through one room tile and shared audio.](/blog/2026/hybrid-meeting-overview.png)](/blog/2026/hybrid-meeting-overview.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/SYiSdbHRZy)*

## Start with one computer per person

**Everyone joins the call individually, with their own computer, camera and headset.** Even the people in the office. Each person has a named presence, access to chat and hand-raising, and can join a mixed breakout. [GitLab recommends this](https://handbook.gitlab.com/handbook/company/culture/all-remote/meetings/#7-avoid-hybrid-calls), preferably with people moving into separate workspaces.

It's a clear solution, and often an impractical one. An office may not have eight quiet spaces available. Headsets around one table still pick up neighbouring voices, and people hear each other both directly and through the call. It also gives up some of the reason for gathering in a room.

[![One computer per person gives everyone access to a shared call and agenda, but needs quiet spaces and headsets. A hybrid fallback uses one room audio connection, individual laptops without audio, and a remote advocate.](/blog/2026/hybrid-meeting-setups.png)](/blog/2026/hybrid-meeting-setups.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/64nCha7ZB7R)*

If everyone must stay around the table, use one room audio connection and join individual laptops **without audio** for chat and questions. [Zoom warns that muting microphones alone leaves speakers active](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0061720). Use a [shared live agenda](https://handbook.gitlab.com/handbook/company/culture/all-remote/live-doc-meetings/) and give someone responsibility for bringing remote contributions into the discussion. Breakouts still need physical space and planning.

## Separately: record everyone

For me, the bigger opportunity is **capturing everyone's contributions so we can work with them afterwards**. A requirements discussion could become material for an agent to extract constraints, find contradictions, ask follow-up questions and build something. That's much more useful than a summary nobody reads.

The capture needs to include the room, the remote participants and any breakouts, with participants agreeing to it. Ideally, preserve separate audio tracks tied to individuals where the recording setup supports them. One computer per person helps associate speech with a participant, but doesn't automatically produce separate recordings.

[![Two people speak through one microphone. Separating their voices in a transcript is different from identifying their names and confirming action owners.](/blog/2026/hybrid-meeting-speaker-identity.png)](/blog/2026/hybrid-meeting-speaker-identity.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/4JoK3WQeoBW)*

As transcription models improve, we can revisit the same audio and potentially recover words or speaker distinctions an earlier model missed. A summary alone loses that opportunity: it has already selected what mattered and discarded the rest.

There is still a reason to synthesise early. People need a concise account of decisions, owners and open questions to review and approve while the meeting is fresh. I'd keep both: **the source recording for reprocessing, and the approved outputs for acting on**. Better transcription can inform a correction; it shouldn't silently change what was agreed.

## Does Granola solve this?

[Granola](https://www.granola.ai/) was suggested to me. It does more than provide a shared notepad:

1. Its desktop app captures **microphone and computer audio** for [live transcription](https://docs.granola.ai/help-center/taking-notes/transcription), without a bot joining the call.
2. It combines the transcript, your typed notes and calendar context into [**AI-enhanced notes**](https://docs.granola.ai/help-center/taking-notes/ai-enhanced-notes).
3. You can query the meeting material afterwards, including through its [MCP integration](https://docs.granola.ai/help-center/sharing/integrations/mcp).

The catch is directly relevant here: **Granola's speaker tags cannot distinguish people sharing one meeting-room device.** They use the meeting platform's participant names; its [Zoom integration](https://docs.granola.ai/help-center/taking-notes/speaker-attribution-zoom) reads Zoom's active-speaker information. Eight people behind one room account remain a problem. [Speaker-tag limitations](https://docs.granola.ai/help-center/taking-notes/speaker-attribution).

Its mobile app can distinguish speakers in face-to-face meetings, but Granola also says it **doesn't save the audio**. You get a transcript and notes, with no recording to replay or re-transcribe with a better model. [How transcription works](https://docs.granola.ai/help-center/taking-notes/transcription).

So Granola looks useful for capturing and reusing a discussion. Its documented capabilities leave the shared-room identity problem unresolved, and it doesn't preserve the source audio. I'd start with one computer per person where practical, capture everyone's contribution, and approve the meeting outputs without throwing away the material behind them.
