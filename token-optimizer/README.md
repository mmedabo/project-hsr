# token-optimizer — a drop-in toolkit to burn fewer tokens in Claude Code

A small, opinionated set of Claude Code config files that cut the tokens each
task costs — without cutting what Claude can do. Everything here is a real
Claude Code primitive (settings, output style, slash commands, a subagent, a
skill), so you install it once and it works everywhere.

It's built around one idea, which is worth understanding before you install
anything:

> **You pay for the same tokens over and over.** Input context (CLAUDE.md, tool
> results, history) is re-sent on *every* turn. Output re-enters context and is
> re-sent on every *later* turn. So the wins aren't "be clever once" — they're
> "stop re-paying for things you don't need."

---

## The mental model: where your tokens actually go

Claude Code assembles a context window every single turn. Roughly, it contains:

| Bucket | Re-sent every turn? | What inflates it | The lever here |
|---|---|---|---|
| **Memory files** (CLAUDE.md, imports) | ✅ yes | Long "brain dump" CLAUDE.md | `CLAUDE.md.template` |
| **MCP tool schemas** | ✅ yes | Many/broad MCP servers connected | `settings.json` + disable unused servers |
| **Tool results** | ✅ until cleared | Full-file reads, noisy command output | `explore` subagent, `MAX_MCP_OUTPUT_TOKENS` |
| **Conversation history** | ✅ yes | Long-running sessions | `/handoff` + `/clear`, `/compact` |
| **Model output** | ✅ next turn on | Preamble, recaps, re-printed files | `Terse` style, `/lean` |
| **Extended thinking** | billed | Deep reasoning on simple tasks | `MAX_THINKING_TOKENS` (optional) |
| **Non-essential model calls** | billed | Background helper calls | `DISABLE_NON_ESSENTIAL_MODEL_CALLS` |

The three biggest levers, in order, are almost always: **(1)** a lean CLAUDE.md,
**(2)** offloading heavy reading to a subagent, and **(3)** clearing context at
task boundaries instead of dragging it. Everything in this repo serves those.

---

## What's in the box

```
token-optimizer/
├── install.sh                     # copy into ~/.claude or a project's .claude
├── CATALOG.md                     # vetted public repos to borrow from (curated)
├── discover.sh                    # re-runnable live GitHub scan → ranked table
└── dotclaude/                     # mirror of a .claude directory
    ├── settings.json              # always-on token levers
    ├── CLAUDE.md.template         # a lean memory-file template
    ├── output-styles/terse.md     # terse-by-default responses
    ├── agents/explore.md          # read-only Haiku research subagent
    ├── commands/
    │   ├── lean.md                # /lean  — do one task in minimum tokens
    │   ├── handoff.md             # /handoff — checkpoint so you can /clear
    │   └── audit-context.md       # /audit-context — where are my tokens going?
    └── skills/token-budget/SKILL.md  # on-demand optimization playbook
```

### 1. `settings.json` — the always-on levers
Sets, safely, for every session:
- `CLAUDE_CODE_SUBAGENT_MODEL: haiku` — subagents (including `explore`) run on
  the cheaper, faster Haiku model. Exploration doesn't need Opus.
- `DISABLE_NON_ESSENTIAL_MODEL_CALLS: 1` — skips background helper model calls.
- `MAX_MCP_OUTPUT_TOKENS: 10000` — caps how much a single MCP tool can dump into
  context (default is 25000). Noisy servers can't flood your window.
- `outputStyle: Terse` — turns on the terse style below by default.
- `cleanupPeriodDays: 15` — housekeeping, not tokens.

**Mechanism:** trims the per-turn tax and stops any one tool from ballooning
context. **Saves:** input + output. **Tune:** raise `MAX_MCP_OUTPUT_TOKENS` if a
tool you rely on gets truncated.

### 2. `CLAUDE.md.template` — the single biggest lever
CLAUDE.md is injected on **every message**. A 400-line one taxes the entire
session. This template forces it into a <40-line lookup table: stack, commands,
layout, conventions. Anything "sometimes needed" moves into a Skill (loads on
demand) instead of living in context permanently.

**Mechanism:** shrinks the fixed per-turn cost. **Saves:** input, every turn.
A common real-world result is a ~50% cut in initial context just from this.

### 3. `output-styles/terse.md` — stop paying for filler
Replaces preamble / recaps / re-printed files with answer-first, code-over-prose
responses. Because output re-enters context, verbosity is billed twice.

**Mechanism:** fewer output tokens now, less history later. **Saves:** output +
future input. **Note:** changes *how* Claude writes, not *what it does* — it
still verifies and surfaces real caveats.

### 4. `agents/explore.md` — isolate the expensive reading
A read-only subagent (Read/Grep/Glob/Bash, Haiku) for "where is X", "how does Y
work", "find all usages" — anything that means reading several files. It reads in
its **own** context and returns a short answer + `path:line` refs. The files it
opened never touch your main window.

