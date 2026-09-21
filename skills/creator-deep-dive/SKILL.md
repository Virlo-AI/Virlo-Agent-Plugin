---
name: creator-deep-dive
description: Deep-dive analysis of a specific creator on TikTok, YouTube, or Instagram — profile, outlier posts, posting cadence, engagement patterns, audience demographics and geography, and the sounds they use.
---

# Creator deep dive

Given a platform (`youtube` / `tiktok` / `instagram`) and a username. Follow `virlo-research-conventions` for cost and ranking rules.

## Steps

1. **Profile and content.** Call `lookup_creator` with that platform and username, including `videos,outliers`. ($0.50; +$0.25 with the Data Intelligence add-on.) For several creators at once use `batch_lookup_creators` — it bills $0.50 per creator, so confirm the list size first.
2. **Read the run.** Poll `get_satellite_run` (free) until `finalized: true`. From the results identify:
   - Top-performing videos — use the outliers, ranked by weighted virality, not raw views
   - Common themes, formats, and hashtags in the content that worked
   - Posting frequency and consistency
   - Engagement patterns: views vs. likes vs. comments, and where that ratio breaks from the norm
3. **Audience.** Call `get_creator_audience_demographics` and `get_creator_audience_geography` — both free. If they return stale or empty data, `refresh_creator_audience` repopulates it ($0.50 on a cache miss only); say so before calling.
4. **Audio strategy.** Call `get_creator_sounds` for the audio this creator reaches for, and whether they ride trends early or late.
5. **Single video.** If one post dominates, `analyze_video` breaks it down in detail ($0.50) — ask before calling.
6. **Ongoing tracking.** Ask the user before calling `track_creator`; it bills $0.25 per cycle for as long as it runs. See the `creator-tracking` skill if they say yes.

## Deliver

Strengths, content strategy insights, who the audience actually is and where they are, audio posture, and growth trajectory — with the specific posts that support each claim.
