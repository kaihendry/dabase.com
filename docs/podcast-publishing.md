# Podcast publishing checklist

Start with a completed Zoom recording. Finish with a working episode page,
podcast feed entry, YouTube video and promotional clips.

The agent runs the editing, asset preparation, metadata, S3 uploads and blog/feed
publishing steps. The user reviews the initial full YouTube cut and handles
posting to YouTube, LinkedIn and X. This is an agent-led workflow with human
handoffs; access problems such as expired AWS credentials may still need the user.

The order is: **Zoom recording → initial full cut → user review and approval →
final assets and teasers → manual YouTube upload → supplied YouTube URL →
automated blog/feed publication.** Do not make shorts or teasers before the full
cut is approved.

## 1. Collect the recording

- [ ] Wait for Zoom to finish converting the recording; play the resulting MP4.
- [ ] Keep an untouched copy of the recording and any separate audio tracks.
- [ ] Confirm the next episode number against `content/podcast/metadata/episodes.json`.
- [ ] Create an episode folder for the source, PilotCut project, exports,
  transcript, artwork, chapters and publishing notes.

## 2. Edit in PilotCut

- [ ] Check that PilotCut MCP's `help` and `stat` respond and identify the intended project.
  With several editor windows open, target the project explicitly:

  ```bash
  /Applications/PilotCut.app/Contents/MacOS/PilotCut tool call \
    --project /absolute/path/to/episode.pcbundle \
    --name stat --input-json '{"scope":"summary"}' --json
  ```

- [ ] Import the Zoom recording and save a `.pcbundle` project.
- [ ] Trim the wait before the first greeting and unnecessary material after the goodbye.
  Use the waveform and speech to choose the cuts; leave room for breaths and complete words.
- [ ] Keep natural pauses unless a tighter edit is intended. Check both speakers' audio levels.
- [ ] Add brief opening and closing fades, plus an opening title and `dabase.com/podcast/`.
- [ ] Keep framing, captions, fades and further video edits in PilotCut so they remain editable.
- [ ] Review the opening, ending, speaker switches, screen shares and every edited join.

## 3. Export and check the initial full cut

- [ ] Export the initial full YouTube cut as an H.264/AAC MP4, normally
  1920×1080 at the recording's frame rate.
- [ ] Check duration, dimensions, codecs, sound at both ends and playback through each cut.
  Decode the complete video to catch damaged or truncated exports.

## 4. User review and approval

- [ ] Give the user a playable link or local path to the full review cut and a
  short description of the edits. Do not substitute teaser clips for this review.
- [ ] Wait for explicit approval of the full cut before creating any shorts or teasers.
- [ ] Apply requested revisions in PilotCut, export the revised full cut and
  obtain approval for that version.
- [ ] Keep the approved video as the YouTube master. Export the podcast MP3
  from the same approved timeline and check its complete decode and duration.
- [ ] Record the MP3's exact byte length and duration for the RSS enclosure.

## 5. Prepare the title, chapters and transcript

- [ ] Choose a descriptive title, a short page/feed description and a longer episode summary.
- [ ] Create chapters from the final edited timeline, beginning at `00:00`.
  Check that each timestamp reaches the intended topic.
- [ ] Generate and correct the transcript, especially names and product names.
  Keep WebVTT and plain-text versions; check that the last cue fits within the episode.
- [ ] Put recurring caption corrections in `content/podcast/metadata/transcript-corrections.sed`.
- [ ] Keep the title, descriptions, chapters and export paths together in the episode folder.

## 6. Make the thumbnail and teasers after approval

- [ ] Duplicate the previous episode's Excalidraw design rather than changing its original scene.
- [ ] Reuse the hosts' transparent cutouts, update the episode number and headline,
  and include `dabase.com/podcast/`.
- [ ] Check readability at thumbnail size, margins and centering inside the episode badge.
- [ ] Save the editable `.excalidraw` file and a 1280×720 thumbnail.
  Prepare separate square podcast artwork, 1400×1400 or larger, without clipping the design.
- [ ] Select a few self-contained teaser moments that preserve the speakers' meaning.
  Use the approved full cut as the source for every teaser.
- [ ] Make each teaser in PilotCut in both 1080×1920 (YouTube Shorts) and
  1080×1080 (LinkedIn), with readable captions and framing suited to each format.
- [ ] Review captions, faces, endings and the rendered badge in every export.

## 7. User uploads the full video to YouTube

- [ ] Give the user the approved MP4, thumbnail, title, description and chapters
  for manual upload in YouTube Studio.
