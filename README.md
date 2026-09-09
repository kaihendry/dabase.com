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
