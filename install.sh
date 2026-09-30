#!/usr/bin/env bash
# Install the NZT-48 skills (nzt-limitless, nzt-soldier) for Claude Code and/or Codex.
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
SKILLS="nzt-limitless nzt-soldier"
LEGACY="nzt-48"
REF="${NZT48_REF:-main}"
TARGET="${1:-all}"

case "$TARGET" in
  claude|codex|all) ;;
  -h|--help) sed -n '2,11p' "$0" 2>/dev/null || true; exit 0 ;;
  *) echo "Usage: install.sh [claude|codex|all]" >&2; exit 1 ;;
esac

# Use the local checkout when the script sits next to skills/, otherwise download.
SRC=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "$(dirname "${BASH_SOURCE[0]}")/skills/nzt-limitless/SKILL.md" ]; then
  SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  echo "Downloading $REPO@$REF..."
  curl -fsSL "https://codeload.github.com/$REPO/tar.gz/$REF" | tar -xz -C "$TMP"
  SRC="$(find "$TMP" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
fi

# Refuse to touch anything if the source lacks a skill (e.g. a ref older than v1.1.0).
for s in $SKILLS; do
  if [ ! -f "$SRC/skills/$s/SKILL.md" ]; then
    echo "Error: $REF has no skills/$s (ref predates v1.1.0?). Nothing was changed." >&2
    exit 1
  fi
done

install_to() {
  local root="$1"
  mkdir -p "$root"
  if [ -d "$root/$LEGACY" ]; then
    rm -rf "$root/$LEGACY"
    echo "Removed legacy $root/$LEGACY"
  fi
  for s in $SKILLS; do
    rm -rf "$root/$s"
    cp -R "$SRC/skills/$s" "$root/$s"
    cp "$SRC/LICENSE" "$root/$s/LICENSE"
    echo "Installed $s -> $root/$s"
  done
}

if [ "$TARGET" = "claude" ] || [ "$TARGET" = "all" ]; then
  install_to "${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
fi
if [ "$TARGET" = "codex" ] || [ "$TARGET" = "all" ]; then
  install_to "${CODEX_SKILLS_DIR:-$HOME/.agents/skills}"
fi

echo "Done. Restart Claude Code / Codex to load the skills."
