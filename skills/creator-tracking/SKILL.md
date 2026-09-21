---
name: creator-tracking
description: Put creators or videos under long-term Virlo tracking and read the results — recurring snapshots, tracking reports, posting cadence, back-collected post history, and how to stop the billing.
---

# Creator and video tracking

Tracking answers "what is this account doing over time", which a one-off lookup cannot. It bills **$0.25 per cycle, per tracked item, for as long as it runs** — so it is the one Virlo surface where the standing cost matters more than the setup cost. Follow `virlo-research-conventions`.

## Before starting

Call `get_credit_balance`, then state the recurring cost to the user and get explicit agreement. Ten tracked creators on a daily cycle is $2.50/day, not a one-time $2.50 — make that arithmetic visible rather than assumed.

## Starting

- `track_creator` — recurring snapshots of a creator ($0.25/cycle; optional collection depth costs extra).
- `track_video` — recurring snapshots of one video's performance curve ($0.25/cycle).
- `update_tracking_settings` — change cadence or depth on something already tracked (free).

## Reading (all free)

- `list_tracked_items` — what is currently running and therefore billing. Check this first; it is also how you find forgotten trackers.
- `get_tracking_report` — snapshots and AI reports over the tracked window.
- `list_creator_posts` — the post history collected so far.
- `get_posting_cadence` — frequency, consistency, and drift in when they publish.

## Back-filling history

`collect_creator_posts` pulls historical posts beyond what tracking has gathered. It is priced by depth — $0.50, $1.00, or $2.00 — so name the tier and its cost before calling it.

## Stopping

`untrack_creator` and `untrack_video` end the cycle and the billing. Both are free. Proactively remind the user that tracking keeps charging until untracked, and offer to review `list_tracked_items` periodically.

## Deliver

Trajectory rather than a snapshot: is the account growing or flattening, has posting cadence changed, which posts broke the pattern, and what the trend line implies for the next few weeks. Always close with what is currently tracked and what it costs per cycle.