- [ ] Set the title, description, chapters and approved thumbnail.
- [ ] Add it at the newest end of the existing
  [AI Infrastructure playlist](https://www.youtube.com/playlist?list=PLiKgVPlhUNuyTXzN03gCB1lqvaHXxPLak).
  Playlist order determines episode numbering during metadata refreshes.
- [ ] Wait for processing, check playback and confirm the intended visibility.
- [ ] Record the canonical `https://www.youtube.com/watch?v=VIDEO_ID` URL and video ID,
  without the share link's tracking parameter. Do not create the blog page with a placeholder ID.
- [ ] Wait for the user to supply the YouTube URL before publishing the blog and feed.

## 8. Prepare the website and upload its media

- [ ] Work in this repository's `main` checkout, pull with `git pull --ff-only`,
  and preserve unrelated local changes.
- [ ] Fetch the new video's metadata into `content/podcast/metadata/cache/VIDEO_ID.json`.
  Validate the JSON before replacing a cache file. If YouTube rejects an anonymous fetch,
  retry with `yt-dlp --cookies-from-browser chrome`.
- [ ] Refresh `metadata/episodes.json` and verify the episode number, video ID,
  title, duration and chronological order. Keep a stable page slug and publication date;
  use `metadata/episode-overrides.json` when they differ from the generated values.
- [ ] Create or review `content/podcast/NNN-slug.md`, including the audio URL,
  exact `audioSize`, YouTube link, artwork, description and linked chapters.
  The publication date must not be in the future in UTC.
- [ ] Put the approved assets in `.audio/`, `.images/` and `.transcripts/` under
  `content/podcast/`. These media files belong on S3, not in the Git commit.
- [ ] Upload the MP3, both artwork variants, WebVTT and plain-text transcript **before pushing**.
  CI cannot reliably download new audio from YouTube.

  The normal repository workflow, from `content/podcast`, is:

  ```bash
  redo all
  redo upload-audio upload-images upload-transcripts
  aws s3 ls s3://dabase.com/podcast/audio/ --profile mine --human-readable
  ```

  `redo all` refreshes playlist metadata, builds pages and runs the uploads;
  the explicit upload targets can also be rerun after correcting assets.
  For an episode already prepared locally, use its approved exports and verify
  the matching S3 objects instead of downloading a second copy from YouTube.
  If AWS credentials have expired, run `aws sso login --profile mine`.

- [ ] Check the actual public asset URLs: MP3 MIME type and exact byte length,
  byte-range seeking, square artwork, and nonempty transcripts with valid timing.
  If replacing a cached object at the same URL, invalidate its CloudFront cache.

## 9. Build, validate and publish the blog/feed

- [ ] Install the pinned search dependency with `npm ci` when needed, then run
  `redo site`, `redo check-blog` and `redo check-podcast` from the repository root.
  `redo site` does not refresh the YouTube playlist.
- [ ] Preview the new page: title, thumbnail, YouTube link, chapter links,
  audio player, transcript, archive listing and search result.
- [ ] Verify that the podcast RSS has exactly one new episode with the correct
  GUID, date, enclosure URL, byte length and duration. The ordinary site RSS
  should link to the episode page.
- [ ] Enable the link hook with `git config core.hooksPath .githooks`.
  Review `git diff`, then stage only the intended page, metadata, artwork sources
  or documentation; do not use `git add .` around local media exports.
- [ ] Commit and push to `main`. This starts the S3/CloudFront deployment.
- [ ] Wait for GitHub Actions to succeed and verify the live episode page,
  podcast archive and feeds. The deployment checks that the live feeds match the build.

## 10. User posts teasers; verify and archive

- [ ] Prepare the teaser files and suggested post copy with links to the full episode.
- [ ] The user reviews and posts to YouTube Shorts, LinkedIn and X manually.
  Supply the vertical versions for YouTube Shorts and the square versions for
  LinkedIn; existing exports can also be used on X.
- [ ] Check the existing show's listing in Apple Podcasts and Spotify after they refresh.
  A successful site deployment does not prove those directories have ingested the episode.
- [ ] Record the final page, video and promotional-post URLs; retain the source recording,
  PilotCut projects, Excalidraw source, approved exports and publishing notes.

For a replacement upload, follow the [replacement and feed-validation notes](../README.md#podcast-replacement-uploads).
Keep the episode GUID and original publication date, and use a new enclosure filename
so podcast clients fetch the corrected audio.
