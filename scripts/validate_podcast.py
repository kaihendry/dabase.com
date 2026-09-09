#!/usr/bin/env python3
"""Check our podcast RSS and public media. Python stdlib; --deep needs FFmpeg.

Requirements: https://podcasters.apple.com/support/823-podcast-requirements
https://providersupport.spotify.com/article/podcast-delivery-specification-1-9
This checks the origin feed, not directory ingestion or listeners' downloads.
"""

import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime, timezone
from email.utils import parsedate_to_datetime
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys
import tempfile
from urllib.request import Request, urlopen
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
BASE = "https://dabase.com"
FEED = BASE + "/podcast/index.xml"
ITUNES = "{http://www.itunes.com/dtds/podcast-1.0.dtd}"
ATOM = "{http://www.w3.org/2005/Atom}"
PODCAST = "{https://podcastindex.org/namespace/1.0}"


def require(condition, message):
    if not condition:
        raise ValueError(message)


def request(url, method="GET", headers=None):
    return urlopen(Request(url, method=method, headers={
        "User-Agent": "dabase-podcast-validator/1.0", **(headers or {})
    }), timeout=60)


def read_feed(location):
    if location.startswith("https://"):
        with request(location) as response:
            require(response.status == 200, "RSS GET must return 200")
            require(response.headers.get_content_type() in
                    {"application/xml", "application/rss+xml", "text/xml"},
                    "RSS has an invalid HTTP Content-Type")
            data = response.read(5_000_001)
    else:
        data = Path(location).read_bytes()
    require(len(data) <= 5_000_000, "Unexpectedly large feed")
    require(b"<!DOCTYPE" not in data.upper(), "RSS must not contain a DTD")
    tree = ET.fromstring(data.decode("utf-8"))
    require(tree.tag == "rss" and tree.get("version") == "2.0", "Expected RSS 2.0")
    channel = tree.find("channel")
    require(channel is not None, "RSS has no channel")
    return channel


def date(value):
    parsed = parsedate_to_datetime(value)
    require(parsed.tzinfo is not None, "RSS date must include a timezone")
    require(parsed <= datetime.now(timezone.utc), "RSS date is in the future")
    return parsed


def expected_episodes():
    metadata = json.loads((ROOT / "content/podcast/metadata/episodes.json").read_text())
    by_slug = {e["slug"]: e for e in metadata}
    require(len(by_slug) == len(metadata), "Duplicate slug in playlist metadata")
    slugs = {p.stem for p in (ROOT / "content/podcast").glob("[0-9]*.md")}
    require(slugs <= by_slug.keys(), "Episode page missing from playlist metadata")
    return {BASE + "/podcast/" + slug + "/": by_slug[slug] for slug in slugs}


def validate_structure(channel, expected):
    for tag in ["title", "link", "description", "language", ITUNES + "author"]:
        require((channel.findtext(tag) or "").strip(), "Missing channel " + tag)
    require(channel.findtext(ITUNES + "explicit") in {"yes", "no", "true", "false"},
            "Missing/invalid show explicit flag")
    require(channel.find(ITUNES + "category") is not None, "Missing show category")
    require(channel.find(ITUNES + "image") is not None, "Missing show artwork")
    self_links = [e.get("href") for e in channel.findall(ATOM + "link") if e.get("rel") == "self"]
    require(self_links == [FEED], "Incorrect RSS self URL")
    modified = date(channel.findtext("lastBuildDate", ""))
    items = channel.findall("item")
    guids = [i.findtext("guid") for i in items]
    require(len(guids) == len(set(guids)), "Duplicate episode GUID")
    require(set(guids) == set(expected), "RSS episode set differs from published Markdown pages")
    urls = set()
    for item in items:
        guid = item.findtext("guid")
        e = expected[guid]
        label = f"Episode {e['episode']}"
        require(item.findtext("link") == guid, label + ": page URL/GUID changed")
        require((item.findtext("title") or "").strip(), label + ": missing title")
        published = date(item.findtext("pubDate", ""))
        require(modified >= published, "lastBuildDate predates an episode")
        if e.get("publishDate"):
            require(published == datetime.fromisoformat(e["publishDate"].replace("Z", "+00:00")),
                    label + ": replacement changed original publication date")
        for tag, value in [("episode", e["episode"]), ("season", e["season"]), ("duration", e["duration"])]:
            require(item.findtext(ITUNES + tag) == str(value), label + ": wrong " + tag)
        require(e["duration"] > 0, label + ": invalid duration")
        enclosures = item.findall("enclosure")
        require(len(enclosures) == 1, label + ": expected exactly one enclosure")
        enclosure = enclosures[0]
        url = enclosure.get("url")
        wanted = BASE + "/podcast/audio/" + e.get("audioSlug", e["slug"]) + ".mp3"
        require(url == wanted, label + ": enclosure does not use current upload: " + str(url))
        require(url not in urls, "Duplicate audio enclosure URL")
        urls.add(url)
        require(enclosure.get("type") == "audio/mpeg", label + ": wrong enclosure MIME type")
        require(int(enclosure.get("length", "0")) > 0, label + ": invalid enclosure byte length")
        transcript = item.find(PODCAST + "transcript")
        require(transcript is not None and transcript.get("type") == "text/vtt", label + ": missing VTT transcript")
        require(transcript.get("url") == BASE + "/podcast/transcripts/" + e["slug"] + ".vtt",
                label + ": incorrect transcript URL")
    return items


