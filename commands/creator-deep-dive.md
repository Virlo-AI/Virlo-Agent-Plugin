---
name: creator-deep-dive
description: Deep-dive analysis of a specific creator (platform + username) using Virlo.
---

# Creator deep dive

Given a platform (`youtube` / `tiktok` / `instagram`) and a username:

1. Call `lookup_creator` with that platform and username, including `videos,outliers` ($0.50; +$0.25 with Data Intelligence). For several creators, `batch_lookup_creators` bills $0.50 per creator — confirm the list size first.
2. Poll `get_satellite_run` (free) until `finalized: true`. From the results, identify top-performing videos (outliers, ranked by weighted virality), common themes/hashtags in successful content, posting frequency/consistency, and engagement patterns (views vs likes vs comments).
3. Call `get_creator_audience_demographics` and `get_creator_audience_geography` (both free) for who the audience actually is. If the data is stale or empty, `refresh_creator_audience` repopulates it ($0.50 on cache miss only) — say so first.
4. Call `get_creator_sounds` ($0.25) for the creator's audio strategy and whether they ride trends early or late.
5. If one post dominates, `analyze_video` breaks it down ($0.50) — ask before calling.
6. Ask the user before calling `track_creator` to start ongoing tracking; it bills $0.25/cycle until untracked.
7. Summarize: strengths, content strategy insights, audience makeup, audio posture, and growth trajectory — with the specific posts backing each claim.
