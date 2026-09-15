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

## Blog tags

Add one or two reusable topics in a post's frontmatter when useful, for example
`tags: [audio-video]`. Reuse the tags listed at `/tags/`; introduce a new tag only
when it connects at least two posts. Untagged posts are fine.

Keep the vocabulary to these eight topics for now:

| Tag | Use for |
| --- | --- |
| `ai` | AI tools, coding workflows, costs and adoption |
| `audio-video` | Cameras, microphones, lighting, recording and editing |
| `ci-cd` | Building, testing, releasing and deploying software |
| `database` | Database setup, access, performance and infrastructure |
| `home-energy` | Home heating, energy monitoring, insulation and power resilience |
| `iac` | Infrastructure as code with Terraform, CloudFormation, CDK and GitOps |
| `networking` | WiFi, broadband, routing, DNS and network configuration |
| `security` | Identity, secrets, permissions and security controls |

Use two tags when both are central to the article, such as
`tags: [iac, ci-cd]` for an infrastructure deployment pipeline. Tag the main
subject, not every technology mentioned; leave drafts and unrelated posts untagged.

Tag links lead to an archive of matching posts. Blog articles show up to three
related posts based only on shared tags, including newer articles so older posts
can link to follow-ups. Hugo builds these links without additional JavaScript.
Tag labels and related lists are excluded from the Pagefind search index.

## Metadata and historical posts

Every published blog post should have a descriptive `title` and an honest
`description` summarising what the page actually contains. Avoid presenting a
bookmark or unfinished experiment as a complete guide. Blog URLs use the file
basename, so editing a blog title does not change its URL. Tips have a different,
title-based permalink scheme: take care when editing their titles.

Use `historical: "A specific explanation of what is obsolete or incomplete"`
to show a notice above the preserved article. Historical posts remain in the
chronological archive and a separate expandable group on tag pages. They are
excluded from homepage recommendations, related-post suggestions, news feeds
and Pagefind. Substantive firsthand history can still be indexed by search
engines. Age alone is not a reason to hide a page.

Add `noindex: true` only for clear dead ends, such as expired offers, unusable
stubs or misleading configuration examples. Always explain the decision with
`historical`. The page stays accessible at its original URL, but its robots meta
tag requests exclusion from search engines and it is omitted from the sitemap.
Do not block it in robots.txt: crawlers must be able to read the noindex rule.
See the [content review](docs/content-review.md) for the initial decisions.

Set `lastmod` only after a substantive content update or technical review.
Git commit dates, tagging and metadata edits do not imply refreshed advice.
News RSS keeps the original publication date. Indexable blog posts emit
BlogPosting JSON-LD using the visible title, description and these dates.

Social cards use `thumbnail` (preferred), `image`, or a suitable image already
in the article. Relative thumbnail paths resolve within a page bundle; root
paths and absolute URLs also work. Set `image_alt` for an explicit thumbnail.
Text-only posts use a summary card. Historical posts do not automatically pick
an image. The recent AVIF photo posts have small JPEG `preview.jpg` copies for
social cards; the article still uses its original AVIF assets. A few older
previews live under `static/blog-previews/` because their original hosts send
the wrong image Content-Type.

Run `redo check-blog` after editing metadata or templates. It builds the site
and validates all published blog metadata, local blog links, JSON-LD, sitemap,
news dates and the actual Pagefind fragments. Deployment runs this check before
publishing. This is separate from the Markdown link hook and the required
`redo check-podcast` media checks.

# Terraform

See the [terraform](terraform/) directory.

# Podcast publishing

Follow the [publishing checklist](docs/podcast-publishing.md) from the Zoom
recording through PilotCut editing, artwork, YouTube upload, S3 media, blog/feed
validation and promotional clips.

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
