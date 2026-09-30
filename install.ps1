# Install the NZT-48 skill for Claude Code and/or Codex (Windows PowerShell 5.1+).
#
# From a clone:   .\install.ps1 [-Target claude|codex|all]
# Without clone:  & ([scriptblock]::Create((irm https://raw.githubusercontent.com/yintong-zhou/NZT-48/main/install.ps1))) -Target all
#
# Environment overrides:
#   NZT48_REF         git ref to download when not run from a clone (default: main)
#   CLAUDE_SKILLS_DIR default: ~\.claude\skills
#   CODEX_SKILLS_DIR  default: ~\.agents\skills
param(
    [ValidateSet('claude', 'codex', 'all')]
    [string]$Target = 'all'
)
$ErrorActionPreference = 'Stop'

$Repo = 'yintong-zhou/NZT-48'
$Skill = 'nzt-48'
$Ref = if ($env:NZT48_REF) { $env:NZT48_REF } else { 'main' }
$Files = @('SKILL.md', 'references', 'README.md', 'LICENSE')

# Use the local checkout when the script sits next to SKILL.md, otherwise download.
$Tmp = $null
if ($PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot 'SKILL.md'))) {
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
    $Dest = Join-Path $Root $Skill
    if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
    New-Item -ItemType Directory -Force -Path $Dest | Out-Null
    foreach ($f in $Files) {
        Copy-Item -Recurse -Path (Join-Path $Src $f) -Destination $Dest
    }
    Write-Host "Installed $Skill -> $Dest"
}

try {
    if ($Target -in 'claude', 'all') {
        $root = if ($env:CLAUDE_SKILLS_DIR) { $env:CLAUDE_SKILLS_DIR } else { Join-Path $HOME '.claude\skills' }
        Install-To $root
    }
    if ($Target -in 'codex', 'all') {
        $root = if ($env:CODEX_SKILLS_DIR) { $env:CODEX_SKILLS_DIR } else { Join-Path $HOME '.agents\skills' }
        Install-To $root
    }
    Write-Host 'Done. Restart Claude Code / Codex to load the skill.'
} finally {
    if ($Tmp) { Remove-Item -Recurse -Force $Tmp -ErrorAction SilentlyContinue }
}
