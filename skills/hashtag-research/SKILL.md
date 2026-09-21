---
name: hashtag-research
description: Research hashtags on short-form video — ranked hashtag lists for a date range, per-hashtag performance and growth momentum, and full satellite lookups with top creators per tag.
---

# Hashtag research

Hashtags are the cheapest Virlo surface at $0.05/call, which makes them the right first probe before spending on an agent run. Follow `virlo-research-conventions`.

## Pick the right tool

The two list-shaped tools are not interchangeable, and this is the most common mistake:

- `search_hashtags` ($0.05) returns the **overall ranked list** for a date range. It answers "what tags are hot". It will **not** tell you how one specific tag is doing.
- `get_hashtag_performance` ($0.05) returns **per-hashtag detail** for tags you name. This is the one to use when the user asks about a specific topic.

For depth, `lookup_hashtag` ($0.50, plus variable add-ons) runs a full satellite analysis — top creators per tag, associated sounds, and content patterns. Poll `get_satellite_run` (free) until `finalized: true`. Confirm the spend first.

## Reading momentum

Rank by growth rather than absolute volume. A tag with 400M cumulative views that has been flat for months is worse than one at 8M that doubled this week. Where lifecycle labels are present — `new`, `rising`, `steady`, `fading` — lead with them, and say plainly when a tag is fading.

## Within a research agent

A running agent exposes a free `hashtags` read surface with `order_by: growth`, including the top creators per tag, scoped to that niche. When an agent is already running for the topic, prefer that read over a paid platform-wide call — it is both free and better targeted.

## Deliver

Which tags to use now, which are saturated, which are emerging, the creators already winning on each, and a concrete tag set the user can put on their next post — with the growth evidence behind each pick.
