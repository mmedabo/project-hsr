#!/usr/bin/env bash
# discover.sh — find & rank public repos for token efficiency and better
# research/analysis with Claude, using LIVE GitHub data (not this repo's
# possibly-stale catalog). Outputs a Markdown table you can paste into CATALOG.md.
#
# Why: star counts and rankings drift (and can be gamed). Re-run this to get the
# current picture and re-vet before adopting anything.
#
# Usage:
#   ./discover.sh                      # default themes, table to stdout
#   ./discover.sh --min-stars 500      # raise the floor
#   ./discover.sh --pushed 30          # only repos pushed in last 30 days
#   ./discover.sh --query "claude code hooks token"   # your own theme
#   ./discover.sh > report.md          # save it
#
# Auth (recommended to avoid rate limits): set GITHUB_TOKEN, or have `gh` logged
# in — the script uses `gh api` when available, else curl.
set -euo pipefail

MIN_STARS=100
PUSHED_DAYS=180
PER_QUERY=15
CUSTOM_QUERY=""

while [ $# -gt 0 ]; do
  case "$1" in
    --min-stars) MIN_STARS="$2"; shift 2 ;;
    --pushed)    PUSHED_DAYS="$2"; shift 2 ;;
    --per-query) PER_QUERY="$2"; shift 2 ;;
    --query)     CUSTOM_QUERY="$2"; shift 2 ;;
    -h|--help)   grep '^#' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown arg: $1" >&2; exit 1 ;;
  esac
done

command -v jq >/dev/null 2>&1 || { echo "error: jq is required" >&2; exit 1; }

# Themes to sweep. Add your own or pass --query to run just one.
THEMES=(
  "claude code token optimization in:name,description,readme"
  "claude token efficiency cost reduction in:name,description,readme"
  "claude code subagents in:name,description,readme"
  "claude code skills in:name,description,readme"
  "claude code research agent analysis in:name,description,readme"
  "claude code context management in:name,description,readme"
)
[ -n "$CUSTOM_QUERY" ] && THEMES=("$CUSTOM_QUERY")

PUSHED_SINCE="$(date -u -d "-${PUSHED_DAYS} days" +%Y-%m-%d 2>/dev/null \
  || date -u -v-"${PUSHED_DAYS}"d +%Y-%m-%d)"  # GNU or BSD date

gh_search() { # $1 = raw query string
  local q="$1 stars:>=${MIN_STARS} pushed:>=${PUSHED_SINCE}"
  if command -v gh >/dev/null 2>&1; then
    gh api -X GET search/repositories \
      -f q="$q" -f sort=stars -f order=desc -F per_page="$PER_QUERY" 2>/dev/null
  else
    local auth=(); [ -n "${GITHUB_TOKEN:-}" ] && auth=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
    curl -sSG "${auth[@]}" -H "Accept: application/vnd.github+json" \
      "https://api.github.com/search/repositories" \
      --data-urlencode "q=$q" --data "sort=stars" --data "order=desc" \
      --data "per_page=$PER_QUERY"
  fi
}

echo "# Live Claude-ecosystem repo scan"
echo
echo "- Generated: $(date -u +%Y-%m-%dT%H:%MZ)"
echo "- Filters: stars ≥ ${MIN_STARS}, pushed since ${PUSHED_SINCE}"
echo "- ⚠️ Stars are a weak signal. Vet each repo (see CATALOG.md checklist) before adopting."
echo
echo "| ⭐ | Repo | Pushed | Description |"
echo "|---:|------|--------|-------------|"

# Collect, merge across themes, dedupe by full_name, keep highest stars, sort.
{
  for q in "${THEMES[@]}"; do gh_search "$q"; done
} | jq -s '
    [ .[].items[]? ]
    | group_by(.full_name)
    | map(max_by(.stargazers_count))
    | sort_by(-.stargazers_count)
  ' \
  | jq -r '.[] |
      "| \(.stargazers_count) | [\(.full_name)](\(.html_url)) | \(.pushed_at[0:10] // "?") | \((.description // "") | gsub("[|\n]"; " ") | .[0:100]) |"'

echo
echo "_Re-vet with: recent commits, license, and read what it installs. Prefer copying 2–3 files over installing whole marketplaces._"
