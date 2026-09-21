---
name: genre-monitor
description: Stand up a recurring Virlo research agent for a genre, scene, or sub-culture and read its discovery signals — rising sounds, hashtag momentum, breakout creators by follower tier, benchmarks, and adjacent topics.
---

# Genre monitor

Given a genre, scene, or sub-culture — "cottagecore", "deep house DJs", "silent walking". Follow `virlo-research-conventions`.

## Steps

1. **Balance and consent.** Call `get_credit_balance`. A recurring agent is free to create but bills **$0.50 per scheduled run** until deleted. Confirm the cadence and that running cost with the user before creating it.
2. **Intent.** Draft an intent for monitoring the scene and call `suggest_keywords`. Include synonyms and sub-scenes of the same concept — hashtag-style tokens are fine here. Sharpen and retry if `quality.passes` is false.
3. **Create.** Call `create_niche_monitor` with the suggested keywords, `platforms: ["tiktok"]` (or wider if the scene lives elsewhere), and cadence `weekly`. Cadence accepts `daily`, `weekly`, `monthly`, or a cron expression capped at once per day. The first run dispatches immediately.
4. **Wait properly.** Poll `get_niche_monitor_data` with `data_type: "overview"` until `finalized: true` — roughly 15–20 minutes. Hand back the id and check later rather than looping tightly.
5. **Read the discovery signals** — all free, all filterable at read time:
   - `sounds` (`order_by: rising`) — audio breaking out in the scene right now
   - `hashtags` (`order_by: growth`) — tag momentum with lifecycle labels and top creators per tag
   - `outliers` (`order_by: rising`, filter by `follower_tier`) — creators gaining velocity, segmented by size
   - `benchmarks` — median engagement, followers, and posting frequency per tier
   - `affinity` — adjacent topics, hashtags, and sounds worth expanding into
   - `activity` and `proposals` — the agent's own self-optimization surface; `get_niche_monitor_proposals` plus `review_niche_monitor_proposal` lets the user accept or reject keyword changes, and `set_niche_monitor_autonomy` controls whether it acts alone
6. **Maintenance.** `update_niche_monitor` changes keywords or cadence; `delete_niche_monitor` stops the billing. Tell the user both exist.

## Deliver

A genre brief: the sound to ride this week, hashtags heating up, rising creators to watch with their tier, how a given creator compares to scene norms, adjacent scenes to expand into — and the recurring agent now in place, with its cadence and per-run cost stated.
