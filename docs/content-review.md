# Blog content review — 14 September 2026

This pass covers the 303 published blog posts. It repairs missing metadata and
reviews obvious obsolete, incomplete or misleading material; it is not a claim
that every command or every article has been technically retested. The 612 tips
remain a separate archive and have not received this editorial review.

## What changed

- Added 93 missing titles and 100 missing or empty descriptions, based on the existing text.
- Preserved every published blog URL, publication date and existing tag assignment.
- Added explanatory historical notices to 75 posts. Of these, 54 remain indexable as firsthand history; 21 request `noindex`.
- Historical posts remain in the full archive and expandable topic lists, but do not appear in recommendations, Pagefind or news RSS.
- Added BlogPosting metadata, introductions for all eight topics, and social previews from existing illustrations. Six recent AVIF photo posts have JPEG previews. Four older previews have local copies because their original host sends `text/plain`.
- Stopped metadata-only Git edits from changing article update dates or news-feed publication dates.
- Repaired nine broken internal link occurrences, restored 17 legacy wiki links, and added redirect pages for eight old yearless URLs. An unavailable Android tethering reference is now labelled as unavailable; two unresolved device wiki references are plain text.
- Repaired external references to RØDE, Sony, DigitalOcean, Cognito, Mistral, GPT-4 Turbo, GStreamer, the MikroTik configuration and the Granted issue. The GStreamer and MikroTik links point to verified historical commits; Granted moved to the fwdcloudsec organisation.
- Added direct links between the 2020 A/V guide and the 2026 Litra Beam article, alongside the shared topic archive.

## Editorial decisions

Age is not a quality test. The W3C widget comparisons, historical network
measurements and early CoreOS experiences are useful primary records. They
remain indexable with context. The 2020 A/V guide still contains useful
recording and placement advice, so it remains in recommendations with a clear
note that its equipment and prices date from 2020.

The opposite applies to a recent stub: the 2024 insulation bookmark contains
neither an insulation specification nor a usable guide, so it is `noindex`.
The home-energy-monitoring description now calls that page a short inventory;
it no longer promises dashboards and insights that the body does not provide.

The 2015 public-API article keeps its open-data argument, but its notice
explicitly corrects the claim that CORS/referrer checks replace authentication.
[CORS controls browser access to cross-origin responses](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CORS).
The 2024 LLM price comparison is retained as a dated snapshot, with working
links to the providers' current pages rather than silently replacing its figures.

### Pages excluded from search engines

These URLs remain available; the reason also appears on each article.

