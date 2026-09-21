---
name: trend-scout
description: Discover what's trending right now across TikTok, YouTube Shorts, and Instagram Reels using Virlo.
---

# Trend scout

Scout current trends across the requested platform (default: all platforms) using the Virlo MCP tools:

1. Call `get_emerging_trends` for momentum-ranked early-stage trends and `get_trends_digest` for today's curated editorial digest (`get_trends` for the broader set). $0.25/call each.
2. Call `get_trending_videos` (filtered by platform if one was given) for the top viral videos from the last ~48 hours, paired with `get_breakout_sounds` for audio accelerating off a small base — the better early signal than `get_trending_sounds`, which is already-large audio.
3. Call `get_hashtag_performance` for the top 3-5 trending topics found above (per-hashtag detail, $0.05/call; `search_hashtags` only returns the overall ranked list for a date range, not a specific topic).
4. Present a trend report: what's emerging right now, today's curated top trends, hottest videos (ranked by weighted virality, not raw views), rising hashtags and breakout sounds with their lifecycle labels (`new`/`rising`/`steady`/`fading`), plus actionable content ideas.

For depth on one sound or hashtag, `lookup_sound` / `lookup_hashtag` run a full satellite analysis at $0.50/call — ask before spending.
