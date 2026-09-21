---
name: niche-analysis
description: Full niche analysis using a Virlo Content Research Agent — intent drafting, keyword suggestion, a one-shot research run, creator outlier lookups, and an optional recurring monitor.
---

# Full niche analysis

Given a niche or topic. Follow `virlo-research-conventions` — especially intent-first research and the `finalized: true` done signal.

## Steps

1. **Balance.** Call `get_credit_balance` before starting. A one-shot agent costs $0.50, or $1.50 with Data Intelligence.
2. **Intent.** Draft one concrete sentence: goal + content type + exclusions, roughly 40–250 characters. Call `suggest_keywords` with it. If `quality.passes` is false, sharpen the intent and retry. Never assemble an intent backwards from a keyword list.
3. **Run the agent.** Call `search_keywords` with the same intent and the suggested keywords — a one-shot Content Research Agent. Notes:
   - Do **not** pass `min_views` or `time_period`; the agents API rejects them. Filter at read time.
   - `platforms` defaults to all three; narrow it only if the user asked.
   - `english_only` defaults to true — set it false for a multilingual niche.
   - `exclude_keywords` removes noise terms, matched as whole words against captions and hashtags.
   - Expect 15–20 minutes. Hand back the id and poll until `finalized: true`.
4. **Read the results** (all reads are free):
   - `get_keyword_search_results` for videos, creator outliers (`order_by=weighted_score`), AI analysis, and trend themes
   - Slideshows, ads, sounds, and hashtags each have their own read surface — hashtags and sounds carry `new` / `rising` / `steady` / `fading` lifecycle labels
   - Creator outliers include `content_angle` and `author_id`, which is the handle for follow-up lookups
5. **Creator depth.** Call `lookup_creator` on the top 2–3 outliers ($0.50 each) for full profiles and video analytics. Confirm the count with the user first.
6. **Ongoing coverage.** Offer a recurring agent: `create_niche_monitor` with the same intent and best keywords, cadence `weekly`. Creation is free but each scheduled run bills $0.50 — confirm cadence and cost before creating it.

## Deliver

Top trending keywords and hashtags, the most promising creators with why they stand out, the content patterns that repeat across winners, and — if the user agreed — the recurring agent now in place with its cadence and running cost stated plainly.
