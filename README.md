![Deploy Hugo site to S3/Cloudfront](https://github.com/kaihendry/dabase.com/workflows/Deploy%20Hugo%20site%20to%20S3/Cloudfront/badge.svg)

# An ex-ikiwiki site on Hugo

## Build and preview

The site uses Hugo with a small local stylesheet in `assets/css/site.css`.
No CSS framework or web fonts are downloaded. Light and dark colours follow
the reader's system preference.
Navigation uses five locally stored Octicons as inline SVGs, including the
GitHub mark. They inherit the text colour and need no JavaScript, icon font,
or additional network requests; their license is in `static/licenses/octicons.txt`.

Install Node.js (24 LTS recommended), then build the site and its pinned
[Pagefind](https://pagefind.app/) search index:

```bash
npm ci
redo site
python3 -m http.server 8000 --directory public
```

Open http://localhost:8000/ to preview, including `/search/?q=aws`.
`npm run build` is the equivalent build command used in CI. `redo site` does
not refresh podcast metadata or download audio. The existing `redo` target
still refreshes the podcast before building the site and search index.

`hugo server -D` remains useful for content and CSS work, but does not build or
serve the Pagefind bundle. Use the complete build above to test search after
content changes. The build cleans stale generated pages before indexing.

Search runs entirely in the browser using files deployed to S3. It indexes
individual articles and rendered podcast transcripts, with content-type
labels and publication dates. Navigation, backlinks and archive indexes are
excluded. Search JavaScript loads only on the search page; the homepage uses
a regular GET form. Tips remain available under the **Tips archive** label.
Episode lookups such as `ep30`, `ep 30`, and `episode 30` match the podcast's
episode number directly, rather than mentions of that number in transcripts.

CI builds the index before the S3 sync. The `pagefind/` prefix is synced
without `--size-only` so same-length metadata changes are deployed too.

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
