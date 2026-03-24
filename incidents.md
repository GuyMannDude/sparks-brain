# Incidents

The runbook. Every bug that cost real debugging time, documented so it never costs time again.

**New incidents go at the top.** Never delete old ones — they're still valuable context.

---

## Sparky gateway device identity error
**Date:** 2026-03-23 (ongoing)
**Symptom:** Sparky gateway failing with device identity error. Gateway cannot route correctly.
**Cause:** Under investigation.
**Fix:** TBD — active blocker.
**Prevention:** TBD.

## Mnemo-cortex pod network isolation
**Date:** 2026-03-23 (reported)
**Symptom:** Mnemo-cortex pod experiencing network isolation issues.
**Cause:** Under investigation.
**Fix:** TBD.
**Prevention:** TBD.

## Heartbeat cost leak
**Date:** 2026-03-23 (reported)
**Symptom:** Heartbeat mechanism generating excessive API calls, leaking costs.
**Cause:** Under investigation. Likely related to the billing firehose pattern from 2026-03-16.
**Fix:** TBD.
**Prevention:** Monitor API call rates after any heartbeat/polling config changes.

## CC denied NemoClaw's existence
**Date:** 2026-03-23
**Symptom:** CC (Opie) told Guy that NemoClaw doesn't exist and there's no such NVIDIA project.
**Cause:** CC searched for `github.com/NVIDIA/NemoClaw` (wrong — NemoClaw is an npm package, not an NVIDIA GitHub repo). CC didn't check the actual install path on THE VAULT before declaring it fake.
**Fix:** Verified NemoClaw v0.1.0 installed at `~/.npm-global/bin/nemoclaw` on THE VAULT with active `sparks-nemo` sandbox processes. Apologized. Updated brain.
**Prevention:** Always check the actual system before declaring something doesn't exist. Vapor Truth means verifying, not guessing.

## Billing firehose — sessionMemory + memoryFlush
**Date:** 2026-03-16
**Symptom:** OpenRouter credits burning while idle. 66 embedded agent runs/hour.
**Cause:** Two OpenClaw settings were generating excessive API calls:
  - `memorySearch.experimental.sessionMemory` — 66 embedded agent runs/hour
  - `compaction.memoryFlush` — secondary token burner
**Fix:** Disabled both settings in OpenClaw config.
**Prevention:** Audit any experimental/polling settings for cost before enabling. Monitor OpenRouter dashboard after config changes.

## Zombie mnemo-cortex process on IGOR
**Date:** 2026-03-16
**Symptom:** Requests from IGOR to mnemo-cortex were being intercepted locally instead of reaching THE VAULT (artforge:50001).
**Cause:** A mnemo-cortex v2.0 process was running on IGOR at localhost:50001, shadowing the remote service on THE VAULT.
**Fix:** Killed the local process. Patched handler.ts. Permanently removed the pipx mnemo-cortex binary from IGOR.
**Prevention:** No mnemo-cortex process should ever run on IGOR. If `curl localhost:50001` responds on IGOR, something is wrong. The canonical server is always `artforge:50001`.

---

*The first time CC fixes a non-trivial bug, it adds it here. Newest at top.*
