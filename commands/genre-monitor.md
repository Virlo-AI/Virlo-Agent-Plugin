---
name: genre-monitor
description: Stand up a recurring TikTok genre/scene monitor and read discovery signals (sounds, hashtags, rising creators) using Virlo.
---

# Genre monitor

Given a genre, scene, or sub-culture (e.g. "cottagecore", "deep house DJs"):

1. Draft an intent for monitoring it and call `suggest_keywords`; include synonyms and sub-scenes of the same concept. Hashtag-style tokens are fine.
2. Call `create_niche_monitor` with platforms `["tiktok"]`, cadence `weekly`, and the suggested keywords. Cadence accepts `daily`, `weekly`, `monthly`, or a cron expression (max once per day). The first run dispatches immediately.
3. Poll `get_niche_monitor_data` (`data_type: "overview"`) until `finalized: true` (~15-20 min) — don't loop tightly, hand back the id and check later.
4. Read discovery signals (all free):
   - `sounds` (`order_by: rising`) — sounds breaking out in the genre right now.
   - `hashtags` (`order_by: growth`) — hashtag momentum + top creators per tag.
   - `outliers` (`order_by: rising`, filter by `follower_tier`) — creators gaining velocity, by tier.
   - `benchmarks` — median engagement/followers/posting-frequency per tier.
   - `affinity` — adjacent topics/hashtags/sounds to expand into.
   - `activity` / `proposals` — the agent's self-optimization surface; `get_niche_monitor_proposals` + `review_niche_monitor_proposal` let the user accept or reject keyword changes, and `set_niche_monitor_autonomy` controls whether it acts alone.
5. Deliver a genre brief: sound to ride this week, hashtags heating up, rising creators to watch (with tier), how a creator compares to genre norms, adjacent scenes to expand into, and the recurring agent now in place.

Check `get_credit_balance` first. Creating a recurring agent is free but each scheduled run bills $0.50 until deleted — confirm cadence and standing cost with the user first. `update_niche_monitor` changes keywords or cadence; `delete_niche_monitor` stops the billing. The discovery reads above are free.
