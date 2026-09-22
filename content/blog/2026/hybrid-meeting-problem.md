---
title: "The Hybrid Meeting Problem"
date: 2026-09-21T13:28:04Z
lastmod: 2026-09-22T13:33:09Z
description: "Have we solved the problem of meetings with both in-person and remote attendees?"
tags: [audio-video, ai]
thumbnail: /blog/2026/hybrid-meeting-overview.png
image_alt: "Eight people share a room while five join through a call, with different experiences of audio, participation and breakouts."
---

## The problem

Eight people in a room. Five dialled in. They are attending the same meeting, but they have different ways to take part.

People in the room can make eye contact, read body language and have quick exchanges around a whiteboard. Remote attendees depend on whatever the microphone picks up and the camera shows. They may struggle to hear an aside, see what someone is pointing at or find a gap to speak. When the room splits into smaller discussions, someone has to work out where the remote participants belong.

**The hybrid meeting problem is how to let everyone participate fully while retaining the benefits of being together in person.** Connecting the room to a call is only the beginning.

[![Eight people share a room while five join through a call. Shared audio, participation and breakouts give the two groups different meeting experiences.](/blog/2026/hybrid-meeting-overview.png)](/blog/2026/hybrid-meeting-overview.png)

The imbalance can carry into the record afterwards. Remote participants have named accounts; the room may appear as a single participant. Someone in the room says, "I'll own it." Can the recording tell us who? If we want to build on the meeting, we need **who said what, when**, as well as a fair chance to contribute in the first place.

## Two main approaches

### Prioritise the people in the room

Run an in-person meeting and let remote attendees dial in. The people around the table keep the natural conversation, shared space and ease of working together that brought them into the office.

The cost falls on those dialling in. They can become spectators, missing side conversations and struggling to interrupt. A room microphone and camera provide access, but they don't by themselves give remote attendees an equal place in the discussion.

### Prioritise remote participation

Run the meeting as a remote call, with everyone joining individually through their own microphone, camera and account. Everyone uses the same shared documents and takes turns through the call.

The cost now falls on people who came into the office. They have to find a quiet spot or book a booth to dial in, perhaps only metres from their colleagues. They lose much of the benefit of meeting in person, and the office needs enough suitable spaces for them all.

Keeping everyone at the same table with a laptop each doesn't remove that problem. Microphones can still pick up neighbouring voices. **These approaches shift the inconvenience between the two groups; neither gives us everything we want.**

## Potential solutions

I'd look at a combination of better room setup, deliberate facilitation and a checked meeting record. Each addresses part of the problem.

### Make the room easier to hear and see

Test the setup from a remote attendee's end: can they hear everyone, see the speaker and follow the material being discussed? Put documents and whiteboard content somewhere everyone can access. Check that the recording captures both the room and remote voices clearly.

Individual microphones and separate tracks can help with recording, but they still pick up neighbouring voices. [Close microphone placement, spacing and room acoustics](https://help.rode.com/hc/en-us/articles/6948902770447-Preventing-Audio-Bleed-in-Multi-Person-Recordings) help reduce that spill. Better equipment needs testing in the actual room; it doesn't settle who gets to speak.

### Give someone responsibility for participation

A named chair should own the agenda, participation and outcomes. Use a [shared live agenda](https://handbook.gitlab.com/handbook/company/culture/all-remote/live-doc-meetings/), bring remote voices into the discussion, repeat contributions that weren't audible and plan how remote attendees will join breakouts. If breakouts need recording, plan that too.

This asks more of the chair and more discipline of people in the room. It is a practical way to improve participation while keeping the group together, but it won't happen automatically because a call is running.

### Identify who said what

A transcript can distinguish Speaker 1 from Speaker 2 without knowing either person's name. Attaching names is a separate task: they must come from an account, a previously labelled voice, an introduction or someone checking afterwards.

[![Two people speak through one microphone. Separating their voices in a transcript is different from identifying their names and confirming action owners.](/blog/2026/hybrid-meeting-speaker-identity.png)](/blog/2026/hybrid-meeting-speaker-identity.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/4JoK3WQeoBW)*

Some tools already address this part of the problem:

| Tool | How names are established | Work still required |
| --- | --- | --- |
| [Zoom Rooms smart name tags for voice](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0077409) | Compares room speech with voice samples people enrol in advance. | Supported setup, administrator enablement, and invitation or pairing requirements. |
| [Otter](https://help.otter.ai/hc/en-us/articles/21665587209367-Speaker-Identification-Overview) | Numbers unfamiliar speakers after processing; learns names from manual labels and existing speaker profiles. | Someone must name new voices and correct mistakes after recording or import. |
| [Plaud](https://support.plaud.ai/hc/en-us/articles/54027338385177-Auto-speaker-labeling) | Uses a voice profile for you; learns other people from names you assign in recordings. | Label unfamiliar speakers and enable label syncing to reuse them in later recordings. |

My reading of these workflows is that a regular team can invest in voice profiles or teach the tool over time. A workshop with unfamiliar guests still needs preparation or someone assigning names afterwards. These are documented capabilities, not evidence of accuracy in our room.

I'd start with recorded introductions, then have someone check the transcript's names against the audio before approving actions. Introductions provide context; they don't guarantee correct attribution throughout the meeting. Flag uncertain names rather than guessing.

### Keep a record people can use

For a meeting we intend to build on, keep the source recordings, a timestamped transcript and referenced documents in a shared location. Have participants confirm decisions, action owners and open questions while the meeting is fresh. The chair owns this follow-through, even if the work is delegated.

Preserving the audio lets us revisit it with better transcription models and use AI to explore constraints, contradictions and follow-up questions. A summary alone has already discarded detail, and better models can't guarantee recovery of speech the microphones never captured clearly. Keep both the source recording for reprocessing and the approved outcomes for acting on; a new transcript shouldn't silently change what was agreed.

I would call the problem solved when people can stay together in the room, remote attendees can participate fully, and everyone leaves with a trustworthy record. These measures are ways to work towards that standard. Speaker labels and AI summaries alone don't establish that we've reached it.
