---
name: niche-analysis
description: Full niche analysis (research agent + creators + recurring monitor) for a given niche, using Virlo.
---

# Full niche analysis

Given a niche or topic:

1. Draft a concrete one-sentence intent (goal + content type + exclusions). Call `suggest_keywords` with that intent; if `quality.passes` is false, sharpen the intent and retry. Never invent intent from a keyword list.
2. Call `search_keywords` with the same intent and the suggested keywords (one-shot Content Research Agent). Do not pass `min_views` or `time_period`; filter at read time. It usually finishes collecting in about 8 minutes (9 in 10 within 20). If it is still running, tell the user and check again on their next message; never call it repeatedly in a row.
3. Call `get_keyword_search_results` to review videos, creator outliers (prefer `order_by=weighted_score`), AI analysis, and trend themes.
4. Call `lookup_creator` on the top 2-3 creator outliers for full profiles and video analytics.
5. Offer a recurring research agent for ongoing tracking. Tell the user it costs $0.50 per run (weekly by default) and create it with `create_niche_monitor` (same intent + best keywords, cadence `weekly`) only after they say yes.
6. Summarize, leading with the 3-5 findings that matter: most promising creators (handle, Virality Score, a link to their best video), content patterns, top trending keywords and hashtags, and whether a recurring agent is now in place.

Check `get_credit_balance` before starting and tell the user the cost: $0.50 for the research agent and $0.50 per creator lookup.
