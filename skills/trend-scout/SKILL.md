---
name: trend-scout
description: Discover what is trending right now across TikTok, YouTube Shorts, and Instagram Reels — emerging trends, the curated daily digest, top viral videos, breakout sounds, and rising hashtags.
---

# Trend scout

Scout current trends across the requested platform (default: all three) using the Virlo tools. Follow `virlo-research-conventions` for cost and ranking rules.

## Steps

1. **Emerging and curated.** Call `get_emerging_trends` for momentum-ranked early-stage trends, and `get_trends_digest` for today's curated editorial digest. Use `get_trends` if the user wants the broader trend set rather than the digest. ($0.25/call each.)
2. **Hot videos and audio.** Call `get_trending_videos` — filtered by platform if one was given — for the top viral videos of the last ~48 hours. Pair it with `get_breakout_sounds` for audio accelerating off a small base, which is the better early signal than `get_trending_sounds` (already-large audio).
3. **Hashtag detail.** Call `get_hashtag_performance` for the top 3–5 topics found above. `search_hashtags` only returns the overall ranked list for a date range — it will not answer "how is this specific topic doing", so use `get_hashtag_performance` for per-topic detail. ($0.05/call.)
4. **Optional depth.** If the user names a specific sound or hashtag worth chasing, `lookup_sound` or `lookup_hashtag` gives the full satellite picture ($0.50/call) — ask first.

## Deliver

A trend report covering:

- What is emerging right now, ranked by momentum
- Today's curated top trends
- Hottest videos, ranked by weighted virality rather than raw views
- Rising hashtags and breakout sounds to watch, with their lifecycle labels
- Concrete content ideas the user could act on this week
