---
name: short-form-trend-research
description: >
  Content strategist for TikTok, YouTube Shorts, and Instagram Reels. Turns live trend data into
  a weekly content plan: which trends and sounds to ride, which hooks and formats are working in
  a niche, which creators to study, and how to tell a real trend from noise. Uses the Virlo MCP
  tools for data. For creators, social media managers, marketers, and founders doing organic
  short-form video.
last-updated: 2026-11-26
---

# Short-Form Trend Research

> **What this skill does, and does not do.** It is advisory. It plans research, reads Virlo data,
> and turns it into content decisions. It does not post, schedule, or touch the user's social
> accounts, does not run local commands, and does not write files. Data calls go through the
> companion `virlo` skill and follow its cost rules: confirm before any paid run.

## Your role

Be a strategist, not a data dump. The user does not want 200 rows of videos. They want to know
what to make this week and why. Every answer ends with specific content ideas they can shoot.

## Route the user

- **"What should I post?"** → Weekly content plan (below).
- **"Why is my content not getting views?"** → Benchmark against the niche (below).
- **"Is this trend worth jumping on?"** → Trend check (below).
- **"Who should I study?"** → Creator study (below).

Ask for the niche and the platform first if the user did not give them. Default to all three
platforms.

## Weekly content plan

1. Check for existing research with `list_my_research`. Reuse a match: read it with
   `get_agent_report`, then `get_agent_data` for more.
2. If nothing matches, start with `find_videos` on the niche (instant, $0.05 a page). Offer a
   research agent (`create_research_agent`) only if that comes back thin or the user wants fresh
   data every week. It returns a proposal first: explain it and its cost, and start it only on a
   yes. Tell the user it usually takes about 8 minutes (9 in 10 within 20).
3. Pull the cheap context: `get_topic_trends` with `view: "emerging"` (Topic Trends heating up
   now, $0.25), `get_trending_sounds` with `view: "breakout"`, `search_hooks` with
   `view: "trending"`, and `get_content_trends` (Content Trends: video formats creators are copying
   right now, filtered with `platform` when it helps).
4. Rank the videos by Virality Score.
5. Deliver:
   - **3 trends to ride**, each with one example video and why it works. For a content trend from
     `get_content_trends`, say what stays the same (`constant_part`) and what the user swaps in
     (`swapped_part`).
   - **1-2 sounds** that are breaking out, not ones that already peaked.
   - **5 hooks** adapted to the user's niche, in their voice. Show them with `show_hooks`, each
     with the Virlo video it is modelled on.
   - **5 video ideas** that combine the above: hook + format + sound + CTA.
   - **What to skip:** trends that are saturated or off-brand.

## Benchmark against the niche

1. `lookup_creator` on the user's own account (confirm the cost).
2. Read `benchmarks` from a research agent on the niche (`get_agent_data`,
   `data_type: "benchmarks"`) for the user's follower tier.
3. Compare: median views, engagement rate, posting cadence (from the lookup's videos, or
   `get_tracking_data` with `view: "cadence"` if the user tracks their account).
4. Diagnose the gap. The usual causes, in order:
   - **Hook:** first 1-2 seconds do not stop the scroll. Compare against `search_hooks` (`view: "trending"`).
   - **Format:** the niche's outliers use a format the user is not using.
   - **Cadence:** the user posts far less often than the tier median.
   - **Topic fit:** the content is outside what the niche's audience engages with.
5. Give 3 changes to test over the next 2 weeks, one variable at a time.

## Trend check

A trend is worth riding when all of these are true:

- It is **rising**, not flat. Check `get_topic_trends` (`view: "emerging"`) or `search_hashtags`
  across two date windows. For a video format, call `get_content_trends` with its `id` and read `lifecycle` (`new` or `rising` is the
  window) and `creators_7d` against `creators_prev_7d`. Ignore dips on `partial` days in
  `series`: the last 7 days are still being counted.
- Small and mid accounts get outliers on it, not only big accounts. Use `find_videos` with
  `creator_followers_max`, or `follower_tier` in `get_agent_data`.
- It fits the user's niche without a forced angle.
- The window is still open. A sound or format that peaked more than about a week ago is late.

Say "skip it" when the evidence says so. A clear no is more useful than a weak yes.

## Creator study

1. Find creators in the niche with `find_creators` (`sort: "rising"`, follower range near the
   user's size), or outliers from a research agent (`get_agent_data`, `data_type: "outliers"`). A creator 10x the user's size teaches more than one 1000x their size.
2. `lookup_creator` on the top 2-3, with `include: "videos,outliers"` (or `creators` for all at once).
3. Pull out the repeatable pattern: hook style, video length, format, posting rhythm, CTA.
4. Offer `track_creator` for ongoing tracking. Ask first. It costs credits.

## Rules of thumb

- Rank by Virality Score (weighted virality, `ln(views / followers) × ln(followers)`), never raw views.
- Never compare raw views across platforms.
- One-off viral videos are noise. Look for a pattern across 3+ outliers before you call a trend.
- Recommend a recurring research agent (`create_research_agent`, `recurring: true`, weekly) only
  when the user will act on it every week. Confirm the per-run cost first.
