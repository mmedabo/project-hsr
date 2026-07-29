# Ecosystem catalog — vetted repos for token efficiency & better research/analysis with Claude

A hand-curated shortlist of public repos worth borrowing from, in two buckets:
**(A) cut token/cost** and **(B) get better research/analysis/output** (skills,
subagents, agent teams).

> ⚠️ **On ratings:** GitHub star counts are a weak quality signal and are easy to
> inflate. Do not adopt a repo on stars alone. This catalog is curated by *what
> the repo does and whether it's real and maintained*, not by a star ranking.
> Use `./discover.sh` to pull **live** stars/last-commit from GitHub and re-rank
> for yourself, then vet with the checklist at the bottom before adopting.

Legend for **How to adopt**: 🧩 plugin/marketplace · 📁 copy files into `.claude/`
· 🔌 MCP server · 📖 read-and-learn.

---

## A. Token & cost reducers

These attack the buckets from `README.md`: tool-result bloat, output verbosity,
and per-turn overhead.

### CLI / proxy layer (filter output *before* it hits context — biggest wins)
- **rtk-ai/rtk** — a CLI proxy that intercepts common dev commands (git, tests,
  builds, greps) and returns compact, structured output instead of raw dumps.
  Advertises 60–90% token reduction on those commands. This is the single
  highest-leverage category because noisy tool output is usually the #1 context
  hog. *How to adopt:* 🔌/CLI — install the binary, point Claude's tools at it.
- **ooples/token-optimizer-mcp** — MCP server that caches large payloads, returns
  **diffs** on repeated reads, and filters noisy output; records what it saved.
  Claims 95%+ reduction on repeat-heavy workflows. *Adopt:* 🔌 add as an MCP
  server. Vet the caching behavior on your repo before trusting it blindly.

### Session/plugin layer (measure and trim context)
- **egorfedorov/claude-context-optimizer** — local plugin that tracks token usage,
  builds heatmaps of wasted context, and gives ROI/efficiency reports and budget
  alerts. Zero-config, all local. Good for *finding* where your tokens go (pairs
  with the `/audit-context` command in this toolkit). *Adopt:* 🧩 plugin.
- **sgaabdu4/claude-code-tips** — an opinionated token-optimization *stack*
  (context-mode, terseness rules, RTK integration, enforcement hooks). Good
  source of hook ideas even if you don't take the whole stack. *Adopt:* 📁/📖.

### Config layer (terseness with zero code)
- **drona23/claude-token-efficient** — a single drop-in `CLAUDE.md` that keeps
  responses terse and cuts output verbosity. Same idea as this toolkit's `Terse`
  style; worth diffing against ours to steal any rules we missed. *Adopt:* 📁/📖.

---

## B. Better research, analysis & output (skills, subagents, agent teams)

These don't cut tokens directly — they raise output *quality per token* by giving
Claude specialized, on-demand instructions and by isolating heavy work in
subagents.

### Official / foundational
- **anthropics/skills** — Anthropic's public Agent Skills repo. The canonical
  reference for how a well-formed `SKILL.md` is written (progressive disclosure,
  tight descriptions). Start here before writing your own. *Adopt:* 📖/📁.

### Skills frameworks & collections
- **obra/superpowers** — an agentic *skills framework + methodology* built around
  subagent-driven development and brainstorming. More than a file dump; it's a
  way of working. Strong for research/planning-heavy tasks. *Adopt:* 🧩/📁.
- **VoltAgent/awesome-agent-skills** — large curated collection (1000+) of skills
  across tools. Good hunting ground for a specific analysis skill; quality
  varies, so cherry-pick. *Adopt:* 📁 (copy the few you want).
- **ComposioHQ/awesome-claude-skills** & **travisvn/awesome-claude-skills** — two
  curated skill indexes. Use as directories, not as bulk installs. *Adopt:* 📖.

### Subagents & agent teams (research/analysis)
- **VoltAgent/awesome-claude-code-subagents** — 100+ specialized subagents
  (reviewers, researchers, analysts, domain experts) as ready `.claude/agents`
  files. Best single source for a research/analysis agent to drop in next to the
  `explore` agent in this toolkit. *Adopt:* 📁 (copy individual agents).
- **vijaythecoder/awesome-claude-agents** — an orchestrated "sub-agent dev team"
  (a coordinator that routes to specialist agents). Good pattern study for
  multi-agent research pipelines. *Adopt:* 📁/📖.

### Meta-lists & guides (learn the patterns)
- **hesreallyhim/awesome-claude-code** — the broad, hand-picked index of skills,
  agents, status lines, commands, plugins. Your map of the ecosystem. *Adopt:* 📖.
- **wesammustafa/Claude-Code-Everything-You-Need-to-Know** — practical guide with
  mental models and copy-paste examples for commands/skills/hooks/subagents/MCP.
  Best single read to level up. *Adopt:* 📖.
- **shanraisshan/claude-code-best-practice** — best-practices collection incl.
  context engineering. *Adopt:* 📖.

---

## How this maps to the toolkit you already have

| Your goal | In this toolkit | Add from the catalog |
|---|---|---|
| Stop noisy tool output eating context | `explore` subagent, `MAX_MCP_OUTPUT_TOKENS` | **rtk-ai/rtk**, **ooples/token-optimizer-mcp** |
| See where tokens actually go | `/audit-context` | **egorfedorov/claude-context-optimizer** |
| Terser output | `Terse` style, `/lean` | **drona23/claude-token-efficient** (diff for extra rules) |
| A real research/analysis agent | `explore` (read-only) | **VoltAgent/awesome-claude-code-subagents** |
| Skill authoring done right | `token-budget` skill | **anthropics/skills**, **obra/superpowers** |

---

## Vetting checklist (run before adopting ANY repo)

Stars lie; these don't. Check, in order:
1. **Recent commits** — last commit within ~60 days? Dead repos rot against
   Claude Code updates.
2. **License** — is there one, and does it allow your use?
3. **What it actually installs** — read the files. Hooks and MCP servers run code
   and see your context/keys. Never install a hook or MCP server you haven't read.
4. **Blast radius** — prefer copying the 2–3 files you want over installing a
   whole marketplace/plugin that adds dozens of always-on agents (each with a
   description that costs context every turn — the opposite of your goal).
5. **Measure** — after adopting, run `/audit-context` before and after. Keep it
   only if the numbers moved.

> Reminder: adding many agents/skills/MCP servers *raises* baseline context
> (their descriptions and schemas are always loaded). Adopt narrowly. More tools
> is not more efficient.
