#!/usr/bin/env bash
# Install the NZT-48 skill for Claude Code and/or Codex.
#
# From a clone:   ./install.sh [claude|codex|all]
# Without clone:  curl -fsSL https://raw.githubusercontent.com/yintong-zhou/NZT-48/main/install.sh | bash -s -- [claude|codex|all]
#
# Environment overrides:
#   NZT48_REF         git ref to download when not run from a clone (default: main)
#   CLAUDE_SKILLS_DIR default: ~/.claude/skills
#   CODEX_SKILLS_DIR  default: ~/.agents/skills
set -euo pipefail

REPO="yintong-zhou/NZT-48"
SKILL="nzt-48"
REF="${NZT48_REF:-main}"
TARGET="${1:-all}"
FILES="SKILL.md references README.md LICENSE"

case "$TARGET" in
  claude|codex|all) ;;
  -h|--help) sed -n '2,11p' "$0" 2>/dev/null || true; exit 0 ;;
  *) echo "Usage: install.sh [claude|codex|all]" >&2; exit 1 ;;
esac

# Use the local checkout when the script sits next to SKILL.md, otherwise download.
SRC=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "$(dirname "${BASH_SOURCE[0]}")/SKILL.md" ]; then
  SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  echo "Downloading $REPO@$REF..."
  curl -fsSL "https://codeload.github.com/$REPO/tar.gz/$REF" | tar -xz -C "$TMP"
  SRC="$(find "$TMP" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
fi

install_to() {
  local dest="$1/$SKILL"
  rm -rf "$dest"
  mkdir -p "$dest"
  for f in $FILES; do
    cp -R "$SRC/$f" "$dest/"
  done
  echo "Installed $SKILL -> $dest"
}

if [ "$TARGET" = "claude" ] || [ "$TARGET" = "all" ]; then
  install_to "${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
fi
if [ "$TARGET" = "codex" ] || [ "$TARGET" = "all" ]; then
  install_to "${CODEX_SKILLS_DIR:-$HOME/.agents/skills}"
fi

echo "Done. Restart Claude Code / Codex to load the skill."
