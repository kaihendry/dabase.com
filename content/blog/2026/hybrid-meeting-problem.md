---
title: "The Hybrid Meeting Problem"
date: 2026-09-21T13:28:04Z
description: "Shared microphones lose speaker identity, remote colleagues struggle to enter the conversation, and breakouts divide the room from the screen. What helps?"
tags: [audio-video]
thumbnail: /blog/2026/hybrid-meeting-overview.png
image_alt: "Eight people share local cues around a table while five remote participants reach them through one shared call connection."
---

Eight people in a room. Five dialled in. One agenda. A familiar meeting, quietly broken in ways that are hard to fix with better microphones.

Over the weekend, I recorded my son explaining a game he wanted to make. I struggled to understand the rules, but an AI worked through the footage, asked some clarifying questions and built a web game to his delight. It made me think about recording requirements discussions and project inceptions: if we capture the conversation well, how much more can we do with it afterwards?

My mentor Kief Morris pointed out a catch. In the Zoom room setup he described, a transcript could distinguish speakers, but an agent still needed help matching those speakers to names. A round of introductions helped. With a shared microphone connected to an individual's laptop, he had seen everyone's speech attributed to the person logged in.

I read that as one part of the **hybrid meeting problem**: the people in the room are distinct to each other, but can collapse into one participant for everyone else, including the software recording them.

[![Eight people around a table share eye contact and quick asides; five remote participants connect through one room tile and shared audio. The resulting problems are speaker identity, participation and breakouts.](/blog/2026/hybrid-meeting-overview.png)](/blog/2026/hybrid-meeting-overview.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/SYiSdbHRZy)*

## Three problems stacked on top of each other

### 1. The audio problem

The room has a conferencing system: microphones, speakers and a camera. Someone also joins from their laptop with audio enabled. Now there are independent audio systems in the same acoustic space, and sound from one can feed back into another. Cue echo, feedback or missing words as the software tries to compensate.

