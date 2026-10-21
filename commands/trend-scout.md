---
name: trend-scout
description: Discover what's trending right now across TikTok, YouTube Shorts, and Instagram Reels using Virlo.
---

# Trend scout

Scout current trends across the requested platform (default: all platforms) using the Virlo MCP tools:

1. Call `get_emerging_trends` for momentum-ranked early-stage Topic Trends and `get_trends_digest` for today's Topic Trends digest (what people are talking about: news and pop culture, by region). Call `get_content_trends` with `lifecycle` `new,rising` for Format Trends, the video formats creators are copying right now (filter by `platform` if one was given). Topic Trends say what to talk about; Format Trends say what to make.
2. Call `get_trending_videos` (filtered by platform if one was given) for the top viral videos from the last ~48 hours, paired with `get_breakout_sounds` for audio accelerating off a small base.
3. Call `get_hashtag_performance` for the top 3-5 trending topics found above (per-hashtag detail; `search_hashtags` only returns the overall ranked list for a date range, not a specific topic).
4. Present a trend report: what's emerging right now, today's top Topic Trends, Format Trends worth copying, hottest videos (ranked by weighted virality, not raw views), and rising hashtags/breakout sounds to watch, plus actionable content ideas.
