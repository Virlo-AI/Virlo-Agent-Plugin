# Virlo plugin

Connects [Virlo](https://virlo.ai)'s TikTok, YouTube Shorts, and Instagram Reels intelligence API — trend and sound discovery, creator and video lookups, content research agents, audience demographics, and long-term tracking — to Cursor, Grok Build, and OpenAI's plugin directory.

## Included

- `mcp.json`: Virlo's hosted remote MCP server (`https://dev.virlo.ai/api/mcp/mcp`, ~49 tools — check [dev.virlo.ai/docs/mcp](https://dev.virlo.ai/docs/mcp) for the current count)
- `skills/`: seven skills — `virlo-research-conventions`, `trend-scout`, `creator-deep-dive`, `niche-analysis`, `genre-monitor`, `sound-intelligence`, `hashtag-research`, `creator-tracking` (read by OpenAI/Codex)
- `commands/`: the same workflows as slash commands (read by Cursor)
- `rules/virlo-api-usage.mdc`: intent-first research, async job polling, and cost awareness (Cursor rule; not a component Grok Build reads)
- `assets/logo.svg`, `assets/icon.svg`: Virlo logo, and a square 1024×1024 variant for directory listings
- `.cursor-plugin/plugin.json`, `.grok-plugin/plugin.json`, `.codex-plugin/plugin.json`: per-client manifests (Cursor, Grok Build, OpenAI)

## Setup

1. Get an API key at [dev.virlo.ai/dashboard/api-keys](https://dev.virlo.ai/dashboard/api-keys) (starts with `virlo_tkn_`).
2. Set `VIRLO_API_KEY` in your environment (`mcp.json` reads it via `${env:VIRLO_API_KEY}`, Cursor's substitution syntax — confirm your client's equivalent if it differs).
3. Install this plugin and restart your client.

Full tool reference: [dev.virlo.ai/docs/mcp](https://dev.virlo.ai/docs/mcp).

## Pricing

Pay-as-you-go against a prepaid balance, no subscription:

| Operation | Cost |
| --- | --- |
| Hashtag lookups | $0.05 / call |
| Trends, video digests | $0.25 / call |
| Content Research Agents | $0.50 / run |
| Satellite analysis | $0.50 / call |
| Tracking | $0.25 / cycle |
| Data Intelligence (agents) | +$1.00 / run |
| Data Intelligence (satellite) | +$0.25 / lookup |
| Agent reads, tracking reads | Free |

Most research tools here are billed per call, so they're exposed as explicit commands and skills rather than always-on behaviour — the agent doesn't spend without the user asking. Recurring agents and tracking bill on every cycle until deleted or untracked.

## Network & credentials

The only endpoint this plugin talks to is Virlo's own MCP server, `https://dev.virlo.ai/api/mcp/mcp`, authenticated with the `VIRLO_API_KEY` you provide (a `virlo_tkn_...` bearer token, sent only in the `Authorization` header of that request). No other network calls, no telemetry, no filesystem access beyond what your client already grants the MCP process.

## Layout

Single-plugin repo per the [Cursor plugin template](https://github.com/cursor/plugin-template): plugin files live at the repo root, one `.cursor-plugin/plugin.json`, no `marketplace.json`. `.grok-plugin/plugin.json` is the equivalent manifest for [xAI's plugin marketplace](https://github.com/xai-org/plugin-marketplace), and `.codex-plugin/plugin.json` for [OpenAI's plugin directory](https://developers.openai.com/plugins/deploy/submission).

## Building the OpenAI submission bundle

```bash
./scripts/build-openai-bundle.sh      # or: pwsh scripts/build-openai-bundle.ps1
```

This writes `dist/virlo-openai-plugin.zip` containing only `.codex-plugin/`, `skills/`, `assets/`, `README.md`, and `LICENSE`. `mcp.json` is deliberately excluded — OpenAI's validator rejects `mcp.json` / `mcpServers` inside an uploaded bundle, because the remote MCP server is configured in the submission portal rather than in the archive.

Submit at the [plugin submission portal](https://developers.openai.com/plugins/deploy/submission): choose **With MCP** (hybrid), point the MCP config at `https://dev.virlo.ai/api/mcp/mcp`, complete domain verification at `/.well-known/openai-apps-challenge`, and upload this zip on the Skills step.
