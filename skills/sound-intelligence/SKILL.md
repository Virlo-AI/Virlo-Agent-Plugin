---
name: sound-intelligence
description: Find and evaluate audio for short-form video — trending and breakout sounds, sound search, usage history and lifecycle stage, the videos riding a sound, and a creator's audio strategy.
---

# Sound intelligence

Audio is the cheapest lever in short-form video, and the window on a sound is short. Follow `virlo-research-conventions`.

## Finding audio

- `get_breakout_sounds` ($0.25) — audio accelerating off a small base. **This is the early signal.** Prefer it when the user wants something before it saturates.
- `get_trending_sounds` ($0.25) — what is already large. Useful for safety, not for edge.
- `search_sounds` ($0.10) — find a specific track or artist by name.

## Evaluating a sound

Once a candidate is in hand:

1. `get_sound_details` ($0.05; +$0.10 for the optional trends block) — metadata plus where it sits in its lifecycle.
2. `get_sound_usage_history` ($0.05) — the shape of the curve. A sound still climbing is worth using; one that has flattened is already late.
3. `get_sound_videos` ($0.25) — the videos riding it. Read these for the *format* that works with this audio, not just the count.
4. `lookup_sound` ($0.50; +$0.50 with the trends add-on) — the full satellite run when the user needs depth. Ask before spending it; poll `get_satellite_run` (free) until `finalized: true`.

## Creator audio strategy

`get_creator_sounds` ($0.25) shows the audio a specific creator reaches for and whether they adopt trends early or late. Pair it with the `creator-deep-dive` skill.

## Within a research agent

A running agent exposes its own `sounds` read surface for free — `order_by: rising` gives audio breaking out inside that specific niche, which is usually more actionable than a platform-wide trending list. Prefer it when an agent is already running for the niche in question.

## Deliver

Name the sound, its lifecycle stage and direction, how crowded it already is, the video formats working with it, and how long the window likely stays open. Say plainly when a sound is already too late.
