---
name: niche-analysis
description: Full niche analysis (research agent + creators + recurring monitor) for a given niche, using Virlo.
---

# Full niche analysis

Given a niche or topic:

1. Draft a concrete one-sentence intent (goal + content type + exclusions, ~40-250 chars). Call `suggest_keywords` with that intent; if `quality.passes` is false, sharpen the intent and retry. Never invent intent from a keyword list.
2. Call `search_keywords` with the same intent and the suggested keywords (one-shot Content Research Agent, $0.50; $1.50 with Data Intelligence). Do not pass `min_views` or `time_period` — the agents API rejects them; filter at read time. `english_only` defaults to true; set it false for a multilingual niche. Expect ~15-20 minutes; poll until `finalized: true`.
3. Call `get_keyword_search_results` to review videos, creator outliers (prefer `order_by=weighted_score`), AI analysis, and trend themes. Slideshows, ads, sounds, and hashtags have their own free read surfaces, with lifecycle labels on tags and sounds.
4. Call `lookup_creator` on the top 2-3 creator outliers ($0.50 each) for full profiles and video analytics — confirm the count first.
5. Offer `create_niche_monitor` with the same intent + best keywords and cadence `weekly` for ongoing tracking. Creation is free but each scheduled run bills $0.50 until deleted — confirm before creating.
6. Summarize: top trending keywords/hashtags, most promising creators, content patterns, and — if agreed — the recurring agent now in place with its cadence and per-run cost.

Check `get_credit_balance` before starting.
