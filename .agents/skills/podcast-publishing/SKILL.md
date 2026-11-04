---
name: podcast-publishing
description: Produce and publish an AI Infrastructure podcast episode on dabase.com, from the Zoom recording through editing, YouTube upload (monetization and playlist), S3 media, the episode page and feeds, and teasers. Use for new episodes, re-uploads and replacements of published podcast audio.
---

# Podcast publishing

Start with a completed Zoom recording. Finish with a working episode page,
podcast feed entry, YouTube video and promotional clips.

The agent runs the editing, asset preparation, metadata, S3 uploads and blog/feed
publishing steps. The user reviews the full cut, uploads it to YouTube or
authorises an agent to, and posts the teasers. Access problems such as expired
AWS credentials may still need the user.

The order is: **Zoom recording → full review cut → user approval → final assets
and teasers → YouTube upload → YouTube URL → blog/feed publication.** Do not make
shorts or teasers before the full cut is approved.

## 1. Collect the recording

- [ ] Wait for Zoom to finish converting the recording; play the resulting MP4.
- [ ] Keep an untouched copy of the recording and any separate audio tracks.
  Copy separate recorders (such as a DJI Mic lav) and extra camera angles off
  their cards, with SHA-256 checksums, and edit from the local copies.
- [ ] Confirm the next episode number against `content/podcast/metadata/episodes.json`.
- [ ] Create an episode folder for the sources, edit project or cut list, exports,
  transcript, artwork, chapters and publishing notes.

## 2. Edit

Edit in PilotCut, which keeps the project editable in a GUI, or with an ffmpeg cut
list, which suits precise multi-source sync. EP47's episode folder has a reusable
cut-list renderer (`review/render.py`), aligner, gate and echo canceller.

- [ ] With PilotCut, check that its MCP `help` and `stat` respond and identify the
  intended project. With several editor windows open, target the project explicitly:

  ```bash
  /Applications/PilotCut.app/Contents/MacOS/PilotCut tool call \
    --project /absolute/path/to/episode.pcbundle \
    --name stat --input-json '{"scope":"summary"}' --json
  ```

- [ ] Trim the wait before the first greeting and unnecessary material after the goodbye.
  Use the waveform and speech to choose the cuts; leave room for breaths and complete words.
- [ ] Keep natural pauses unless a tighter edit is intended. Check both speakers' audio levels.
- [ ] Prefer a separate lav recording to Zoom's compressed audio. Align it to the
  host's Zoom track by cross-correlation and measure clock drift: a few ppm is
  about 20 ms over 90 minutes.
- [ ] If the host listened on speakers, the lav also records the guest about 0.2 s
  late, which is audible as echo. Gate the lav using Zoom's echo-cancelled track of
  the host as the key, and cancel the remaining echo with the guest's Zoom track as
  reference (EP47 `review/aec.py` and `review/patch_echo.py`). Headphones avoid it.
- [ ] Sync extra camera angles by audio, correct for drift, and keep screen shares
  visible rather than covering them with cutaways.
- [ ] Add brief opening and closing fades, plus an opening title and `dabase.com/podcast/`.
- [ ] Review the opening, ending, speaker switches, screen shares and every edited join.

## 3. Export and check the full cut

- [ ] Export the full YouTube cut as an H.264/AAC MP4, normally
  1920×1080 at the recording's frame rate.
- [ ] Check duration, dimensions, codecs, sound at both ends and playback through each cut.
  Decode the complete video to catch damaged or truncated exports.

## 4. User review and approval

- [ ] Give the user a playable link or local path to the full review cut and a
  short description of the edits. Do not substitute teaser clips for this review.
- [ ] Wait for explicit approval of the full cut before creating any shorts or teasers.
- [ ] Apply requested revisions, export the revised full cut and obtain approval
  for that version.
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
  Every transcript and page depends on it, so an edit rebuilds the back catalogue
  from YouTube; avoid rules that could rewrite URLs, such as lowercase domain names.
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
- [ ] Make each teaser in both 1080×1920 (YouTube Shorts) and 1080×1080 (LinkedIn),
  with readable captions and framing suited to each format.
- [ ] Review captions, faces, endings and the rendered badge in every export.

## 7. Upload the full video to YouTube

The user uploads it in YouTube Studio, or authorises an agent to upload it in their Chrome.

- [ ] Use the approved MP4, thumbnail, title, description and chapters.
- [ ] Set **Earn / Monetization → Watch Page ads & YouTube Premium → On** for full
  episodes, including **Unlisted** ones, unless the user explicitly requests otherwise.
  Continue with **Next** or **Done** and save, then reopen the video's monetization
  page and verify **On** persisted. This is Kai's standing preference: do not copy
  **Off** from older episodes or stale upload notes, and include **Monetization: On**
  in any episode-specific upload instructions or handoff.
