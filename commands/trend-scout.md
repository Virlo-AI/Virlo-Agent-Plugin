---
name: trend-scout
description: Discover what's trending right now across TikTok, YouTube Shorts, and Instagram Reels using Virlo.
---

# Trend scout

Scout current trends across the requested platform (default: all platforms) using the Virlo MCP tools:

1. Call `get_topic_trends` with `view: "emerging"` for momentum-ranked early-stage Topic Trends (what people are talking about). Each topic has a `category` (entertainment, memes, sports, fashion_beauty, gaming_tech, lifestyle, politics, news); pass `category` or `exclude_category` to narrow it, for example `exclude_category: ["politics","news"]` for pop culture without politics.
2. Call `get_content_trends` for Content Trends, the video formats creators are copying right now (filter by `platform` if one was given). Topic Trends say what to talk about; Content Trends say what to make.
3. Call `find_videos` with `sort: "rising"` and `posted_after` set to two days ago (and `platforms` if one was given) for the videos gaining views fastest now. Call `get_trending_sounds` with `view: "breakout"` for audio accelerating off a small base.
4. Call `search_hashtags` for this week's top hashtags.
5. Present a trend report: what's emerging, Content Trends worth copying, hottest videos (ranked by Virality Score, not raw views), and rising hashtags and breakout sounds to watch, plus actionable content ideas.

Cost: about $0.85 in total ($0.25 each for topic trends, content trends and sounds; $0.05 each for videos and hashtags).
