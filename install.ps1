# Install the NZT-48 skills (nzt-limitless, nzt-soldier) for Claude Code, Codex, OpenCode and/or Kimi Code (Windows PowerShell 5.1+).
#
# From a clone:   .\install.ps1 [-Target claude|codex|opencode|kimi|all]
# Without clone:  & ([scriptblock]::Create((irm https://raw.githubusercontent.com/yintong-dev/NZT-48/main/install.ps1))) -Target all
#
# Environment overrides:
#   NZT48_REF         git ref to download when not run from a clone (default: main)
#   CLAUDE_SKILLS_DIR default: ~\.claude\skills
#   CODEX_SKILLS_DIR  default: ~\.agents\skills (also read by OpenCode and Kimi Code)
#   OPENCODE_SKILLS_DIR default: ~\.config\opencode\skills
#   KIMI_SKILLS_DIR   default: $env:KIMI_CODE_HOME\skills or ~\.kimi-code\skills
param(
    [ValidateSet('claude', 'codex', 'opencode', 'kimi', 'all')]
    [string]$Target = 'all'
)
$ErrorActionPreference = 'Stop'

$Repo = 'yintong-dev/NZT-48'
$Skills = @('nzt-limitless', 'nzt-soldier')
$Legacy = 'nzt-48'
$Ref = if ($env:NZT48_REF) { $env:NZT48_REF } else { 'main' }

# Use the local checkout when the script sits next to skills\, otherwise download.
$Tmp = $null
if ($PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot 'skills\nzt-limitless\SKILL.md'))) {
    $Src = $PSScriptRoot
} else {
    $Tmp = Join-Path ([IO.Path]::GetTempPath()) ("nzt48-" + [guid]::NewGuid())
    New-Item -ItemType Directory -Path $Tmp | Out-Null
    $Zip = Join-Path $Tmp 'src.zip'
    Write-Host "Downloading $Repo@$Ref..."
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -UseBasicParsing -Uri "https://codeload.github.com/$Repo/zip/$Ref" -OutFile $Zip
    Expand-Archive -Path $Zip -DestinationPath $Tmp
    $Src = (Get-ChildItem -Path $Tmp -Directory | Select-Object -First 1).FullName
}

function Install-To([string]$Root) {
    New-Item -ItemType Directory -Force -Path $Root | Out-Null
    $LegacyDir = Join-Path $Root $Legacy
    if (Test-Path $LegacyDir) {
        Remove-Item -Recurse -Force $LegacyDir
        Write-Host "Removed legacy $LegacyDir"
    }
    foreach ($s in $Skills) {
        $Dest = Join-Path $Root $s
        if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
        Copy-Item -Recurse -Path (Join-Path $Src "skills\$s") -Destination $Dest
        Copy-Item -Path (Join-Path $Src 'LICENSE') -Destination $Dest
        Write-Host "Installed $s -> $Dest"
    }
}

try {
    # Refuse to touch anything if the source lacks a skill (e.g. a ref older than v1.1.0).
    foreach ($s in $Skills) {
        if (-not (Test-Path -LiteralPath (Join-Path $Src "skills\$s\SKILL.md"))) {
            throw "$Ref has no skills\$s (ref predates v1.1.0?). Nothing was changed."
        }
    }
    if ($Target -in 'claude', 'all') {
        $root = if ($env:CLAUDE_SKILLS_DIR) { $env:CLAUDE_SKILLS_DIR } else { Join-Path $HOME '.claude\skills' }
        Install-To $root
    }
    if ($Target -in 'codex', 'all') {
        $root = if ($env:CODEX_SKILLS_DIR) { $env:CODEX_SKILLS_DIR } else { Join-Path $HOME '.agents\skills' }
        Install-To $root
    }
    if ($Target -in 'opencode', 'all') {
        $root = if ($env:OPENCODE_SKILLS_DIR) { $env:OPENCODE_SKILLS_DIR } else { Join-Path $HOME '.config\opencode\skills' }
        Install-To $root
    }
    if ($Target -in 'kimi', 'all') {
        $kimiHome = if ($env:KIMI_CODE_HOME) { $env:KIMI_CODE_HOME } else { Join-Path $HOME '.kimi-code' }
        $root = if ($env:KIMI_SKILLS_DIR) { $env:KIMI_SKILLS_DIR } else { Join-Path $kimiHome 'skills' }
        Install-To $root
    }
    Write-Host 'Done. Restart your agent (or start a new session) to load the skills.'
} finally {
    if ($Tmp) { Remove-Item -Recurse -Force $Tmp -ErrorAction SilentlyContinue }
}
