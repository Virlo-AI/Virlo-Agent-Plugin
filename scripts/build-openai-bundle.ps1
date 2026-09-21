<#
Builds dist/virlo-openai-plugin.zip for upload to OpenAI's plugin submission portal.

The archive contains a single top-level plugin directory ("virlo/") holding
.codex-plugin/plugin.json, skills/, assets/, README.md and LICENSE.

mcp.json, .cursor-plugin/, .grok-plugin/, commands/, rules/ and .git are
deliberately excluded: OpenAI's validator rejects mcp.json / mcpServers inside an
uploaded bundle, because the remote MCP server is configured in the portal.

Entries are written by hand rather than with Compress-Archive, which emits
backslash-separated entry names on Windows PowerShell. OpenAI's validator
requires forward slashes and rejects the archive otherwise.
#>

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$pluginName = 'virlo'
$distDir = Join-Path $repoRoot 'dist'
$zipPath = Join-Path $distDir 'virlo-openai-plugin.zip'

$include = @(
    @{ Kind = 'Dir';  Path = '.codex-plugin' },
    @{ Kind = 'Dir';  Path = 'skills' },
    @{ Kind = 'Dir';  Path = 'assets' },
    @{ Kind = 'File'; Path = 'README.md' },
    @{ Kind = 'File'; Path = 'LICENSE' }
)

# Resolve the flat list of (source file, archive entry name) pairs.
$entries = @()
foreach ($item in $include) {
    $source = Join-Path $repoRoot $item.Path
    if (-not (Test-Path $source)) { throw "Missing expected path: $source" }

    if ($item.Kind -eq 'File') {
        $entries += @{ Source = $source; Name = "$pluginName/$($item.Path)" }
        continue
    }

    foreach ($file in Get-ChildItem -Path $source -Recurse -File -Force) {
        $relative = $file.FullName.Substring($repoRoot.Length).TrimStart('\', '/')
        $entries += @{ Source = $file.FullName; Name = "$pluginName/$($relative -replace '\\', '/')" }
    }
}

$forbidden = $entries | Where-Object { (Split-Path $_.Name -Leaf) -in @('mcp.json', '.mcp.json', '.app.json', '.DS_Store') }
if ($forbidden) {
    throw "Forbidden entries in bundle: $(($forbidden | ForEach-Object { $_.Name }) -join ', ')"
}

if (-not (Test-Path $distDir)) { New-Item -ItemType Directory -Path $distDir -Force | Out-Null }
if (Test-Path $zipPath) { Remove-Item $zipPath -Force }

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$stream = [System.IO.File]::Open($zipPath, [System.IO.FileMode]::CreateNew)
try {
    $archive = New-Object System.IO.Compression.ZipArchive($stream, [System.IO.Compression.ZipArchiveMode]::Create)
    try {
        foreach ($entry in $entries) {
            [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                $archive, $entry.Source, $entry.Name,
                [System.IO.Compression.CompressionLevel]::Optimal) | Out-Null
        }
    } finally { $archive.Dispose() }
} finally { $stream.Dispose() }

$sizeKb = [math]::Round((Get-Item $zipPath).Length / 1KB, 1)
Write-Output "Built $zipPath ($sizeKb KB, $($entries.Count) entries)"
