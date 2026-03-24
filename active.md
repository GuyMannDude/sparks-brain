# Active

What's happening right now. Current work, priorities, blockers, next actions.

**Last updated:** 2026-03-23

---

## In Progress
- [ ] **Sparky gateway fix** — Device identity error on Sparky gateway needs resolution
- [ ] **Mnemo Cortex bridge** — Bridge/integration work between mnemo-cortex and the wider stack
- [ ] **Rocky OpenClaw update** — Update Rocky's OpenClaw configuration/capabilities

## Up Next
- [ ] Populate sparks-brain with real data and validate the workflow (THIS SESSION)
- [ ] Verify NemoClaw sandbox health on THE VAULT (`nemoclaw sparks-nemo status`)
- [ ] Test browser fix that was pending before this session

## Blocked
- Sparky gateway — device identity error needs diagnosis before gateway can route correctly

## Recently Completed
- [x] Sparks Brain repo created and published (GuyMannDude/sparks-brain)
- [x] Mnemo Cortex v2.0 deployed on THE VAULT (2026-03-16)
- [x] Zombie mnemo-cortex process killed on IGOR (2026-03-16)
- [x] Billing firehose plugged — disabled sessionMemory + memoryFlush (2026-03-16)
- [x] Rocky workspace slimmed: 74.5 KB → 20.8 KB (2026-03-16)
- [x] Alice bootstrap hook patched for v2 MNEMO-CONTEXT.md (2026-03-16)
- [x] Dead providers cleaned from openclaw.json (2026-03-16)

## Notes
- NemoClaw is running on THE VAULT — multiple `sparks-nemo connect` processes active since Mar 19
- SERVERAL MemChunks watcher is active on THE VAULT (systemd user service)
- CC earlier denied NemoClaw's existence — that was wrong. It's real, installed, and running.

---

*CC updates this file every session. If this file is stale, the brain is stale.*
