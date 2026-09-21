---
name: virlo-research-conventions
description: Baseline rules for calling any Virlo tool correctly — intent-first research, async job polling and the finalized signal, read-time filtering, ranking, and cost awareness. Read this before any other Virlo skill.
---

# Virlo research conventions

These apply to every Virlo call. Read this before running any other Virlo skill.

## Cost awareness

Virlo is pay-as-you-go against a prepaid balance — there is no subscription, and the balance does not expire. Current per-operation pricing:

| Operation | Cost |
| --- | --- |
| Hashtag lookups | $0.05 / call |
| Trends, video digests | $0.25 / call |
| Content Research Agents | $0.50 / run |
| Satellite analysis (creator, video, sound, hashtag) | $0.50 / call |
| Tracking | $0.25 / cycle |
| Data Intelligence add-on (agents) | +$1.00 / run |
| Data Intelligence add-on (satellite) | +$0.25 / lookup |
| All agent reads and tracking reads | Free |

Call `get_credit_balance` before starting a paid research run. Confirm cost and cadence with the user before creating anything **recurring** — a weekly agent bills $0.50 every week until deleted.

## Intent before keywords

Never invent search keywords directly from a topic. Write one concrete sentence of intent first — goal + content type + exclusions, roughly 40–250 characters — then call `suggest_keywords` with it. If `quality.passes` comes back false, sharpen the intent and retry before searching. Three to seven specific multi-word phrases outperform a long list of single words.

## Async jobs and the done signal

Creation tools (`search_keywords`, `create_niche_monitor`, `lookup_creator`, `analyze_video`, and friends) auto-poll for roughly 25 seconds, then return a `job_id`. Full agent runs take 15–20 minutes at the median.

- Hand the job id back to the user and check later. Do not busy-wait in a tight loop.
- Treat **`finalized: true`** as the done signal, not `status === "completed"` — a run can report completed while secondary AI analysis is still in flight.
- While processing, `pending_jobs[]` lists the secondary work still running, each with a suggested `retry_after_seconds`. Respect it.
- `progress_pct`, `stage`, and `eta_seconds` give live progress.
- `partial_failure` is still usable data. Report what came back rather than discarding the run.

## Filter at read time, not collection time

`min_views` and `time_range` are system-managed at collection and are **rejected** by the agents API. All read tools (`get_keyword_search_results`, `get_niche_monitor_data`, `get_satellite_run`, `get_tracking_report`, `list_creator_posts`) are free and can be called repeatedly — re-slice by date, platform, or `min_views` at read time instead of paying for another search.

## Ranking

Prefer `order_by=weighted_score`, or `rising` / `growth` where offered, over raw view counts when ranking creators, sounds, or hashtags. Raw views over-favor content that already went viral; weighted scoring surfaces what is breaking now. Hashtag and sound results carry lifecycle labels — `new`, `rising`, `steady`, `fading` — use them.

## Naming

The API surface is unified under `/v1/agents`. The older split Orbit (one-shot) and Comet (recurring) endpoints are deprecated in favour of it — documentation lists them as slated for removal, though they remain live and continue to serve requests, and a legacy orbit_id or comet_id is interchangeable with an agent id. Prefer `/v1/agents` regardless.

"Niche monitor" is no longer the product term — they are **one-shot agents** and **recurring agents**. The MCP tool names still carry the legacy wording (`create_niche_monitor`, `get_niche_monitor_data`); call the tools by their real names but use current terminology when talking to the user.

## Further reading

Before non-trivial research, read the MCP resources — they carry the canonical guidance:

- `virlo://docs/agent-playbook` — intent routing and result interpretation
- `virlo://docs/intent-cookbook` — worked intent examples
- `virlo://docs/credit-costs` — authoritative live pricing
- `virlo://docs/api-overview` — endpoint map