**Mechanism:** context isolation + cheaper model. **Saves:** input (large).
**Use:** just ask Claude to "use the explore subagent to find…", or it triggers
from the description on fan-out tasks.

### 5. Slash commands
- **`/lean <task>`** — do one task in the fewest tokens: terse, no narration,
  diff over prose, offload reading to `explore`. A per-task version of the terse
  style for when you don't run it globally.
- **`/handoff [note]`** — writes a compact `.claude/handoff.md` (goal, state, key
  files, decisions, next step). This is the key that unlocks `/clear`: instead of
  dragging a bloated window, checkpoint → `/clear` → "read the handoff and
  continue" → near-full context at a fraction of the tokens.
- **`/audit-context`** — reports your current biggest consumers and whether to
  keep going, `/compact`, or `/handoff` + `/clear`. Measure before you cut.

### 6. `skills/token-budget/SKILL.md` — the on-demand playbook
A skill that stays out of context until you say "reduce tokens" / "save context"
/ "trim CLAUDE.md". It's both a useful optimization checklist **and** a live
demo of the core trick: *load detail on demand, not up front.*

---

## Install

```bash
# For every project (recommended): installs into ~/.claude
./install.sh --user

# For one project only: installs into <dir>/.claude (default: current dir)
./install.sh --project /path/to/repo
```

The installer copies the commands/agents/skills/output-styles and **merges** the
token-saving keys into your `settings.json` (backing up any existing one — it
uses `jq` if present). It never touches your `CLAUDE.md`.

Then:
1. Restart Claude Code (or `/reload`).
2. Turn one CLAUDE.md into a lookup table using `CLAUDE.md.template`.
3. Verify the style is on: `/output-style` should show **Terse** active.

Uninstall = delete the copied files and restore your `settings.json.bak.*`.

---

## How to actually use it day to day

| Situation | Do this |
|---|---|
| Starting any task | It's already lean (Terse + settings). Just work. |
| "Find/understand X across the codebase" | Ask Claude to use the **explore** subagent. |
| One task where you want max frugality | `/lean <task>` |
| Session is getting long / sluggish | `/audit-context` → usually `/handoff` then `/clear` |
| Switching to an unrelated task | `/clear` (or a new session) — don't carry the old context |
| "Why is this so expensive?" | say "reduce tokens" → the **token-budget** skill loads |
| A tool's output got cut off | raise `MAX_MCP_OUTPUT_TOKENS` in settings.json |

**Habits that beat any config:** `/clear` at task boundaries, keep CLAUDE.md
small, disconnect MCP servers you aren't using this session, and let subagents do
the reading. The files here make the good path the default; these habits do the
rest.

---

## Discovering more (and keeping this current)

The ecosystem moves fast, so this toolkit ships a **catalog + a live scanner**
instead of a frozen list:

- **`CATALOG.md`** — a hand-curated shortlist of real, reputable public repos in
  two buckets: *cut tokens/cost* (CLI proxies like `rtk`, MCP optimizers, context
  auditors) and *better research/analysis* (skills frameworks, subagent teams).
  Each entry says what it does, how to adopt it, and how it maps to the tools
  here. **Star counts are treated as a weak signal** — the catalog is curated by
  what a repo does, not by its rank.
- **`discover.sh`** — re-run it to pull **live** stars and last-push dates from
  GitHub across the relevant search themes, deduped and ranked, as a Markdown
  table you can paste back into `CATALOG.md`:

  ```bash
  ./discover.sh --min-stars 300 --pushed 60 > scan.md
  ./discover.sh --query "claude code research agent" # your own theme
  ```
  Needs `jq`; uses `gh` if logged in, else set `GITHUB_TOKEN` to avoid rate
  limits. Then **vet before adopting** using the checklist at the bottom of
  `CATALOG.md` (recent commits, license, read what it installs, measure with
  `/audit-context`). Adopt narrowly — every always-on agent/skill/MCP server you
  add costs baseline context, which is the opposite of the goal.

## Sources / further reading
- [Claude Code Token Optimization: 19 Changes to Cut Costs](https://buildtolaunch.substack.com/p/claude-code-token-optimization)
- [7 Practical Ways to Reduce Claude Code Token Usage — KDnuggets](https://www.kdnuggets.com/7-practical-ways-to-reduce-claude-code-token-usage)
- [12 Ways to Cut Token Consumption in Claude Code — Firecrawl](https://www.firecrawl.dev/blog/claude-code-token-efficiency)
- [Context Reduction via Lazy Loading / trigger routing (54% cut) — johnlindquist gist](https://gist.github.com/johnlindquist/849b813e76039a908d962b2f0923dc9a)
- [Claude Skills and Subagents Reduce Prompt Bloat — newline](https://www.newline.co/@Dipen/claude-skills-and-subagents-reduce-prompt-bloat--f2920804)
- [How I Use Every Claude Code Feature — Shrivu Shankar](https://blog.sshh.io/p/how-i-use-every-claude-code-feature)
