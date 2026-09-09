"""Regression checks for failures a simple HTTP-200 check misses."""
import copy
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import threading
import unittest
import xml.etree.ElementTree as ET

import validate_podcast as v


GUID = v.BASE + "/podcast/043-example/"
EPISODE = {"episode": 43, "season": 1, "slug": "043-example", "duration": 10,
           "audioSlug": "043-example-replacement", "publishDate": "2020-01-01T00:00:00Z"}


def channel():
    return ET.fromstring(f'''<channel xmlns:itunes="{v.ITUNES[1:-1]}"
        xmlns:atom="{v.ATOM[1:-1]}" xmlns:podcast="{v.PODCAST[1:-1]}">
      <title>Example</title><link>{v.BASE}/podcast/</link>
      <description>Example show</description><language>en-us</language>
      <lastBuildDate>Thu, 02 Jan 2020 00:00:00 +0000</lastBuildDate>
      <itunes:author>Example</itunes:author><itunes:explicit>no</itunes:explicit>
      <itunes:category text="Technology"/><itunes:image href="https://example.com/cover.jpg"/>
      <atom:link rel="self" href="{v.FEED}"/>
      <item><title>Example episode</title><link>{GUID}</link><guid>{GUID}</guid>
        <pubDate>Wed, 01 Jan 2020 00:00:00 +0000</pubDate>
        <itunes:episode>43</itunes:episode><itunes:season>1</itunes:season>
        <itunes:duration>10</itunes:duration>
        <enclosure url="{v.BASE}/podcast/audio/043-example-replacement.mp3" length="12345" type="audio/mpeg"/>
        <podcast:transcript url="{v.BASE}/podcast/transcripts/043-example.vtt" type="text/vtt"/>
      </item></channel>''')


class FeedTests(unittest.TestCase):
    def test_valid_replacement(self):
        self.assertEqual(len(v.validate_structure(channel(), {GUID: EPISODE})), 1)

    def test_stale_enclosure_is_rejected(self):
        tree = channel()
        tree.find("item/enclosure").set("url", v.BASE + "/podcast/audio/043-example.mp3")
        with self.assertRaisesRegex(ValueError, "current upload"):
            v.validate_structure(tree, {GUID: EPISODE})

    def test_duplicate_guid_is_rejected(self):
        tree = channel(); tree.append(copy.deepcopy(tree.find("item")))
        with self.assertRaisesRegex(ValueError, "Duplicate episode GUID"):
            v.validate_structure(tree, {GUID: EPISODE})

    def test_missing_episode_is_rejected(self):
        tree = channel(); tree.remove(tree.find("item"))
        with self.assertRaisesRegex(ValueError, "episode set"):
            v.validate_structure(tree, {GUID: EPISODE})

    def test_old_duration_is_rejected(self):
        tree = channel(); tree.find("item/" + v.ITUNES + "duration").text = "12"
        with self.assertRaisesRegex(ValueError, "wrong duration"):
            v.validate_structure(tree, {GUID: EPISODE})

    def test_replacement_cannot_change_publication_date(self):
        tree = channel(); tree.find("item/pubDate").text = "Thu, 02 Jan 2020 00:00:00 +0000"
        with self.assertRaisesRegex(ValueError, "original publication date"):
            v.validate_structure(tree, {GUID: EPISODE})

    def test_zero_length_is_rejected(self):
        tree = channel(); tree.find("item/enclosure").set("length", "0")
        with self.assertRaisesRegex(ValueError, "byte length"):
            v.validate_structure(tree, {GUID: EPISODE})

    def test_stale_build_date_is_rejected(self):
        tree = channel(); tree.find("lastBuildDate").text = "Tue, 31 Dec 2019 00:00:00 +0000"
        with self.assertRaisesRegex(ValueError, "predates"):
            v.validate_structure(tree, {GUID: EPISODE})

    def test_future_date_is_rejected(self):
        with self.assertRaisesRegex(ValueError, "future"):
            v.date("Fri, 01 Jan 2100 00:00:00 +0000")

    def test_deployed_same_size_stale_feed_is_rejected(self):
        built = channel(); live = channel()
        live.find("item/enclosure").set("length", "12344")
        self.assertEqual(len(ET.tostring(live)), len(ET.tostring(built)))
        with self.assertRaisesRegex(ValueError, "Deployed RSS differs"):
            v.compare_feed(live, built)

    def test_deployed_feed_matches_build(self):
        v.compare_feed(channel(), channel())


class MediaTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        class Handler(BaseHTTPRequestHandler):
            def log_message(self, *args):
                pass

            def do_HEAD(self):
                self.send_response(200)
                self.send_header("Content-Type", cls.mime)
                self.send_header("Content-Length", str(len(cls.payload) + cls.size_error))
                self.end_headers()

            def do_GET(self):
                if "Range" in self.headers and not cls.ignore_range:
                    start, end = map(int, self.headers["Range"][6:].split("-"))
                    data = cls.payload[start:end+1]
                    self.send_response(206)
                    self.send_header("Content-Range", f"bytes {start}-{end}/{len(cls.payload) + cls.range_error}")
                else:
                    data = cls.payload
                    self.send_response(200)
                self.send_header("Content-Type", cls.mime)
                self.send_header("Content-Length", str(len(data)))
                self.end_headers()
                self.wfile.write(data)

        cls.server = ThreadingHTTPServer(("127.0.0.1", 0), Handler)
        cls.thread = threading.Thread(target=cls.server.serve_forever, daemon=True)
        cls.thread.start()
        cls.url = f"http://127.0.0.1:{cls.server.server_port}/audio"

    @classmethod
    def tearDownClass(cls):
        cls.server.shutdown(); cls.server.server_close(); cls.thread.join()

    def setUp(self):
        cls = type(self)
        cls.payload = b"x" * 12345
        cls.mime = "audio/mpeg"
        cls.ignore_range = False
        cls.size_error = cls.range_error = 0

    def test_valid_seeking_without_accept_ranges_header(self):
        v.check_audio(self.url, 12345)

    def test_soft_404_is_rejected(self):
        type(self).mime = "text/html"
        with self.assertRaisesRegex(ValueError, "MIME"):
            v.check_audio(self.url, 12345)

    def test_incorrect_byte_length_is_rejected(self):
        type(self).size_error = 1
        with self.assertRaisesRegex(ValueError, "hosted audio size"):
            v.check_audio(self.url, 12345)

    def test_server_ignoring_range_is_rejected(self):
        type(self).ignore_range = True
        with self.assertRaisesRegex(ValueError, "ignored byte-range"):
            v.check_audio(self.url, 12345)

    def test_incorrect_range_total_is_rejected(self):
        type(self).range_error = 1
        with self.assertRaisesRegex(ValueError, "Content-Range"):
            v.check_audio(self.url, 12345)

    def test_same_size_wrong_recording_is_rejected(self):
        with self.assertRaisesRegex(ValueError, "approved replacement"):
            v.check_recording(self.url, {"audioSha256": "0" * 64}, 12345)

    def test_empty_transcript_is_rejected(self):
        type(self).mime = "text/vtt"; type(self).payload = b"WEBVTT\n"
        with self.assertRaisesRegex(ValueError, "empty or invalid"):
            v.check_transcript(self.url, 10)

    def test_transcript_past_cut_is_rejected(self):
        type(self).mime = "text/vtt"
        type(self).payload = b"WEBVTT\n\n00:00:01.000 --> 00:00:20.000\nRetired content\n"
        with self.assertRaisesRegex(ValueError, "beyond replacement"):
            v.check_transcript(self.url, 10)


if __name__ == "__main__":
    unittest.main()
