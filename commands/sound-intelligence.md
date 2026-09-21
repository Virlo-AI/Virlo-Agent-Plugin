---
name: sound-intelligence
description: Find and evaluate short-form audio — breakout sounds, usage history, lifecycle stage, and the videos riding a sound — using Virlo.
---

# Sound intelligence

Audio is the cheapest lever in short-form video and the window on a sound is short.

1. **Find candidates.** `get_breakout_sounds` ($0.25) for audio accelerating off a small base — this is the early signal. `get_trending_sounds` ($0.25) for what's already large (safety, not edge). `search_sounds` ($0.10) to find a specific track or artist.
2. **Evaluate.** `get_sound_details` ($0.05; +$0.10 for the trends block) for metadata and lifecycle stage. `get_sound_usage_history` ($0.05) for the shape of the curve — still climbing is worth using, flattened is already late.
3. **Read the format.** `get_sound_videos` ($0.25) for the videos riding it; read these for the format that works with the audio, not just the count.
4. **Depth.** `lookup_sound` ($0.50; +$0.50 with trends) runs a full satellite analysis — ask before spending, then poll `get_satellite_run` (free) until `finalized: true`.
5. **Creator angle.** `get_creator_sounds` ($0.25) shows the audio a specific creator reaches for and whether they adopt early or late.

If a research agent is already running for this niche, prefer its free `sounds` read (`order_by: rising`) over a paid platform-wide call — it's both free and better targeted.

Deliver: the sound, its lifecycle stage and direction, how crowded it is, the formats working with it, and how long the window likely stays open. Say plainly when a sound is already too late.
