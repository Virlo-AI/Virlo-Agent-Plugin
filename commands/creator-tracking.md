---
name: creator-tracking
description: Put creators or videos under long-term Virlo tracking and read the reports, cadence, and post history.
---

# Creator and video tracking

Tracking answers "what is this account doing over time", which a one-off lookup can't. It bills **$0.25 per cycle, per item, for as long as it runs**.

1. **Before starting.** Call `get_credit_balance`, then state the recurring cost and get explicit agreement. Ten creators on a daily cycle is $2.50/day, not a one-time $2.50 — make that arithmetic visible.
2. **Start.** `track_creator` for recurring creator snapshots (optional collection depth costs extra), `track_video` for one video's performance curve. `update_tracking_settings` changes cadence or depth later (free).
3. **Read** (all free): `list_tracked_items` for what's currently running and billing — check this first, it's also how you find forgotten trackers. `get_tracking_report` for snapshots and AI reports. `list_creator_posts` for collected post history. `get_posting_cadence` for frequency, consistency, and drift.
4. **Back-fill.** `collect_creator_posts` pulls history beyond what tracking has gathered, priced by depth ($0.50 / $1.00 / $2.00) — name the tier and cost before calling.
5. **Stop.** `untrack_creator` and `untrack_video` end the cycle and the billing (both free). Remind the user tracking keeps charging until untracked, and offer to review `list_tracked_items` periodically.

Deliver trajectory rather than a snapshot: growing or flattening, cadence changes, which posts broke the pattern, and what the trend line implies for the next few weeks. Close with what's tracked and what it costs per cycle.
