---
name: virlo
description: >
  Social media intelligence for AI agents via the Virlo MCP server. Find what is trending on
  TikTok, YouTube Shorts, and Instagram Reels, find example videos and creators for any topic,
  analyze why a video went viral, look up any creator, track trending sounds and hashtags, pull
  hooks, see what people post at a place, and run one-shot or recurring research agents. Covers
  tool routing, async jobs, credit costs, how to rank results by Virality Score instead of raw
  views, and how to present results the user can act on.
  Use when the user asks to start, kick off or run a research agent on a niche or content topic:
  that means a Virlo research agent, not a general web-research task.
last-updated: 2026-11-26
---

# Virlo: Social Media Intelligence

> **What this skill does to your account.** Read before installing.
>
> - **Spends Virlo credits.** Library searches, trend reads, lookups and research agents bill per
>   call or per run. Tell the user the cost before any paid run, and get a yes before you start a
>   research agent, because a recurring agent bills on every run.
> - **Talks to one endpoint only:** Virlo's hosted MCP server at `https://dev.virlo.ai/api/mcp/mcp`,
>   under the user's own Virlo account (OAuth sign-in, or a `virlo_tkn_...` API key).
> - **Reads public social data only.** It does not post, comment, follow, or touch the user's
>   social accounts. It does not run local commands and does not write files.

Virlo indexes short-form video across TikTok, YouTube Shorts, Instagram Reels, and Meta Ads for
every niche. This skill tells the agent which Virlo tool answers which question, what each call
costs, and how to read the results. Each tool's own description is the source of truth for its
inputs and price; this skill is the map.

> **Freshness check:** if more than 60 days have passed since `last-updated`, tell the user this
> skill may be outdated and point them to the update options below.

## Keeping this skill updated

