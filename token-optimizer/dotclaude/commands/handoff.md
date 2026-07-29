---
description: Write a compact checkpoint of the current session so you can /clear and resume cheaply.
argument-hint: [optional note]
---

Write a compact handoff file so this session's context can be cleared and
resumed later without re-reading everything. Extra note from me: $ARGUMENTS

Create or overwrite `.claude/handoff.md` with ONLY what a fresh session needs to
continue — no narration, no history dump:

1. **Goal** — one or two lines: what we are ultimately trying to do.
2. **State** — what is done, what is in progress, what is left. Bullets.
3. **Key files** — the handful of `path:line` locations that matter, each with a
   one-line why. Not every file touched — only the load-bearing ones.
4. **Decisions & constraints** — choices already made and must-not-break facts,
   so they are not re-litigated.
5. **Next step** — the single concrete action to take on resume.

Keep it tight (aim for under ~400 words). This file is the cheap replacement for
a bloated context window: after writing it, I can run `/clear` and then say
"read .claude/handoff.md and continue" to start fresh with ~full context at a
fraction of the tokens.

After writing it, tell me in one line that it is ready and that I can `/clear`.
