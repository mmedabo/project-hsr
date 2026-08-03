# Evolta — AI Company OS

Evolta is run as an **AI-operated company**: each business function is a
Claude-powered agent (a "department"), coordinated by a **CEO** agent. This
repository is the operating system — the agents, their briefs, the shared
company profile, and a reusable prompt library.

> Inspired by the "AI Company OS" model: **Plan → Build → Sell → Automate → Scale**.

## How it works

- **You** (the founder) are the Chair. You give direction to the **CEO** agent.
- The **CEO** turns direction into goals, decides priorities, and **delegates**
  to the right department agent.
- Each **department agent** owns one function end-to-end and reports back.
- Everything the agents need to know about the business lives in
  [`company/PROFILE.md`](company/PROFILE.md). **Fill this in first** — the
  agents are only as good as the profile.

## The departments (agents)

| Agent | Owns | Sub-loop |
|-------|------|----------|
| `ceo` | Strategy & decisions | Think → Decide → Delegate → Grow |
| `engineering` | Build & deploy the product | Code → Test → Ship → Scale |
| `marketing` | Growth & content | Research → Create → Publish → Analyze |
| `sales` | Leads & pipeline | Find → Contact → Meet → Close |
| `finance` | Numbers & cash flow | Track → Forecast → Decide |
| `support` | Customer success | Resolve → Retain → Delight |
| `operations` | Systems & workflows | Automate → Monitor → Optimize |

Agent definitions live in [`.claude/agents/`](.claude/agents/). A shared,
reusable prompt library lives in [`prompts/`](prompts/) (the "Prompts" tab of
the OS).

## How to run a department

In Claude Code, ask the main session to delegate, e.g.:

- *"As the CEO, set this quarter's goals for Evolta and delegate the top one."*
- *"Have the marketing agent draft a 2-week content plan for Evolta."*
- *"Ask the sales agent to build an outbound sequence for our ICP."*

Claude routes the task to the matching subagent, which works from its brief +
the company profile and reports back.

## Operating principles (all agents follow these)

1. **Read the profile first.** Ground every output in `company/PROFILE.md`.
   If a needed fact is missing, state the assumption and flag it — don't invent
   commitments, prices, or customer promises.
2. **Stay in lane.** Do your department's job; hand off cross-functional work to
   the right agent via the CEO rather than guessing.
3. **Be decision-ready.** End work with a clear recommendation and next action,
   not just options.
4. **No fabrication.** Never invent metrics, testimonials, legal/financial
   guarantees, or customer data. Mark placeholders as `[TODO]`.
5. **Keep receipts.** Save durable outputs into the repo (e.g. plans, copy,
   forecasts) so the company has memory.

## Repo layout

```
CLAUDE.md                 # this file — company constitution
company/PROFILE.md        # single source of truth about Evolta  <-- fill this in
company/ROADMAP.md        # CEO-owned goals & priorities
.claude/agents/*.md       # the department agents
prompts/                  # reusable prompt library, per department
archive/unused/           # old, unrelated files (ignored)
```