def validate_site_feed(channel, expected):
    items = [i for i in channel.findall("item") if i.findtext("guid") in expected]
    require({i.findtext("guid") for i in items} == set(expected), "Site RSS is missing podcast pages")
    require(len(items) == len(expected), "Site RSS duplicates a podcast page")
    for item in items:
        require(item.findtext("link") == item.findtext("guid"), "Site RSS has an incorrect episode link")


def compare_feed(actual, reference):
    require(ET.tostring(actual) == ET.tostring(reference),
            "Deployed RSS differs from this build (possibly a skipped same-size upload)")


def check_audio(url, length):
    with request(url, "HEAD") as response:
        require(response.status == 200, url + ": HEAD must return 200")
        require(response.headers.get_content_type() == "audio/mpeg", url + ": wrong HTTP MIME type")
        require(int(response.headers.get("Content-Length", 0)) == length,
                url + ": RSS length differs from hosted audio size")
    # A nonzero offset checks real seeking, rather than just the first bytes.
    start = min(65536, length // 2)
    end = min(start + 1023, length - 1)
    with request(url, headers={"Range": f"bytes={start}-{end}"}) as response:
        require(response.status == 206, url + ": server ignored byte-range request")
        require(response.headers.get("Content-Range") == f"bytes {start}-{end}/{length}",
                url + ": incorrect Content-Range")
        require(len(response.read(end - start + 2)) == end - start + 1, url + ": truncated range response")


def check_transcript(url, duration):
    with request(url) as response:
        require(response.status == 200 and response.headers.get_content_type() == "text/vtt",
                url + ": transcript not served as WebVTT")
        text = response.read(5_000_001).decode("utf-8")
    require(text.startswith("WEBVTT") and "-->" in text, url + ": empty or invalid transcript")
    ends = re.findall(r"--> (\d+):(\d{2}):(\d{2})\.(\d{3})", text)
    require(ends, url + ": no timed transcript cues")
    last = max(int(h)*3600 + int(m)*60 + int(s) + int(ms)/1000 for h, m, s, ms in ends)
    require(last <= duration + 3, url + ": transcript extends beyond replacement audio")


def probe(path):
    output = subprocess.run(["ffprobe", "-v", "error", "-show_format", "-show_streams", "-of", "json", str(path)],
                            check=True, capture_output=True, text=True, timeout=60)
    return json.loads(output.stdout)


def check_artwork(url):
    with request(url) as response:
        require(response.status == 200 and response.headers.get_content_type() in {"image/jpeg", "image/png"},
                url + ": invalid artwork response")
        data = response.read(10_000_001)
    require(len(data) <= 10_000_000, url + ": artwork exceeds 10 MB")
    with tempfile.NamedTemporaryFile() as file:
        file.write(data); file.flush()
        stream = probe(file.name)["streams"][0]
    require(stream["width"] == stream["height"] and 1400 <= stream["width"] <= 3000,
            url + ": artwork must be square, 1400–3000 pixels")


def check_recording(url, episode, length):
    with tempfile.NamedTemporaryFile(suffix=".mp3") as file:
        digest = hashlib.sha256()
        with request(url) as response:
            require(response.status == 200, url + ": audio download failed")
            while chunk := response.read(1024 * 1024):
                file.write(chunk); digest.update(chunk)
                require(file.tell() <= length, url + ": download larger than enclosure length")
        require(file.tell() == length, url + ": incomplete audio download")
        file.flush()
        if episode.get("audioSha256"):
            require(digest.hexdigest() == episode["audioSha256"], url + ": audio differs from approved replacement")
        info = probe(file.name)
        audio = [s for s in info["streams"] if s["codec_type"] == "audio"]
        require(len(audio) == 1 and audio[0]["codec_name"] == "mp3", url + ": expected one MP3 audio stream")
        require(int(audio[0]["sample_rate"]) in {22050, 24000, 44100, 48000}, url + ": unsupported sample rate")
        require(audio[0]["channels"] in {1, 2}, url + ": unsupported channel count")
        require(abs(float(info["format"]["duration"]) - episode["duration"]) <= 2,
                url + ": actual audio duration differs from RSS")
        # Detect damaged frames anywhere, not just a valid MP3 header.
        result = subprocess.run(["ffmpeg", "-v", "error", "-xerror", "-i", file.name, "-f", "null", "-"],
                                capture_output=True, text=True, timeout=300)
        require(result.returncode == 0 and not result.stderr.strip(), url + ": audio fails complete decoding")
    return digest.hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--feed", default=str(ROOT / "public/podcast/index.xml"))
    parser.add_argument("--site-feed", default=str(ROOT / "public/index.xml"))
    parser.add_argument("--reference-dir", type=Path, help="Require live RSS to match this Hugo output directory")
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--skip-media", action="store_true", help="Check feed structure/identity only")
    mode.add_argument("--deep", action="store_true", help="Download/decode newest and pinned replacement audio, including legacy URLs")
    args = parser.parse_args()
    try:
        expected = expected_episodes()
        channel = read_feed(args.feed)
        items = validate_structure(channel, expected)
        site_channel = read_feed(args.site_feed)
        validate_site_feed(site_channel, expected)
        if args.reference_dir:
            compare_feed(channel, read_feed(str(args.reference_dir / "podcast/index.xml")))
            compare_feed(site_channel, read_feed(str(args.reference_dir / "index.xml")))
        print(f"PASS: both RSS feeds, {len(items)} episodes, GUIDs, enclosure URLs, dates and durations")
        if args.skip_media:
            return 0
        jobs = []
        images = {channel.find(ITUNES + "image").get("href")}
        for item in items:
            e = expected[item.findtext("guid")]
            enclosure = item.find("enclosure")
            jobs += [(check_audio, enclosure.get("url"), int(enclosure.get("length"))),
                     (check_transcript, item.find(PODCAST + "transcript").get("url"), e["duration"])]
            image = item.find(ITUNES + "image")
            if image is not None:
                images.add(image.get("href"))
        jobs += [(check_artwork, url) for url in images]
        failures = []
        with ThreadPoolExecutor(max_workers=6) as pool:
            futures = [pool.submit(fn, *values) for fn, *values in jobs]
            for future in as_completed(futures):
                try:
                    future.result()
                except Exception as error:
                    failures.append(str(error))
        require(not failures, "\n".join(failures))
        print(f"PASS: {len(items)} audio sizes/MIME types/ranges and transcripts; {len(images)} artwork files")
        if args.deep:
            newest = max(items, key=lambda i: date(i.findtext("pubDate")))
            for item in items:
                e = expected[item.findtext("guid")]
                if item is not newest and not e.get("audioSha256"):
                    continue
                enclosure = item.find("enclosure")
                urls = [enclosure.get("url"), *e.get("legacyAudioUrls", [])]
                for url in urls:
                    length = int(enclosure.get("length"))
                    check_audio(url, length)
                    digest = check_recording(url, e, length)
                    print(f"PASS: full decode, duration and SHA-256 {digest}: {url}")
        return 0
    except Exception as error:
        print(f"FAIL: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
