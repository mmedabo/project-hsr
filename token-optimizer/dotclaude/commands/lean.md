---
description: Do the task in minimum tokens — terse output, no narration, code/diff over prose.
argument-hint: [task]
---

Complete this task using the fewest tokens that still fully and correctly solve
it: $ARGUMENTS

Constraints for this task:
- No preamble, no recap, no closing summary. Answer/patch first.
- Prefer a diff or code block over prose. Explain only the non-obvious.
- Do not re-read files already in context. Do not re-print files you just wrote.
- Offload any heavy reading/searching to the `explore` subagent so the raw
  results stay out of this context.
- One short line before a tool call, not a paragraph.
