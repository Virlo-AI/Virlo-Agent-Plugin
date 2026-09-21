---
name: hashtag-research
description: Research hashtags on short-form video — ranked lists, per-tag performance and growth, and top creators per tag — using Virlo.
---

# Hashtag research

Hashtags are the cheapest Virlo surface at $0.05/call, which makes them the right first probe before spending on an agent run.

1. **Pick the right tool.** `search_hashtags` ($0.05) returns the overall ranked list for a date range — it answers "what tags are hot" and will *not* tell you how one specific tag is doing. `get_hashtag_performance` ($0.05) returns per-hashtag detail for tags you name — use this when the user asks about a specific topic.
2. **Depth.** `lookup_hashtag` ($0.50 plus variable add-ons) runs a full satellite analysis — top creators per tag, associated sounds, content patterns. Confirm the spend, then poll `get_satellite_run` (free) until `finalized: true`.
3. **Rank by growth, not volume.** A tag with 400M cumulative views that's been flat for months is worse than one at 8M that doubled this week. Lead with the lifecycle labels (`new`/`rising`/`steady`/`fading`) and say plainly when a tag is fading.

If a research agent is already running for this topic, prefer its free `hashtags` read (`order_by: growth`, includes top creators per tag) over a paid platform-wide call.

Deliver: which tags to use now, which are saturated, which are emerging, the creators already winning on each, and a concrete tag set for the user's next post — with the growth evidence behind each pick.