**Source:** [github.com/Virlo-AI/Virlo-Agent-Plugin](https://github.com/Virlo-AI/Virlo-Agent-Plugin)
**MCP docs and tool reference:** [dev.virlo.ai/docs/mcp](https://dev.virlo.ai/docs/mcp)

| Installation | How to update |
|---|---|
| `npx skills` | `npx skills update` |
| Claude Code plugin | `/plugin marketplace update virlo` |
| Cursor | Reinstall from the Cursor marketplace, or pull the repo |
| Manual | Pull the latest repo and re-copy `skills/virlo/` |

## Setup

The Virlo tools must be connected before this skill can do anything. If no Virlo tool (for
example `find_videos`) is available, the MCP server is not connected. Tell the user:

- **Claude Code / Claude Desktop / claude.ai:** add `https://dev.virlo.ai/api/mcp/mcp` as a
  connector (or install this plugin) and sign in to Virlo when prompted. No key needed.
- **Cursor, VS Code, Windsurf, Codex, other clients:** create a key at
  [dev.virlo.ai/dashboard/api-keys](https://dev.virlo.ai/dashboard/api-keys) (starts with
  `virlo_tkn_`) and send it as `Authorization: Bearer <key>`.

## Route the question to the right tool

| The user asks | Call | Cost |
|---|---|---|
| About their own research, niche or data ("my gym niche", "what did my agent find?", "ads from my data") | `ask_virlo` with their words. It picks their agent and data; it never starts one | free itself; the read it makes costs $0 to $0.25 |
| "Show me viral videos about X" / "What works in niche X?" / videos that look a certain way ("faceless", "talking head", "UGC") | `find_videos` with `topics` in the user's words, main topic first, and every filter in the one call | $0.05 per page of 25; free on the user's own research |
| "Find creators who post about X" / "dermatologists on TikTok" | `find_creators` (`topics`, `bio_keywords`, follower range) | $0.05 per page of 25 |
| "What's trending right now?" / news and pop culture | `get_topic_trends`: `view` today, emerging or range; filter with `category` / `exclude_category` (entertainment, memes, sports, fashion_beauty, gaming_tech, lifestyle, politics, news). Pop culture without politics = `exclude_category: ["politics","news"]` | $0.25 |
| "What format should I copy?" / memes and templates going around | `get_content_trends` (list), with `id` for one trend's 30-day series and examples. Content Trends are formats to make; Topic Trends are subjects to talk about | $0.25 list, $0.05 one trend |
| "What sounds are blowing up?" | `get_trending_sounds`: `view` trending or breakout (rising fastest); `q` searches titles | $0.25, search $0.10 |
| "Which hashtags are big?" / "How is #x doing?" | `search_hashtags` (list for a date window; with `hashtag`, one tag's numbers) | $0.05 |
| "Give me hooks that work" | `search_hooks`: `view` search, trending, library or types | $0.25 search/trending, $0.10 library, types free |
| "Write me hooks / a script" | Read first with `find_videos` (`for_writing: true`), then `show_hooks` or `show_script` with each one's source video | writing tools free |
| Fresh data collected on a topic, or a niche kept up to date | `create_research_agent` (one-shot, or `recurring: true` + `cadence`). See below | $0.50 a run, $1.50 with Data Intelligence |
| Results of a research agent | `get_agent_report` first, then `get_agent_data` for videos, creators, sounds, hashtags, hooks and more | free (hooks $0.25 without Data Intelligence) |
| Change, pause or delete an agent | `update_agent`, `delete_agent` | free |
| "Where's my old research?" / who do I track | `list_my_research` (`kind` agents, lookups or tracked) | free |
| "Tell me about @creator" / "Should we work with them?" / "Who is their audience?" | `lookup_creator` (`creators` for up to 25 at once; `include: "videos,outliers"` for analysis) | $0.50, up to $1.75 with add-ons |
| "Why did this video pop?" | `analyze_video` | $0.50 |
| A hashtag or sound in depth | `lookup_hashtag`, `lookup_sound` | $0.50 base |
| What people post at one place (venue, beach, stadium) | `lookup_place`; places in an area: `find_places`; a topic filtered by place: `find_videos` with `places` | see tool |
| Run a saved lookup again, or what changed since | the lookup tool with `run_id`; `check_job_status` with `run_id` and `data_type: "compare"` | compare free |
| "Track this creator/video over time" | `track_creator`, `track_video` → `get_tracking_data`; older history: `collect_creator_posts` | paid |
| One live fact right now: followers, latest posts, a video's counts, comments, transcript, what a search or hashtag shows | `raw_creator`, `raw_creator_videos`, `raw_video`, `raw_comments`, `raw_transcript`, `raw_search`, `raw_hashtag` | $0.01 per page |
| Meta ads | `raw_ad_search`, `raw_advertiser_search` (find a brand's page), `raw_advertiser_ads`, `raw_ad` | $0.01 per page |
| Balance or what a call cost | `get_credit_balance` | free |

Start with `find_videos` for "what works in X": it reads what Virlo has already analyzed and is
instant. Offer a research agent only when that comes back thin, or the user wants fresh data or a
niche kept up to date.

Each data call draws its own card in Claude and ChatGPT. Answer from one call; do not call again
just to re-sort, page or rank what you already have.

Before you start new paid work, check `list_my_research` for an existing agent on the topic.
Re-reading an existing result is free. Filter by date, platform, or views at read time instead of
paying to re-run.

Instant data reads are billed even when they come back empty. MCP results do not show what a call
cost, so when the user needs the exact charge, compare `get_credit_balance` before and after.

## Research agents

1. Check `list_my_research` for an agent on the same topic. Reuse it if it fits.
2. Write one concrete `intent` sentence: goal + niche + content type + exclusions. Example: "Find
   short-form videos where home cooks show 15-minute weeknight meals, excluding restaurant reviews
   and mukbangs." Pick 7-12 specific multi-word keywords for that one concept.
3. Call `create_research_agent` **without** `user_approved`. It returns a proposal. Most people
   have not heard of a research agent, so explain it in plain words: what it collects, on which
   platforms, how long it takes, what it costs (and that a recurring agent charges every run).
4. Only after the user says yes, call it again with `user_approved: true`.
5. Do not pass `min_views` or `time_range`: collection scope is managed by Virlo. Filter at read time.

Older names (`search_keywords`, `create_niche_monitor`, `suggest_keywords`) still work for saved
scripts but are no longer listed. Use `create_research_agent`.

## Async jobs

- Paid lookups wait up to about 25 seconds, then return a `job_id` if the job is still running.
- Research agents usually finish collecting in about 8 minutes (9 in 10 within 20, up to 45 with
  Meta ads), and the AI report lands a few minutes later.
- Still running is normal. Tell the user it is in progress and roughly when it will be ready, then
  check once with `check_job_status` on their next message. Never call it repeatedly in a row.
- `finalized: true` is the done signal. `status: "completed"` alone can still have AI analysis
  pending. A null analysis field means "not yet", not "no data".
- `partial_failure` is usable data: one platform or keyword failed, the rest succeeded.

## Read results correctly

- **Rank by Virality Score, never raw views.** It is weighted virality,
  `ln(views / followers) × ln(followers)`: ≥ 35 exceptional, 25-35 very strong, 18-25 strong,
  10-18 promising. A breakout from a small account beats a big account's baseline.
- Never compare raw views across platforms. A TikTok view and a YouTube Shorts view are not the
  same unit.
- Prefer `sort: most_viral`, `rising`, or `order_by: weighted_score` / `rising` / `growth` where a
  tool offers it. Raw view sorts over-favor accounts that are already big.
- Many results carry `how_to_read` notes (what a field means, what not to conclude from it). Follow
  them. Example: the last 7 days of a Content Trend's series are still being counted, so a dip
  there is not a decline.
- Posts flagged `is_paid: true` are ads or paid partnerships. Label them as ads, not organic wins.
- When you show audience data, say its `data_source` and `confidence_level`.

## Present results the user can act on

- **Lead with the answer.** Open with the 3-5 findings that matter, each with a real number, the
  creator's handle, and a link to the video. Then the supporting detail.
- **Follow the result's `presentation` hint** when it has one. It names the layout that fits the
  data (ranked list, comparison, time series).
- **Show, don't describe.** Where the host renders markdown images, show the video thumbnail next
  to each pick. Always link the original post so the user can watch it.
- **Compare in a table:** creators, hooks, or sounds side by side with followers, Virality Score,
  and the best example link.
- **Chart time series** (Content Trend series, sound usage history, tracking data) when the host
  can draw one. Otherwise describe the shape in one sentence.
- **End with one next step**, from the result's `next_actions` when present: vet the top creators,
  track one, or start a research agent.

## Limits

- No video downloads (exports are in the Virlo app). No organic Facebook.
- Virlo has no view of where one person has been. Never piece it together from captions or tags.
- Plans, billing and cancelling: app.virlo.ai/billing (app) or dev.virlo.ai/dashboard/billing (API).

## Example prompts

- "What's trending on TikTok in the fitness niche this week?"
- "Show me faceless finance videos that blew up this month."
- "Why did this video go viral? https://www.tiktok.com/@.../video/..."
- "Look up @mrbeast on YouTube and show his outlier videos."
- "Which sounds are breaking out right now that I should use?"
- "Set up a weekly research agent for skincare content on TikTok and Instagram."
- "Write 5 hooks for SaaS founders based on what's working."

## Troubleshooting

| Symptom | Fix |
|---|---|
| Virlo tools missing | The MCP server is not connected. See Setup. |
| 401 / 403 | Key is wrong or revoked. Create a new one at dev.virlo.ai/dashboard/api-keys, or sign in again via OAuth. |
| 402 / out of credits | The reply carries a checkout link to hand the user. Tell them the balance before retrying. |
| `find_videos` comes back thin | Shorten `topics` to the user's own words, drop filters, or offer a research agent for fresh data. |
| A research agent returns no videos | Usually an intent or keyword problem, not an outage. Sharpen the intent and keywords with `update_agent`. |
| Result fields are null | The job is not finalized yet. Check again later. |
