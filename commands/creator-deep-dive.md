---
name: creator-deep-dive
description: Deep-dive analysis of a specific creator (platform + username) using Virlo.
---

# Creator deep dive

Given a platform (`youtube` / `tiktok` / `instagram`) and a username:

1. Tell the user the lookup costs $0.50 (audience data +$0.50, trend analysis +$0.50). Call `lookup_creator` with that platform and username and `include: "videos,outliers"`. Add `audience_demographics` / `audience_geography` only if the user asked who their audience is.
2. From the results, identify top-performing videos (outliers, ranked by Virality Score), common themes and hashtags in successful content, posting frequency and consistency, and engagement patterns (views vs likes vs comments).
3. Ask the user before calling `track_creator` to start ongoing daily tracking.
4. Summarize: strengths, content strategy insights, and growth trajectory, with links to the 3 best videos.
