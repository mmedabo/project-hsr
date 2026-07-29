---
name: token-budget
description: Playbook for cutting token/context usage in a Claude Code session or project. Use when the user asks to reduce tokens, save context, lower cost, "why is this so expensive", trim CLAUDE.md, or set up token-efficient config. Loaded on demand — this text costs nothing until triggered.
---

# Token-budget playbook

This skill exists to demonstrate the cheapest pattern there is: it stays out of
context until a trigger phrase loads it. Apply the same idea to any long
instructions you own.

## Where tokens go (fix in this order — biggest lever first)

1. **Every-turn overhead** — CLAUDE.md and other memory files, plus MCP tool
   schemas, are re-sent on every message. A 400-line CLAUDE.md or a chatty MCP
   server taxes the whole session. → Trim CLAUDE.md to a lookup table (<40
   lines). Disable MCP servers you are not using this session.
2. **Resident tool results** — full-file reads and noisy command output stay in
   context after they are used. → Read only needed line ranges; pipe verbose
   commands through a filter; cap MCP output (`MAX_MCP_OUTPUT_TOKENS`).
3. **Conversation history** — long sessions carry everything forward. → At a
   natural break, `/handoff` then `/clear`; use `/compact` for a lighter
   in-place squeeze. Start unrelated tasks in a fresh session.
4. **Verbose reading** — exploring a large codebase inline dumps everything into
   the main window. → Delegate to the `explore` subagent (Haiku, isolated); the
   main thread pays only for its summary.
5. **Output** — everything Claude writes is billed and re-enters context next
   turn. → Use the Terse output style / `/lean`.
6. **Thinking** — extended thinking is billed. → Cap with `MAX_THINKING_TOKENS`
   when a task doesn't need deep reasoning.

## When asked to optimize a session
Run `/context` (or `/audit-context`) first to see actual consumers, then act on
whichever tier above is biggest. Don't guess — measure, then cut.

## When asked to optimize a project
- Shrink CLAUDE.md; move sometimes-needed detail into Skills like this one.
- Add the Terse output style and the token-saving `settings.json`.
- Set `CLAUDE_CODE_SUBAGENT_MODEL=haiku` and route exploration to subagents.
- Prefer a few focused MCP servers over many broad ones (each adds schema tax).

## The meta-rule
Load detail on demand, not up front. A trigger table that maps phrases → skills
costs ~3KB; the full protocols it points to cost nothing until used. That
single pattern is where most of the savings come from.
