---
description: Report where tokens are going right now and what to trim.
allowed-tools: Bash(/context:*)
---

Give me a short, honest audit of my current token/context usage and how to cut
it. Do not fix anything — just report.

Cover:
1. **Biggest consumers** — of the things in context now (CLAUDE.md and other
   memory files, tool results still resident, long files read in full, MCP
   server tool schemas, conversation history), which are eating the most, and
   roughly how much. Be specific about named files/servers, not generic.
2. **Dead weight** — what is in context that is no longer needed for the current
   goal and could be cleared.
3. **Recommendation** — one of: keep going / `/compact` / `/handoff` then
   `/clear`. Say which and why in one line.
4. **Structural fixes** — if a memory file or MCP server is the culprit, name
   the one change that would help most next session.

Keep it under ~250 words. Bullets, not prose.
