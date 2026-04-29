# EXAMPLE-PROJECT — Shared Project Lane

<!--
This is a SHARED project lane. Multiple agents may read and update it.

Rename this file to your project name (e.g., `hoffman.md`,
`mnemo-cortex.md`) and edit the contents. Add one file per real project
when you have several running in parallel.

Distinct from agent-lanes/: those are private per agent. This is the
single source of truth for project state that any agent on the project
sees. When CC ships a fix, CC updates this file. When Opie drafts
strategy, Opie updates this file. No drift.

Like agent lanes, this is "what's true now," not history. Rewrite on
update. Git tracks who changed what.

For decision history with full reasoning, use decisions.md or save to
Mnemo memory. Don't turn this file into a diary.
-->

**Last updated:** YYYY-MM-DD (AGENT)

---

## Status

<!-- Current state in 2-4 sentences. What stage is this project at? What's the headline? -->

## In progress

<!-- Active work. One bullet per item, agent attribution optional. -->

- [ ] *(item — owner / agent if relevant)*

## Open / blocked

<!-- Things waiting on something. -->

- *(blocker + what unblocks it)*

## Recently shipped

<!-- Last few completions. Move older items out as the list grows. -->

- [x] *(shipped item — date optional)*

## Context for next session

<!-- The "if you're picking this up cold, read this first" section. Pickup hints. -->

- *(thread + resume point)*

---

## Update protocol

When you touch this file:

1. **Update the `Last updated:` line** with today's date + your agent name.
2. **Rewrite affected sections** rather than appending. State should reflect *now*, not history.
3. **Commit + push** so other agents see your update on their next session start. Use `scripts/sync.sh` if your fork has it.

For decisions worth preserving with full reasoning, use `decisions.md` or save to Mnemo. Project lanes are *what's true*, not *why we got here*.
