![Deploy Hugo site to S3/Cloudfront](https://github.com/kaihendry/dabase.com/workflows/Deploy%20Hugo%20site%20to%20S3/Cloudfront/badge.svg)

# An ex-ikiwiki site on Hugo

https://search.google.com/search-console?resource_id=sc-domain%3Adabase.com&hl=en

https://www.youtube.com/watch?v=PmbVccyFY7U

# Terraform

See the [terraform](terraform/) directory.

# Podcast replacement uploads

`content/podcast/metadata/episode-overrides.json` preserves an existing episode's title, page slug and
publication date when its replacement upload has a different YouTube title.
The page slug is also the podcast feed GUID, so keep it unchanged. Set
`audioSlug` to a new filename to make podcast clients fetch the edited audio.

After replacing a video in the playlist, refresh `episodes.json`, rebuild that
episode's page, artwork and transcripts, and upload its assets before deploying.
Fetch the audio for the new `audioSlug`; never reuse audio from the old upload.
Also replace the old S3 audio object with the edited recording for clients that
still have the previous enclosure URL, then invalidate its CloudFront cache.

Remove the old video metadata, summary cache and slides from the source tree.
If YouTube has not generated captions yet, clear the old hosted transcript and
rebuild the replacement transcript once captions are available.

# Podcast feed validation

Run `redo check-podcast` before pushing (Python 3 and FFmpeg required). It builds
Hugo and validates both the podcast RSS and the site's ordinary news RSS.
The podcast feed is `https://dabase.com/podcast/index.xml`; the news feed links
to episode pages and does not contain podcast audio enclosures.

The validator checks episode membership, stable GUIDs and publication dates,
the current enclosure URL, exact hosted byte length, HTTP MIME types, real
byte-range seeking, nonempty transcripts within the episode duration, and
square artwork. Deep checks download and decode the newest episode and pinned
replacement recordings, comparing duration and SHA-256. For replacements, put
the verified `audioSha256` and any `legacyAudioUrls` in `episode-overrides.json`
so the old download URL cannot silently start serving the retired audio again.

The same checks run on pull requests, before deployment and daily. Deployment
also verifies the live feeds after CloudFront invalidation completes. A failed
pre-deployment check blocks publishing. XML is synced without `--size-only` so
same-length feed corrections are still deployed, and the live feeds must match
the build. To check the live feeds manually:

```bash
python3 scripts/validate_podcast.py --deep \
  --feed https://dabase.com/podcast/index.xml \
  --site-feed https://dabase.com/index.xml
```

These checks validate our feed and hosting, not directory ingestion or copies
already downloaded by listeners. Apple and Spotify may take up to 24 hours to
refresh. Check the existing show's episode in their creator dashboards after
a replacement; preserve the GUID and use a new enclosure URL rather than
publishing a duplicate episode. Keep serving edited audio at the old URL too.

References: [Apple RSS requirements](https://podcasters.apple.com/support/823-podcast-requirements),
[Apple metadata updates](https://podcasters.apple.com/support/832-podcast-metadata),
[Spotify delivery specification](https://providersupport.spotify.com/article/podcast-delivery-specification-1-9),
[Spotify update delays](https://support.spotify.com/us/creators/article/new-episodes-or-podcast-updates-not-appearing-on-listening-platforms/).
