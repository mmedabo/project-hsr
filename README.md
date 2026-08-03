# Evolta — AI Company OS

Run **Evolta** as an AI-operated company: every business function is a
Claude-powered agent, coordinated by a CEO agent. This repo is the operating
system for it.

**Model:** Plan → Build → Sell → Automate → Scale.

## Departments (agents)
`ceo` · `engineering` · `marketing` · `sales` · `finance` · `support` · `operations`

Each is defined in [`.claude/agents/`](.claude/agents/) and works from the
shared company profile.

## Get started (2 steps)
1. **Fill in [`company/PROFILE.md`](company/PROFILE.md)** — the single source of
   truth every agent reads. The agents are only as good as this file.
2. **Delegate work.** In Claude Code, ask the session to route to a department,
   e.g.:
   - *"As the CEO, set Evolta's goals for this quarter and delegate the top one."*
   - *"Have the marketing agent draft a 2-week content plan."*
   - *"Ask the sales agent for an outbound sequence for our ICP."*

Reusable prompts for every department live in [`prompts/`](prompts/).

## Layout
```
CLAUDE.md              # company constitution (all agents read this)
company/PROFILE.md     # single source of truth about Evolta  <-- fill in first
company/ROADMAP.md     # CEO-owned goals & priorities
.claude/agents/        # the 7 department agents
prompts/               # reusable prompt library
archive/unused/        # old, unrelated files (ignored)
```

See [`CLAUDE.md`](CLAUDE.md) for how the agents coordinate and the operating
principles they all follow.
