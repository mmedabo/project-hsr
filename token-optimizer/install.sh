#!/usr/bin/env bash
# Install the token-optimizer toolkit into a Claude Code config dir.
#
# Usage:
#   ./install.sh --user             # install into ~/.claude (all projects)
#   ./install.sh --project [DIR]     # install into DIR/.claude (default: cwd)
#
# It copies commands/, agents/, skills/, output-styles/ and merges the
# token-saving keys into settings.json (backing up any existing one). It does
# NOT overwrite your CLAUDE.md — that stays yours; see CLAUDE.md.template.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/dotclaude" && pwd)"
MODE="${1:-}"

case "$MODE" in
  --user)    DEST="$HOME/.claude" ;;
  --project) DEST="$(cd "${2:-$PWD}" && pwd)/.claude" ;;
  *) echo "usage: $0 --user | --project [DIR]" >&2; exit 1 ;;
esac

mkdir -p "$DEST"
for d in commands agents skills output-styles; do
  mkdir -p "$DEST/$d"
  cp -R "$SRC/$d/." "$DEST/$d/"
  echo "copied $d/ -> $DEST/$d/"
done

# settings.json: back up and merge (jq if available, else copy if absent).
if [ -f "$DEST/settings.json" ]; then
  cp "$DEST/settings.json" "$DEST/settings.json.bak.$(date +%s)"
  if command -v jq >/dev/null 2>&1; then
    jq -s '.[0] * .[1]' "$DEST/settings.json" "$SRC/settings.json" \
      > "$DEST/settings.json.tmp" && mv "$DEST/settings.json.tmp" "$DEST/settings.json"
    echo "merged settings.json (backup saved)"
  else
    echo "!! settings.json exists and jq not found — merge these keys by hand:"
    cat "$SRC/settings.json"
  fi
else
  cp "$SRC/settings.json" "$DEST/settings.json"
  echo "wrote settings.json"
fi

echo
echo "Done. Restart Claude Code (or /reload) to pick up the changes."
echo "Then: set your CLAUDE.md from CLAUDE.md.template, and use /lean, /handoff,"
echo "/audit-context, the 'explore' subagent, and the 'token-budget' skill."
