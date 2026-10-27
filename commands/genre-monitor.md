---
name: genre-monitor
description: Stand up a recurring TikTok genre/scene monitor and read discovery signals (sounds, hashtags, rising creators) using Virlo.
---

# Genre monitor

Given a genre, scene, or sub-culture (e.g. "cottagecore", "deep house DJs"):

1. Check `get_credit_balance`, tell the user a recurring agent costs $0.50 per run (billed every week on this cadence), and get a yes before creating it.
2. Draft an intent for monitoring it and call `suggest_keywords`; include synonyms and sub-scenes of the same concept. Hashtag-style tokens are fine.
3. Call `create_niche_monitor` with platforms `["tiktok"]`, cadence `weekly`, and the suggested keywords.
4. Read `get_niche_monitor_data` (`data_type: "overview"`) once `finalized: true`. The first run usually finishes collecting in about 8 minutes (9 in 10 within 20). If it is still running, tell the user and check again on their next message; never call it repeatedly in a row.
5. Read discovery signals (all free):
   - `sounds` (`order_by: rising`): sounds breaking out in the genre right now.
   - `hashtags` (`order_by: growth`): hashtag momentum + top creators per tag.
   - `outliers` (`order_by: rising`, filter by `follower_tier`): creators gaining velocity, by tier.
   - `benchmarks`: median engagement/followers/posting-frequency per tier.
   - `affinity`: adjacent topics/hashtags/sounds to expand into.
6. Deliver a genre brief: sound to ride this week, hashtags heating up, rising creators to watch (with tier and a link to their best video), how a creator compares to genre norms, and the recurring agent now in place. Lead with the three findings that matter most.

Creating the agent costs $0.50 per run ($1.50 with Data Intelligence); the discovery reads above are free.
