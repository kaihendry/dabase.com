#!/usr/bin/env python3
"""Validate the built blog's metadata, archive policy, links and search index.

Run after `redo site`. Uses only Python's standard library and the installed Hugo.
"""
import csv
from datetime import datetime
import gzip
from html.parser import HTMLParser
import io
import json
from pathlib import Path
import re
import subprocess
from urllib.parse import unquote, urljoin, urlparse
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
PUBLIC = ROOT / 'public'


class Page(HTMLParser):
    def __init__(self, html):
        super().__init__(convert_charrefs=True)
        self.meta = {}
        self.canonicals = []
        self.links = []
        self.title = ''
        self.h1 = ''
        self.schemas = []
        self.capture = None
        self.script = ''
        self.searchable = False
        self.feed(html)

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if tag == 'meta':
            self.meta[attrs.get('name', attrs.get('property'))] = attrs.get('content', '')
        if tag == 'link' and attrs.get('rel') == 'canonical':
            self.canonicals.append(attrs['href'])
        if tag == 'a' and 'href' in attrs:
            self.links.append(attrs['href'])
        if 'data-pagefind-body' in attrs:
            self.searchable = True
        if tag in ('title', 'h1'):
            self.capture = tag
        if tag == 'script' and attrs.get('type') == 'application/ld+json':
            self.capture = 'json'
            self.script = ''

    def handle_data(self, data):
        if self.capture == 'json':
            self.script += data
        elif self.capture:
            setattr(self, self.capture, getattr(self, self.capture) + data)

    def handle_endtag(self, tag):
        if tag == 'script' and self.capture == 'json':
            self.schemas.append(json.loads(self.script))
            self.capture = None
        elif tag == self.capture:
            self.capture = None


def parse_date(value):
    return datetime.fromisoformat(value.replace("Z", "+00:00"))


def built_path(url):
    path = PUBLIC / unquote(urlparse(url).path).lstrip('/')
    return path / 'index.html' if path.is_dir() else path


def main():
    rows = list(csv.DictReader(io.StringIO(subprocess.check_output(
        ['hugo', 'list', 'published'], cwd=ROOT, text=True))))
    blogs = [r for r in rows if r['section'] == 'blog' and r['kind'] == 'page']
    sitemap = {e.text for e in ET.parse(PUBLIC / 'sitemap.xml').iter(
        '{http://www.sitemaps.org/schemas/sitemap/0.9}loc')}
    # Pagefind 1.x fragments are gzip-compressed JSON with a magic prefix.
    # Inspect the actual generated index, not just the indexing attributes.
    indexed = set()
    for fragment in (PUBLIC / 'pagefind/fragment').glob('*.pf_fragment'):
        data = gzip.decompress(fragment.read_bytes()).removeprefix(b'pagefind_dcd')
        indexed.add(json.loads(data)['url'])
    assert indexed, 'Build Pagefind with redo site first'
    historical, excluded, previews = set(), set(), 0
    related_links = set()
    errors = []
    for row in blogs:
        url = row['permalink']
        path = urlparse(url).path
        try:
            source = (ROOT / row['path']).read_text()
            fm = source.split('---', 2)[1]
            old = bool(re.search(r'^historical:\s*\S', fm, re.M))
            noindex = bool(re.search(r'^noindex:\s*true\s*$', fm, re.M))
            html = built_path(url).read_text()
            page = Page(html)
            assert row['title'].strip(), 'missing frontmatter title'
            assert page.title.strip() and page.h1.strip(), 'missing visible or HTML title'
            assert re.search(r'^description:\s*[^\s\n]', fm, re.M), 'missing authored description'
            assert page.meta.get('description', '').strip(), 'empty meta description'
            assert '<' not in page.meta['description'], 'HTML in description'
            assert page.canonicals == [url], 'canonical changed or duplicated'
            assert page.meta.get('og:url') == url, 'wrong Open Graph URL'
            assert page.meta.get('og:title') == page.title, 'inconsistent preview title'
            assert ('noindex' in page.meta.get('robots', '')) == noindex, 'wrong indexing rule'
            assert (url in sitemap) != noindex, 'sitemap contradicts indexing rule'
            assert page.searchable == (not old and not noindex), 'wrong Pagefind boundary'
            assert (path in indexed) == (not old and not noindex), 'Pagefind index contradicts archive policy'
            if old:
                historical.add(path)
                assert 'aria-label="Historical note"' in html, 'missing historical explanation'
            if noindex:
                excluded.add(path)
                assert old, 'explain why a blog post is noindex with historical frontmatter'
            articles = [s for s in page.schemas if s.get('@type') == 'BlogPosting']
            assert len(articles) == (0 if noindex else 1), 'missing or inappropriate article schema'
            if articles:
                article = articles[0]
                assert article['headline'] == page.title, 'schema headline mismatch'
                assert article['description'] == page.meta['description'], 'schema description mismatch'
                assert article['url'] == article['mainEntityOfPage'] == url, 'schema URL mismatch'
                assert article['author']['name'] == 'Kai Hendry', 'wrong author'
                published = parse_date(article['datePublished'])
                assert published == parse_date(row['date']), 'publication date changed'
                assert parse_date(article['dateModified']) >= published, 'invalid modification date'
                if not re.search(r'^(lastmod|modified):', fm, re.M):
                    assert article['dateModified'] == article['datePublished'], 'metadata edit implies fresh content'
            image = page.meta.get('og:image')
            if image:
                previews += 1
                assert urlparse(image).scheme in ('http', 'https'), 'preview must be an absolute URL'
                assert page.meta.get('twitter:image') == image, 'inconsistent card image'
                if urlparse(image).netloc == urlparse(url).netloc:
                    assert built_path(image).is_file(), f'missing preview: {image}'
            for link in page.links:
                target = urljoin(url, link)
                parts = urlparse(target)
                if parts.netloc == urlparse(url).netloc and parts.path.startswith(('/blog/', '/tags/')):
                    assert built_path(target).is_file(), f'broken internal link: {link}'
            for aside in re.findall(r'<aside aria-labelledby="related-posts".*?</aside>', html, re.S):
                related_links.update(urlparse(link).path for link in Page(aside).links)
        except (AssertionError, OSError, ValueError, KeyError) as error:
            errors.append(f'{row["path"]}: {error}')
    assert not errors, '\n'.join(errors)
    assert not related_links.intersection(historical | excluded), 'related posts promote archived content'
    home_links = {urlparse(link).path for link in Page((PUBLIC / 'index.html').read_text()).links}
    assert not home_links.intersection(historical | excluded), 'homepage promotes archived content'
    news = ET.parse(PUBLIC / 'index.xml')
    dates = {r['permalink']: parse_date(r['date']) for r in rows}
    from email.utils import parsedate_to_datetime
    for item in news.findall('./channel/item'):
        url = item.findtext('link')
        assert urlparse(url).path not in historical | excluded, 'news RSS republishes archived content'
        assert parsedate_to_datetime(item.findtext('pubDate')) == dates[url], 'RSS changes publication date'
    for path in (PUBLIC / 'tags').glob('*/index.html'):
        page = Page(path.read_text())
        assert page.title and page.meta.get('description'), f'missing topic metadata: {path}'
    assert 'Sitemap: https://dabase.com/sitemap.xml' in (PUBLIC / 'robots.txt').read_text()
    print(f'Validated {len(blogs)} blog posts: {len(historical)} historical, '
          f'{len(excluded)} noindex, {previews} image previews; links, JSON-LD, sitemap, RSS and Pagefind agree.')


if __name__ == '__main__':
    main()