- [ ] Add it at the newest end of the existing
  [AI Infrastructure playlist](https://www.youtube.com/playlist?list=PLiKgVPlhUNuyTXzN03gCB1lqvaHXxPLak).
  **This includes unlisted uploads.** Keep the requested video visibility;
  unlisted visibility is not a reason to omit playlist membership. Playlist order
  determines episode numbering during metadata refreshes.
- [ ] Click **Done** in the playlist picker and **Save** in video details, then
  verify that **AI Infrastructure** remains selected after reopening the video.
  Do not report the upload complete until playlist membership is saved and verified.
- [ ] Wait for processing, check playback and confirm the intended visibility.
- [ ] Record the canonical `https://www.youtube.com/watch?v=VIDEO_ID` URL and video ID,
  without the share link's tracking parameter. Do not create the blog page with a placeholder ID.

## 8. Prepare the website and upload its media

- [ ] Work in this repository's `main` checkout, pull with `git pull --ff-only`,
  and preserve unrelated local changes.
- [ ] Fetch the new video's metadata into `content/podcast/metadata/cache/VIDEO_ID.json`.
  Validate the JSON before replacing a cache file. If YouTube rejects an anonymous fetch,
  retry with `yt-dlp --cookies-from-browser chrome`.
- [ ] Add the episode's stable title, page slug and publication date to
  `metadata/episode-overrides.json`, then refresh `metadata/episodes.json` from
  `content/podcast`. It is committed and a redo target, so goredo may answer
  `externally modified: not redoing`; delete it and run `redo metadata/episodes.json`.
  Verify the episode number, video ID, title, duration and order, and that
  `git diff` shows only the new entry.
- [ ] Generate `summarize --timestamps --slides` output for **every podcast blog
  entry**, including pages prepared manually. Use the supplied YouTube video's
  real ID in place of `VIDEO_ID`:

  ```bash
  podcast_summary_dir=$(mktemp -d)
  summarize "https://youtu.be/VIDEO_ID" --timestamps --slides --no-cache \
    --slides-dir "$podcast_summary_dir" --json > "$podcast_summary_dir/summary.json"
  ```

  Generate slides in a temporary directory so summarize's cache cleanup cannot
  remove published slides. If YouTube blocks access, retry with
  `SUMMARIZE_YT_DLP_COOKIES_FROM_BROWSER=chrome` before the command.
- [ ] Check `extracted.transcriptSource` in the JSON. A new upload has no captions
  for a while, and summarize may then return only the YouTube description. Keep that
  run's slides, and summarize the approved timed transcript instead, with an explicit
  prompt and a working model:

  ```bash
  summarize timed-transcript.txt --timestamps --length long --force-summary \
    --cli claude --json --prompt "Summarize this podcast conversation faithfully in English, \
  with an introduction and six chronological topic sections using [HH:MM:SS] timestamps. \
  Preserve disagreements and attribute opinions to the speakers. …"
  ```

  Disclose the method in the summary's attribution line, as EP46 and EP47 do.
- [ ] Review the generated summary against the episode: correct names, check
  topic timestamps, and match each slide to the discussion it illustrates.
  Save the validated JSON in `content/podcast/metadata/summaries/VIDEO_ID.json`
  and copy the completed `youtube-VIDEO_ID/` slide directory into
  `static/podcast/slides/VIDEO_ID/`.
- [ ] Include the reviewed output under the heading
  ``## `summarize "https://youtu.be/VIDEO_ID" --timestamps --slides` ``.
  Link timestamps and slide images to the corresponding YouTube times, use
  `/podcast/slides/VIDEO_ID/youtube-VIDEO_ID/` image URLs, and retain the model
  attribution. `content/podcast/default.md.do` formats this section for generated
  pages; append it to manually prepared pages while preserving their existing
  frontmatter, introduction and chapters. Missing or failed summary/slide output
  means the page is incomplete; resolve it before publishing.
- [ ] Create or review `content/podcast/NNN-slug.md`, including the audio URL,
  exact `audioSize`, YouTube link, artwork, description and linked chapters.
  The publication date must not be in the future in UTC.
  Set `podcast.youtubeId` to the uploaded video's ID: the episode template uses
  [Hugo's YouTube shortcode](https://gohugo.io/shortcodes/youtube/) to embed it
  above the audio player automatically.
- [ ] Put the approved assets in `.audio/`, `.images/` and `.transcripts/` under
  `content/podcast/`. These media files belong on S3, not in the Git commit.
- [ ] Upload the MP3, both artwork variants, WebVTT and plain-text transcript
  **before pushing**. CI cannot reliably download new audio from YouTube.

  Run `redo-ood` first. The `upload-*` targets, like `redo all`, `redo-ifchange`
  every episode's audio and transcript, so after a metadata refresh they can
  re-download older episodes from YouTube and sync them over approved replacements.
  In November 2026 this overwrote EP43's pinned replacement audio. If anything other
  than the new episode is out of date, upload just the new files with the targets'
  headers:

  ```bash
  S=NNN-slug; B=s3://dabase.com/podcast; A=(--profile mine --region ap-southeast-1)
  aws s3 cp .audio/$S.mp3 $B/audio/ "${A[@]}" --content-type audio/mpeg --cache-control "public, max-age=31536000"
  for f in $S.jpg $S-wide.jpg; do
    aws s3 cp .images/$f $B/images/ "${A[@]}" --content-type image/jpeg --cache-control "public, max-age=31536000"
  done
  aws s3 cp .transcripts/$S.vtt $B/transcripts/ "${A[@]}" --content-type "text/vtt; charset=utf-8" --cache-control "public, max-age=86400"
  aws s3 cp .transcripts/$S.txt $B/transcripts/ "${A[@]}" --content-type "text/plain; charset=utf-8" --cache-control "public, max-age=86400"
  ```

  If AWS credentials have expired, run `aws sso login --profile mine`.
- [ ] Check the actual public asset URLs: MP3 MIME type and exact byte length,
  byte-range seeking, square artwork, and nonempty transcripts with valid timing.
  If replacing a cached object at the same URL, invalidate its CloudFront cache.

## 9. Build, validate and publish the blog/feed

- [ ] Install the pinned search dependency with `npm ci` when needed, then run
  `redo site`, `redo check-blog` and `redo check-podcast` from the repository root.
  `redo site` does not refresh the YouTube playlist. `check-podcast` also
  deep-checks pinned replacement audio, and the same check blocks deployment.
- [ ] Preview the new page: title, YouTube player and direct link, chapter links,
  audio player, transcript, timestamped summarize section, slides, archive listing
  and search result. Confirm every summary image loads and its timestamp link
  reaches the intended moment. Check the embedded video plays and fits the page
  on desktop and mobile.
- [ ] Verify that the podcast RSS has exactly one new episode with the correct
  GUID, date, enclosure URL, byte length and duration. The ordinary site RSS
  should link to the episode page.
- [ ] Enable the link hook with `git config core.hooksPath .githooks`.
  Review `git diff`, then stage only the intended page, metadata (including the
  summary and video caches), slide images and manifest, artwork sources or documentation;
  do not use `git add .` around local media exports.
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
  edit projects or cut lists, Excalidraw source, approved exports and publishing notes.

## Replacing published podcast audio

Follow the [replacement and feed-validation notes](../../../README.md#podcast-replacement-uploads).
In short:

- Keep the episode's page slug (its feed GUID) and publication date.
- Render the corrected MP3 from the same timeline and check its decode, duration and byte length.
- In `episode-overrides.json`, set a new `audioSlug` so podcast clients fetch it, its
  `audioSha256`, and the old enclosure under `legacyAudioUrls`. Point the page's
  `audioUrl` at the new file and refresh `episodes.json`.
- Upload the new file, overwrite the old URL with the corrected audio, and invalidate
  that path: `aws cloudfront create-invalidation --distribution-id E6OVXGA61L6G6 --paths /podcast/audio/OLD.mp3 --profile mine`.
- `redo check-podcast` verifies both URLs against `audioSha256` before you push.
- A YouTube video's audio cannot be replaced in place.

## Generator and pipeline notes

- **Episodes come only from the playlist.** `metadata/episodes.json.do` enumerates the
  AI Infrastructure playlist (`PLiKgVPlhUNuyTXzN03gCB1lqvaHXxPLak`). Episode numbers
  come from playlist position, reversed, so the newest video gets the highest number.
  A video missing from the playlist generates no page, and the build looks like a
  no-op; add it to the playlist rather than working around the script.
  `NON_EPISODES` in `pages.do` lists playlist videos that are not episodes.
- **Pages and `episodes.json` are committed redo targets**, because GitHub Actions
  can't run `yt-dlp`. redo won't rebuild a target it has no record of building, and
  `.redo/` is gitignored; `redo -f` respects that too:

      warn 040-benchmarking-ai-infrastructure.md: already existing: not redoing

  So editing `default.md.do` appears to work while changing only brand-new episodes.
  Run `redo regen` (see `regen.do`) to rebuild the back catalogue, then review
  `git diff`. With no pipeline change a regen is a no-op in git. A hand-written
  episode page is never overwritten by redo.
- **Cache:** episode metadata is cached in `metadata/cache/{video_id}.json`.
  `FORCE=1 redo metadata/episodes.json` bypasses the cache and refetches every episode.
- **Transcripts** are cleaned YouTube auto-captions built by `default.vtt.do` and
  `default.txt.do` into `.transcripts/`, synced to `s3://dabase.com/podcast/transcripts/`,
  referenced by `<podcast:transcript>` in the feed and rendered on episode pages.
  After editing `transcript-corrections.sed`, rebuild with
  `redo .transcripts/*.vtt .transcripts/*.txt && redo upload-transcripts`.
- **YouTube bot detection:** if `yt-dlp` reports "Sign in to confirm you're not a bot", use Chrome cookies:
  - metadata: `yt-dlp --cookies-from-browser chrome -j --no-warnings --skip-download "URL" > metadata/cache/VIDEO_ID.json`
  - audio: `yt-dlp --cookies-from-browser chrome --extract-audio --audio-format mp3 --audio-quality 192K --output ".audio/SLUG" --no-playlist "URL"`
  - summary: `SUMMARIZE_YT_DLP_COOKIES_FROM_BROWSER=chrome summarize "URL" --timestamps --slides ...`
- **Hugo drops content silently:** a `date` in the future (compare against `date -u`)
  or a `draft:` key hides a page. We don't use drafts; omit the key.
