---
name: niche-analysis
description: Full niche analysis (library videos + creators + optional research agent) for a given niche, using Virlo.
---

# Full niche analysis

Given a niche or topic:

1. Call `find_videos` with the niche as `topics` in the user's words, main topic first ($0.05 a page). Put every filter the user gave (platform, dates, creator size) in this one call.
2. Call `find_creators` on the same topics with `sort: "rising"` to find creators breaking out ($0.05 a page).
3. Check `list_my_research` for an existing research agent on this niche. If one exists, read `get_agent_report` (free) for what works, hooks, trends and rising creators.
4. Offer `lookup_creator` ($0.50 each, `include: "videos,outliers"`) on the top 2-3 creators. Run it only on a yes.
5. If the library results are thin, or the user wants fresh data kept up to date, offer a research agent: call `create_research_agent` (one-shot, or `recurring: true` with `cadence: "weekly"`) without `user_approved`, explain the proposal and its cost ($0.50 a run, charged every run if recurring), and start it with `user_approved: true` only after a yes.
6. Summarize, leading with the 3-5 findings that matter: most promising creators (handle, Virality Score, a link to their best video), content patterns, formats and hooks, and whether a research agent is now running.