The practical default is one audio connection for the room. Zoom explicitly recommends disconnecting audio on the other devices; muting their microphones alone leaves their speakers active. [Zoom's echo troubleshooting guide](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0061720).

That does **not** mean abandoning personal laptops. People can still use them for chat and meeting controls without connecting their audio. Google Meet's [Companion mode](https://support.google.com/meet/answer/11295507?hl=en-GB) is designed for this: the room handles sound while individual devices provide access to chat, questions and other collaboration features.

Kief's point is the next layer: clear audio doesn't necessarily tell you **who said what**. Separating voices into “Speaker 1” and “Speaker 2” is different from knowing which one agreed to own an action.

[![Alex and Beth speak through one microphone. A transcript may separate voices or attribute them to one account; names and action owners still need confirmation.](/blog/2026/hybrid-meeting-speaker-identity.png)](/blog/2026/hybrid-meeting-speaker-identity.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/4JoK3WQeoBW)*

There are already tools addressing this. Zoom Rooms supports [smart name tags for voice](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0077409), including speaker attribution in transcripts. Capabilities depend on the setup; I wouldn't generalise one laptop's behaviour to every Zoom meeting. But I would check the attribution before treating an AI summary as a reliable account of commitments.

### 2. The participation problem

People in a room negotiate turns through eye contact, body language and small interjections. Remote participants get a much thinner view of those signals. By the time they find an opening, the conversation may have moved on.

Stray, Moe and Semsøy observed 23 meetings at a Norwegian software organisation, 20 of them hybrid. Remote participants contributed less, had difficulty entering conversations and missed side remarks and informal discussions before and after meetings. In one meeting, 56 minutes passed before either remote participant spoke. [Hybrid Meetings in Agile Software Development](https://link.springer.com/chapter/10.1007/978-3-031-72781-8_8), 2025.

HCI research calls the broader difference in how co-located and remote collaborators are perceived **presence disparity**. The term predates today's video platforms. [Tang, Boyle and Greenberg's 2005 paper](https://ricelab.github.io/papers/tang2005understanding/) describes how limited visibility of remote collaborators disrupts interaction.

The evidence isn't simply “remote people disengage”, though. Grassi and colleagues studied 30 professionals across three software companies using questionnaires and physiological measurements. They found comparable engagement between remote and onsite participants. [Exploring Engagement in Hybrid Meetings](https://arxiv.org/abs/2509.20780), 2025.

Those studies measure different things. Someone can be listening closely and still struggle to influence the discussion. My concern is whether everyone has a fair chance to question a requirement or challenge a decision, not whether everyone speaks for the same number of minutes.

### 3. The breakout problem

During a workshop, people naturally want to splinter into smaller conversations. In a room, you can turn to a neighbour, move to a whiteboard or pull two people aside.

In a hybrid meeting, those moves need planning. If the room starts muttering among itself, the remote participants lose the conversation. If everyone online gets put in a separate breakout, location starts deciding who collaborates with whom.

Mixed breakouts are possible, but each group needs somewhere to talk, a working audio setup and shared notes. Clicking “create breakout rooms” doesn't divide the physical room into acoustically separate spaces.

## What people have tried

### Remove the room

GitLab's [all-remote meeting guidance](https://handbook.gitlab.com/handbook/company/culture/all-remote/meetings/#7-avoid-hybrid-calls) recommends avoiding hybrid calls. If one must happen, everyone should use their own camera, headset and screen. Better still, separate into individual workspaces for the call.

That last part matters. Putting eight headsets around one table can still leave people hearing nearby colleagues both directly and through the call, with microphones picking up neighbouring voices. Separate spaces are the cleaner arrangement.

The appeal is that everyone enters the discussion through the same interface. It doesn't remove differences in connection quality, accessibility or confidence, but it removes the room's privileged side channel.

### Make the meeting a document

GitLab's [live-doc meeting](https://handbook.gitlab.com/handbook/company/culture/all-remote/live-doc-meetings/) uses a shared agenda with written questions, named contributions and notes captured during the call. Questions are still spoken and discussed; the document provides an order and a record.

This gives someone who can't get a word in another way to contribute. It only works if the facilitator actually follows the document and brings those contributions into the discussion. An ignored document is no better than an ignored raised hand.

Write down decisions, owners and unresolved questions as you go. That also makes it easier for someone who wasn't there to contribute afterwards, and helps expose meetings that could have been handled asynchronously.

### Give the remote people a body

Microsoft Research's [Hybridge](https://www.microsoft.com/en-us/research/publication/hybridge-bridging-spatiality-for-inclusive-and-equitable-hybrid-meetings/) places remote participants on displays around the physical table. Remote attendees see a digital twin of the room and can choose where they appear and view it from.

In a study using group survival tasks, Hybridge reduced differences in co-presence and agency between room and remote participants compared with a conventional gallery view. Conversation flow improved, although ease of awareness did not.

It's an interesting research system. It shows that design can help, but a controlled study doesn't establish that an ordinary office can reproduce those benefits just by buying more screens.

### Assign a remote advocate

A low-tech approach I'd use alongside a shared document: give someone explicit responsibility for watching the chat and hand-raise queue, and making space for remote participants before the room reaches a decision.

That person needs enough standing to interrupt. “Keep an eye on the chat” is a weak instruction if everyone else is free to ignore what they report.

## Where I've landed

[![Two meeting setups: everyone joins individually from separate spaces using a shared call and agenda; or a shared room uses one audio connection, laptops without audio, a live agenda and a remote advocate.](/blog/2026/hybrid-meeting-setups.png)](/blog/2026/hybrid-meeting-setups.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/64nCha7ZB7R)*

My default for a discussion where everyone needs to contribute is: **if anyone is remote, everyone joins individually, preferably from separate spaces.** This is a practical preference, not proof that every hybrid meeting fails.

When sharing a room is necessary, use one room audio connection, let people join individually without audio for chat and questions, run a shared agenda, and appoint someone to bring remote contributions into the conversation. Plan the breakouts before the meeting starts.

And if the point is to capture requirements for an AI, agree on recording with the participants, introduce people, and confirm decisions and owners in writing. A good recording gives you more to work with. It can't recover the objection someone never got a chance to raise.