| Page | Reason |
| --- | --- |
| [Fixed mobile layouts and page zoom: a 2009 opinion](https://dabase.com/blog/2009/Fixed_mobile_design_is_ok/) | This short recommendation relies on 2009 mobile page-zoom behaviour. It is too dated and incomplete to serve as advice for designing a responsive site today. |
| [My search engine optimisation advice in 2009](https://dabase.com/blog/2009/Search_Engine_Optimisation/) | These brief 2009 SEO notes oversimplify ranking and HTML validation. They are retained as an old opinion, not current search optimisation guidance. |
| [Searching Android Market through a mobile user agent](https://dabase.com/blog/2010/Android_Market_search/) | A one-command experiment with an old Android Market endpoint. It is not a maintained or reproducible app-search guide. |
| [Where to find me at Mobile World Congress 2010](https://dabase.com/blog/2010/MWC2010_Web_geek/) | An announcement of where to find me at Mobile World Congress in February 2010. The event has passed. |
| [London cycle-hire station data from 2010](https://dabase.com/blog/2010/TFL_Bike_stations/) | A raw 2010 station-data snapshot with legacy table markup. It is not a usable current directory of London bike stations. |
| [A PPTP VPN experiment with an iPhone 5](https://dabase.com/blog/2012/pptpd_VPN_iPhone/) | A 2012 iOS 6 PPTP experiment, preserved as a configuration log. It should not be used to choose or configure a secure VPN today. |
| [Screenshot upload script bookmarks from 2012](https://dabase.com/blog/2012/scrot_upload_your_screenshots/) | This page only points to two old screenshot scripts. It contains no self-contained setup or maintained upload workflow. |
| [Google Groups moderation frustrations in 2013](https://dabase.com/blog/2013/Google_groups_is_Kafkaesque/) | A brief complaint about Google Groups in 2013, without a reproducible diagnosis or a working solution. |
| [A minimal Dovecot configuration experiment from 2013](https://dabase.com/blog/2013/Minimal_Dovecot/) | This incomplete mail-server example disables TLS with ssl = no. It is not a secure configuration for a network-accessible mail service. |
| [An old YouTube workaround for HTML video without Flash](https://dabase.com/blog/2013/Watching_HTML_video_on_Youtube_without_Flash/) | A 2013 workaround for Flash-era YouTube playback. The old URL trick is not current browser troubleshooting advice. |
| [S3 permissions, ACLs and CORS: a 2014 experiment](https://dabase.com/blog/2014/S3_permission_policy_confusion/) | These incomplete 2014 notes mix public ACLs and CORS questions without a resolved permissions model. They are not a secure S3 policy template. |
| [An IRC discussion about Docker virtual hosting](https://dabase.com/blog/2014/Vhost_docker_container/) | An unresolved 2014 IRC discussion about container hosting. There is no complete setup or solution to follow. |
| [Archiving iPhone 6 photos with ifuse in 2015](https://dabase.com/blog/2015/Archiving_iPhone_images_with_Archlinux_and_ifuse/) | This 2015 workaround includes deleting the phone’s Photos.sqlite database. It is not a verified or safe current photo-backup procedure. |
| [A Samba recycle-bin experiment from 2016](https://dabase.com/blog/2016/Samba_sharing_with_undelete/) | This experiment forces access as root and uses permissive 0777 modes. It is not a secure file-sharing template. |
| [Resetting a Xiaomi Mi Note with fastboot in 2016](https://dabase.com/blog/2016/Wiping_a_Xiaomi_Mi_note/) | An incomplete, device-specific reset log with uncertain button sequences and a destructive fastboot -w command. It is not a general recovery guide. |
| [Whats the difference between a Docker container and a Virtual machine?](https://dabase.com/blog/2016/difference_between_docker_and_vm/) | This brief 2016 explanation describes Docker in terms of LXC and makes blanket performance claims. It is too imprecise to use as a current architecture guide. |
| [Thinkpad T480s for sale](https://dabase.com/blog/2020/T480s_for_sale/) | A laptop sale listing from 2020, retained for its record of the hardware and asking price. This is not a current offer. |
| [Helper with COVID positive](https://dabase.com/blog/2021/covid-with-helper/) | A personal account of Singapore household isolation rules in November 2021. It is not current medical advice or a guide to today’s public-health rules. |
| [Systemd Journal to Cloudwatch](https://dabase.com/blog/2021/systemd-journal-cloudwatch/) | These are short failure notes and links, without a working journal-to-CloudWatch configuration. |
| [Mac Nix](https://dabase.com/blog/2023/mac-nix/) | These are fragmentary trial notes with an unresolved rollback problem. They do not provide a reproducible Nix setup for macOS. |
| [Insulation](https://dabase.com/blog/2024/insulation/) | A video bookmark and a very short checklist. This page does not contain an insulation specification or enough detail to guide building work. |

### Other historical material

The following pages keep search-engine indexing. Their notices explain the
specific date, platform, measurement or technical limitation.

- [Contributing tests for W3C Widgets](https://dabase.com/blog/2009/Contribute_Widget_tests/)
- [Graceful degradation in packaged widgets](https://dabase.com/blog/2009/Degrading_Widgets/)
- [JIL versus BONDI: organisations and widget standards](https://dabase.com/blog/2009/JIL_versus_BONDI/)
- [JIL versus BONDI: widget security models](https://dabase.com/blog/2009/JIL_versus_BONDI_on_Security/)
- [Mobile games at the 2009 Hide & Seek festival](https://dabase.com/blog/2009/Mobile_Gaming/)
- [Working on mobile browser compatibility tests](https://dabase.com/blog/2009/Mobile_browser_test/)
- [Mobile domain names, HTTPS and identity in 2009](https://dabase.com/blog/2009/Mobile_domain_names/)
- [First look at NetFront Widgets Player](https://dabase.com/blog/2009/NetFront_Widgets_Player_first_look/)
- [PDF/A versus HTML for document archives: a 2009 debate](https://dabase.com/blog/2009/PDF-A_versus_HTML/)
- [Signing W3C Widgets with XML signatures](https://dabase.com/blog/2009/Signed_Widgets/)
- [UK pay-as-you-go mobile internet prices in 2009](https://dabase.com/blog/2009/UK_PAYG_Internet_comparison/)
- [Comparing browser print output in 2009](https://dabase.com/blog/2009/Web_browser_printing_comparison/)
- [Why device API policies mattered in 2009](https://dabase.com/blog/2009/Why_policies/)
- [Building a W3C widget test framework](https://dabase.com/blog/2009/Widget_Test_Framework/)
- [W3C Widget interface mapping quirks](https://dabase.com/blog/2009/Widget_mapping_quirks/)
- [Widgets as portable offline web packages](https://dabase.com/blog/2009/Widgets_are_simple_offline_packages/)
- [What I wanted from the DAP Calendar API](https://dabase.com/blog/2010/Alarmed_about_DAP_Calendar/)
- [Running company chat on IRC in 2010](https://dabase.com/blog/2010/Business_IRC/)
- [Depending on the mobile web with a Nexus One](https://dabase.com/blog/2010/Depending_on_the_mobile_Web/)
- [Packaging the web: updates and kill switches](https://dabase.com/blog/2010/Packaging_the_Web/)
- [Starting Nokia N900 development with Maemo 5](https://dabase.com/blog/2010/Starting_n900_development/)
- [Nokia N900 developer tips for Maemo 5](https://dabase.com/blog/2010/n900_developer_tips/)
- [Building WebKit for the Nokia N900](https://dabase.com/blog/2010/n900_mobile_developer_paradise/)
- [A minimal Squid 3 proxy configuration](https://dabase.com/blog/2012/Minimal_squid3_proxy_configuration/)
- [Moving a Debian 7 host with rsync](https://dabase.com/blog/2013/Cloning_hosts/)
- [Understanding early CoreOS in 2013](https://dabase.com/blog/2013/Understanding_CoreOS/)
- [Updating a Docker container on early CoreOS](https://dabase.com/blog/2014/Docker_container_update_workflow/)
- [Experiencing CoreOS and Docker in 2014](https://dabase.com/blog/2014/Experiencing_CoreOS+Docker/)
- [Moving from netctl to systemd-networkd in 2014](https://dabase.com/blog/2014/Good_riddance_netctl/)
- [The cost of an Arch Linux mirror on EC2 in 2014](https://dabase.com/blog/2014/How_much_does_it_cost_to_run_an_Archlinux_mirror_on_EC2/)
- [Singapore VPS network tests: DigitalOcean versus GPLhost](https://dabase.com/blog/2014/Iperf_SG:DigitalOcean_versus_GPLhost/)
- [Arch Linux on an early-2014 MacBook Air](https://dabase.com/blog/2014/Macbook_Air_Early_2014_Archlinux/)
- [SIGFOX event and payload notes from 2014](https://dabase.com/blog/2014/SIGFOX/)
- [Recovering a Droplet network with systemd-networkd](https://dabase.com/blog/2014/Systemd_network_on_a_Droplet/)
- [USB 2 versus USB 3 disk tests on a ThinkPad X220](https://dabase.com/blog/2014/USB3_disk_testing/)
- [Google Compute Engine: invalid value for project](https://dabase.com/blog/2014/invalid_value_for_project/)
- [Foscam C1 camera notes from 2015](https://dabase.com/blog/2015/Foscam_C1/)
- [Where git-annex fell short for my media workflow](https://dabase.com/blog/2015/Git-annex-shortfalls-for-me/)
- [Barriers to browser-based use of public APIs](https://dabase.com/blog/2015/Javascript_API_barriers/)
- [Mail from a VPS using AWS SES from sandbox mode](https://dabase.com/blog/2015/Mail_from_a_VPS/)
- [Screencasting obstacles on Arch Linux in 2015](https://dabase.com/blog/2015/Screencasting_from_Archlinux_gotchas/)
- [Singtel 500 Mbps and Singapore cloud network tests](https://dabase.com/blog/2015/Singapore_Speed_on_Singtel_500Mbps_2015/)
- [Streaming an IRC channel to a web display](https://dabase.com/blog/2015/Web_IRC_logger/)
- [WebKit rendering on a Raspberry Pi 2](https://dabase.com/blog/2015/Webkit_on_Rpi2/)
- [An AWS ECS development workflow in 2016](https://dabase.com/blog/2016/AWS_ECS_Workflow/)
- [Difficulties using AWS SDK for PHP v3 in 2016](https://dabase.com/blog/2016/AWS_PHP_SDK_v3/)
- [Running an early Caddy release in Docker](https://dabase.com/blog/2016/Caddy_in_Docker/)
- [Developing Docker containers: my 2016 workflow](https://dabase.com/blog/2016/Developing_Docker_container_workflow/)
- [Questions about AWS ECS in 2016](https://dabase.com/blog/2016/ECS_questions/)
- [First impressions of Django 1.9 on Python 2](https://dabase.com/blog/2016/First_impressions_of_Django_1.9/)
- [Recovering an OpenWrt router in failsafe mode](https://dabase.com/blog/2016/Openwrt_rescue/)
- [Archer C7 wireless range problems on OpenWrt 15.05](https://dabase.com/blog/2016/Wireless_AC_only_works_when_stupidly_close_to_the_AP/)
- [National COVID2019 Websites](https://dabase.com/blog/2020/COVID19-websites/)
- [LLM token cost](https://dabase.com/blog/2024/llm-token-cost/)

## Link checking and remaining limitations

The generated-site validator checks local blog and topic links against files
Hugo actually built. The Markdown hook's `static/` root cannot resolve Hugo
article URLs and reports false missing-file errors for those links.

There is still real external link rot in the preserved text: old ix.io pastes,
R2D2/Webconverger media, GPLhost and Foscam pages, SlideShare decks, and the old
Openreach SIN506 PDF. Some references are the evidence for a historical claim;
this pass has not fabricated replacement evidence or redirected them to an
unrelated homepage. Bot challenges, rate limits and private example addresses
are separate from confirmed 404/410 responses. A blanket external link check
therefore does not pass; this is not a claim of a completely repaired archive.

Further maintenance should prioritise reproducible, useful articles and
recovering primary evidence, rather than expanding unfinished bookmarks.

## Ongoing policy and validation

Run `redo check-blog` and `redo check-podcast` before deployment. The former
checks the metadata, JSON-LD, local blog links, sitemap, RSS dates and actual
Pagefind fragments. The latter checks the podcast and ordinary RSS feeds,
including hosted media. Set an explicit `lastmod` only after a substantive
article update; remove a historical/noindex designation only after addressing
its stated reason.

A noindex rule needs a crawl before a search engine can act on it. Keep these
pages crawlable and use Search Console to observe indexing; do not expect an
immediate change in search results. See [Google's noindex guidance](https://developers.google.com/search/docs/crawling-indexing/block-indexing)
and [Article structured-data guidance](https://developers.google.com/search/docs/appearance/structured-data/article).
