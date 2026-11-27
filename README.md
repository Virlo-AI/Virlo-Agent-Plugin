# Virlo Agent Plugin

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-0.5.0-green.svg)](https://github.com/Virlo-AI/Virlo-Agent-Plugin)
[![MCP](https://img.shields.io/badge/MCP-remote_server-8A2BE2)](https://dev.virlo.ai/docs/mcp)
[![Agent Plugins](https://img.shields.io/badge/Agent_Plugins-1.0.0-black)](https://agent-plugins.org)

Give your AI agent a social media brain. Find what's trending on **TikTok, YouTube Shorts, and Instagram Reels**, see why a video went viral, look up any creator, and catch trending sounds and hashtags before they peak, all from Claude, Cursor, Grok, Codex, or any MCP client.

**Works with:** Claude Code, Claude Desktop, claude.ai, Cursor, Grok Build, VS Code, Windsurf, OpenAI Codex, and any MCP-compatible agent.

Built on the [Virlo API](https://dev.virlo.ai/docs/mcp). [Virlo](https://virlo.ai) is a short-form social intelligence platform covering TikTok, YouTube Shorts, Instagram Reels, and Meta Ads across every niche.

## What your agent can do

- **Find what works:** search Virlo's library of analyzed short-form videos and creators by topic, look ("faceless", "talking head", "UGC"), platform, dates, creator size or region
- **Spot trends early:** emerging Topic Trends, today's Topic Trends by region (filter by category, e.g. pop culture without politics), and Content Trends (formats creators are copying)
- **Explain virality:** break down why a specific video popped (hook, format, sound, timing)
- **Research any niche:** run a research agent that collects fresh videos for a topic and reports what works, the top videos, rising creators, and content patterns
- **Monitor a niche every week:** recurring research agents that surface rising sounds, hashtags, and creators
- **Ask about your own research:** "what did my gym agent find?" answers from the user's own agents and data
- **Look up creators:** profile, outlier videos, audience demographics and geography, posting cadence
- **Find trending sounds and hashtags:** breakout audio, sound usage history, hashtag growth
- **Write hooks that work:** trending hooks, a searchable hook library, and hooks and scripts written from real videos
- **See what's posted at a place:** a venue, beach or stadium, and places creators tag in an area
- **Pull live raw data:** a creator's latest posts, a video's counts, comments, transcripts, and Meta ads
- **Track over time:** daily tracking of creators and videos with signal reports

## Install

### Skill (Claude Code, Cursor, Codex, Windsurf, and other agents)

```bash
npx skills add Virlo-AI/Virlo-Agent-Plugin
```

Two skills ship in this repo:

| skill | what it does |
|---|---|
| `virlo` | Routes each question to the right Virlo tool, handles async research jobs, keeps credit spend visible |
| `short-form-trend-research` | Content strategist: turns live trend data into a weekly plan of trends, sounds, hooks, and video ideas |

Install just one with `--skill`:

```bash
npx skills add Virlo-AI/Virlo-Agent-Plugin --skill short-form-trend-research
```

The skills need the Virlo MCP server connected. See [MCP server](#mcp-server).

### Claude Code plugin

```
/plugin marketplace add Virlo-AI/Virlo-Agent-Plugin
/plugin install virlo@virlo
```

The plugin connects the MCP server for you. Sign in to Virlo when prompted. No API key needed.

### Grok Build plugin

```
/plugin marketplace add xai-org/plugin-marketplace
/plugin install virlo@xai-official
```

The plugin connects the MCP server for you. Sign in to Virlo when prompted. No API key needed.

<details>
<summary>Cursor and manual install</summary>

**Cursor:** install **Virlo** from the Cursor plugin marketplace, then set `VIRLO_API_KEY` in your environment (see [Setup](#setup)).

**Manual:** clone this repo and copy `skills/virlo/` (and optionally `skills/short-form-trend-research/`) into your project's `.claude/skills/` or `.cursor/skills/` folder.

**Local development:**

```bash
claude --plugin-dir ./Virlo-Agent-Plugin
```

</details>

## Agent Plugins standard

This repo is a portable [Agent Plugin](https://agent-plugins.org) (spec 1.0.0). Root `plugin.json` + `mcp.json` + `skills/` let any compatible client load the Virlo skills and connect to the hosted MCP server from this one package. Client-specific manifests live side by side:

| file | client |
|---|---|
| `plugin.json`, `mcp.json` | Agent Plugins 1.0.0 (Cursor, VS Code, and others as they adopt it) |
| `.claude-plugin/`, `.mcp.json` | Claude Code (OAuth, no key) |
| `.cursor-plugin/plugin.json` | Cursor marketplace |
| `.grok-plugin/plugin.json`, `.mcp.json` | Grok Build (xAI plugin marketplace) |
| `server.json` | [MCP Registry](https://registry.modelcontextprotocol.io) |
| `rules/virlo-api-usage.mdc` | Cursor always-apply rule |
| `commands/` | Slash commands (Claude Code, Cursor) |

## Setup

**Claude Code, Claude Desktop, claude.ai, Grok Build:** nothing to set up. Sign in to Virlo when the client asks. A dedicated API key is created for you.

**Cursor, VS Code, Windsurf, Codex, and other clients:**

1. Create an API key at [dev.virlo.ai/dashboard/api-keys](https://dev.virlo.ai/dashboard/api-keys). It starts with `virlo_tkn_`.
2. Set it in your environment:

   ```bash
   export VIRLO_API_KEY=virlo_tkn_xxxxx
   ```

   Add it to `~/.zshrc` or `~/.bashrc` to keep it across sessions. `mcp.json` reads it as `${env:VIRLO_API_KEY}` (Cursor syntax; check your client's equivalent).
3. Restart your client.

### Start using it

Ask your agent things like:

- "What's trending on TikTok in the fitness niche this week?"
- "Why did this video go viral?" (paste a TikTok, Shorts, or Reels link)
- "Look up @creator on YouTube and show me their outlier videos."
- "Which sounds are breaking out right now?"
- "Give me 10 hooks that work for SaaS founders on short-form."
- "Set up a weekly monitor for skincare content on TikTok and Instagram."
- "Plan my next week of Reels for a home-cooking account."

## Slash commands

| command | what it does |
|---|---|
| `/trend-scout` | Trend report across TikTok, Shorts, and Reels: emerging trends, viral videos, breakout sounds, rising hashtags |
| `/creator-deep-dive` | Full analysis of one creator: outliers, themes, cadence, engagement |
| `/niche-analysis` | Research agent + top creators + recurring monitor for a niche |
| `/genre-monitor` | Recurring TikTok genre or scene monitor with sound, hashtag, and creator signals |

## MCP server

Virlo runs a hosted, remote MCP server. Any MCP client can connect directly, with no install.

- **Endpoint:** `https://dev.virlo.ai/api/mcp/mcp` (streamable HTTP)
- **Auth:** OAuth 2.0 with dynamic client registration (Claude clients), or `Authorization: Bearer virlo_tkn_...`

**Claude Code (no plugin):**

```bash
claude mcp add --transport http virlo https://dev.virlo.ai/api/mcp/mcp
```

**Claude Desktop / claude.ai:** add a custom connector with the endpoint URL above and sign in. Leave the OAuth client ID and secret blank.

**Cursor / VS Code / other HTTP clients:**

```json
{
  "mcpServers": {
    "virlo": {
      "url": "https://dev.virlo.ai/api/mcp/mcp",
      "headers": { "Authorization": "Bearer virlo_tkn_your_key_here" }
    }
  }
}
```

**Clients without remote MCP support (via `mcp-remote`):**

```json
{
  "mcpServers": {
    "virlo": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://dev.virlo.ai/api/mcp/mcp", "--header", "Authorization: Bearer virlo_tkn_your_key_here"]
    }
  }
}
```

### Tools

44 tools. The current list and pricing live at [dev.virlo.ai/docs/mcp](https://dev.virlo.ai/docs/mcp).

| area | tools |
|---|---|
| Your own research and data | `ask_virlo`, `list_my_research` |
| Videos and creators in Virlo's library | `find_videos`, `find_creators` |
| Topic Trends (topics people are talking about, by region; `category` / `exclude_category` filters) | `get_topic_trends` |
| Content Trends (video formats creators are copying right now) | `get_content_trends` |
| Sounds, hashtags, hooks | `get_trending_sounds`, `search_hashtags`, `search_hooks` |
| Research agents (one-shot or recurring) | `create_research_agent`, `get_agent_report`, `get_agent_data`, `update_agent`, `delete_agent` |
| Lookups | `lookup_creator`, `analyze_video`, `lookup_hashtag`, `lookup_sound`, `lookup_place`, `find_places`, `check_job_status` |
| Tracking | `track_creator`, `track_video`, `untrack_creator`, `untrack_video`, `update_tracking_settings`, `get_tracking_data`, `collect_creator_posts` |
| Writing | `show_hooks`, `show_script` |
| Live raw data | `raw_search`, `raw_hashtag`, `raw_video`, `raw_comments`, `raw_transcript`, `raw_creator`, `raw_creator_videos` |
| Meta ads | `raw_ad_search`, `raw_advertiser_search`, `raw_advertiser_ads`, `raw_ad` |
| Account | `get_credit_balance`, `top_up_credits`, `set_auto_top_up` |

Tool names from before November 2026 (`search_keywords`, `create_niche_monitor`, `get_trending_videos`, `get_emerging_trends`, and others) still work, so saved scripts keep running, but they are no longer listed.

## Costs

Library searches (`find_videos`, `find_creators`) cost $0.05 per page of 25. Trend, sound and hook reads cost $0.10 to $0.25. Lookups start at $0.50. Research agents cost $0.50 per run (+$1.00 with Data Intelligence), and recurring agents bill on every run. Re-reading your own agents and results is free. The `virlo` skill tells you the cost and asks before it starts a research agent. Full pricing: [dev.virlo.ai/docs/mcp](https://dev.virlo.ai/docs/mcp).

## Troubleshooting

### Virlo tools do not show up

The MCP server is not connected. Claude clients: sign in again. Other clients: confirm `VIRLO_API_KEY` is set in the environment your client starts from, then restart the client.

### 401 or 403 errors

The key is wrong or revoked. Create a new one at [dev.virlo.ai/dashboard/api-keys](https://dev.virlo.ai/dashboard/api-keys).

### A research run returns no videos

This is almost always an intent or keyword problem, not an outage. Write a sharper one-sentence intent and update the keywords with `update_agent`.

### Results have empty fields

The job is not finished. Wait for `finalized: true`. Research agents usually finish collecting in about 8 minutes (9 in 10 within 20).

## Network & credentials

The only endpoint this plugin talks to is Virlo's MCP server, `https://dev.virlo.ai/api/mcp/mcp`, authenticated with OAuth or the `VIRLO_API_KEY` you provide (sent only in the `Authorization` header of that request). No other network calls, no telemetry, no local commands, no file writes. The skills read public social data only. They never post to or change your social accounts.

## Links

- [Virlo](https://virlo.ai)
- [MCP setup and tool reference](https://dev.virlo.ai/docs/mcp)
- [API keys](https://dev.virlo.ai/dashboard/api-keys)

## License

MIT
