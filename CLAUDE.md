# mnemo-plan — Operating Instructions

You have a persistent project pad in this directory. Read what you need at the start of a session; write back what's worth keeping at the end.

## Session start — what to read

Don't read everything every time. Read what's relevant to the task you've been given:

- **Always**: `active.md` — know what's in progress, what's blocked, what's queued.
- **For new features or refactors**: `project.md` (scope), `stack.md` (what exists), `decisions.md` (what was already chosen).
- **For debugging**: `incidents.md` (was this seen before?), `stack.md` (where it lives).
- **For collaboration / handoff**: `people.md` (who else is in the loop).

The `read_brain_file` MCP tool is what gets you these. `list_brain_files` shows what's actually here.

## During the session — what to notice

Work normally. The brain doesn't change your workflow.

**But pay attention to what you learn.** If you hit a configuration gotcha, finish a task, make a non-obvious decision, or discover a pattern that will matter next time — hold onto it.

## Session end — what to write back

Use `write_brain_file` to update the relevant file:

- **Finished a task** → mark it done in `active.md`.
- **Made a non-obvious decision** → log it in `decisions.md` with the reason.
- **Found a bug pattern or hit a configuration trap** → write it up in `incidents.md`.
- **Changed the infrastructure** → update `stack.md`.
- **Started something new** → add it to `active.md`.

Keep entries short. Future-you will thank present-you for terse, well-named sections.

## Doctrines (rename / extend / delete this section to match your project)

These are values that should outlive any single session:

- **Truth over face-saving.** When you don't know something, say so. When something broke, say what broke. Future sessions need accurate state, not optimism.
- **Read before writing.** Check if the topic already has a section before adding a new one. Don't fragment.
- **Short over comprehensive.** Three crisp lines beat a paragraph nobody will re-read.

---

*Customize this file for your own workflow. The bridge doesn't enforce any of it — these are just the guardrails this template starts with.*
