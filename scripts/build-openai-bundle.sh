#!/usr/bin/env bash
#
# Builds dist/virlo-openai-plugin.zip for upload to OpenAI's plugin submission portal.
#
# The archive contains a single top-level plugin directory ("virlo/") holding
# .codex-plugin/plugin.json, skills/, assets/, README.md and LICENSE.
#
# mcp.json, .cursor-plugin/, .grok-plugin/, commands/, rules/ and .git are
# deliberately excluded: OpenAI's validator rejects mcp.json / mcpServers inside an
# uploaded bundle, because the remote MCP server is configured in the portal.

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
plugin_name="virlo"
dist_dir="$repo_root/dist"
stage_dir="$dist_dir/_stage"
plugin_dir="$stage_dir/$plugin_name"
zip_path="$dist_dir/virlo-openai-plugin.zip"

rm -rf "$stage_dir" "$zip_path"
mkdir -p "$plugin_dir"

for dir in .codex-plugin skills assets; do
  cp -R "$repo_root/$dir" "$plugin_dir/$dir"
done
for file in README.md LICENSE; do
  cp "$repo_root/$file" "$plugin_dir/$file"
done

# Guard against the forbidden entries ever sneaking in via a nested path.
if find "$plugin_dir" \( -name 'mcp.json' -o -name '.mcp.json' -o -name '.app.json' \) -print -quit | grep -q .; then
  echo "Forbidden entries found in bundle" >&2
  exit 1
fi

(cd "$stage_dir" && zip -rq "$zip_path" "$plugin_name")
rm -rf "$stage_dir"

echo "Built $zip_path ($(du -h "$zip_path" | cut -f1))"
