---
name: genre-monitor
description: Stand up a recurring TikTok genre/scene research agent and read discovery signals (sounds, hashtags, rising creators) using Virlo.
---

# Genre monitor

Given a genre, scene, or sub-culture (e.g. "cottagecore", "deep house DJs"):

1. Check `list_my_research` for an agent on this genre already. Reuse it if it fits and skip to step 4.
2. Write a one-sentence intent for monitoring it and 7-12 keywords: synonyms and sub-scenes of the same concept. Hashtag-style tokens are fine.
3. Call `create_research_agent` with `recurring: true`, `cadence: "weekly"`, platforms `["tiktok"]`, the intent and keywords, and no `user_approved`. Explain the proposal: a recurring agent costs $0.50 per run ($1.50 with Data Intelligence), billed every week. Call again with `user_approved: true` only after the user says yes.
4. Once `finalized: true`, read `get_agent_report`. The first run usually finishes collecting in about 8 minutes (9 in 10 within 20). If it is still running, tell the user and check again on their next message; never call it repeatedly in a row.
5. Read discovery signals with `get_agent_data` (all free):
   - `data_type: "sounds"`, `order_by: "rising"`: sounds breaking out in the genre right now.
   - `data_type: "hashtags"`, `order_by: "growth"`: hashtag momentum and top creators per tag.
   - `data_type: "outliers"`, `order_by: "rising"`, filtered by `follower_tier`: creators gaining velocity, by tier.
   - `data_type: "benchmarks"`: median engagement, followers and posting frequency per tier.
   - `data_type: "affinity"`: adjacent topics, hashtags and sounds to expand into.
6. Deliver a genre brief: sound to ride this week, hashtags heating up, rising creators to watch (with tier and a link to their best video), how a creator compares to genre norms, and the recurring agent now in place. Lead with the three findings that matter most.
