# Incidents

The runbook. Every bug that cost real debugging time, documented so it never costs time again.

**New incidents go at the top.** Never delete old ones — they're still valuable context.

---

## Sparky gateway device identity error — RESOLVED
**Date:** 2026-03-23
**Symptom:** `openclaw gateway status` inside sandbox returns "pairing required" (code 1008). Gateway rejects all CLI connections.
**Cause:** Device identity mismatch between two OpenClaw config paths inside the sandbox:
  - `/sandbox/.openclaw/identity/device.json` → device `b762f0...` (registered with gateway at setup, paired)
  - `/root/.openclaw/identity/device.json` → device `98743b...` (auto-generated, NOT paired)
  The gateway was set up as the `sandbox` user (OpenShell default), but CLI commands run as `root` inside the container. Root's identity was never paired with the gateway. `dangerouslyDisableDeviceAuth: true` only affects the control UI, not WebSocket RPC auth.
**Fix:** Copied identity + device-auth files from `/sandbox/.openclaw/identity/` to `/root/.openclaw/identity/`, then killed and restarted the gateway (`openclaw gateway run` in foreground, since systemd is unavailable in containers). Gateway now reports `RPC probe: ok`.
**Prevention:** When running OpenClaw inside NemoClaw containers, ensure the identity files are synced between the sandbox user home and root. Or run all CLI commands as the same user that initialized the gateway. This is a known edge case in containerized OpenClaw — the identity should be a single source, not duplicated per user.

## Sparky/Mnemo pod network isolation — RESOLVED
**Date:** 2026-03-23
**Symptom:** Sparky (inside NemoClaw pod) cannot reach mnemo-cortex on THE VAULT at port 50001. `curl http://host.docker.internal:50001/health` times out from inside the sandbox.
**Cause:** Two layers of blocking:
  1. **OpenShell sandbox policy** — no network policy entry existed for host-local traffic on port 50001. Only external HTTPS endpoints were allowed.
  2. **UFW on THE VAULT** — INPUT policy is DROP, and port 50001 was not in the allow list. Docker bridge traffic (172.x.x.x) was silently dropped.
**Fix:**
  1. Created custom `mnemo-cortex.yaml` policy preset allowing `host.docker.internal:50001` and `host.openshell.internal:50001`. Installed to NemoClaw presets dir. Applied via `openshell policy set`.
  2. Added UFW rule: `sudo ufw allow from 172.16.0.0/12 to any port 50001 proto tcp`
**Prevention:** Any host service that needs to be reachable from NemoClaw pods requires BOTH: (a) an OpenShell network policy entry, and (b) a UFW allow rule for Docker bridge subnets (172.16.0.0/12). Check both layers.

## Heartbeat cost leak
**Date:** 2026-03-23 (ongoing)
**Symptom:** Cron job heartbeat burning ~$2.40/day in OpenRouter credits.
**Cause:** Heartbeat cron job runs on the `main` agent without a model override, so it defaults to Gemini Pro instead of using the free Nemotron tier.
**Fix:** Pending — need OpenClaw per-session model override to force heartbeat to free tier.
**Prevention:** Any cron/scheduled agent call must specify an explicit model override. Never let scheduled jobs default to paid models.

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
**Fix:** Disabled both settings in OpenClaw config. Also found and fixed same bug in THE VAULT host config (discovered 2026-03-23 per Rocky).
**Prevention:** Audit any experimental/polling settings for cost before enabling. Monitor OpenRouter dashboard after config changes.

## Zombie mnemo-cortex process on IGOR
**Date:** 2026-03-16
**Symptom:** Requests from IGOR to mnemo-cortex were being intercepted locally instead of reaching THE VAULT (artforge:50001).
**Cause:** A mnemo-cortex v2.0 process was running on IGOR at localhost:50001, shadowing the remote service on THE VAULT.
**Fix:** Killed the local process. Patched handler.ts. Permanently removed the pipx mnemo-cortex binary from IGOR.
**Prevention:** No mnemo-cortex process should ever run on IGOR. If `curl localhost:50001` responds on IGOR, something is wrong. The canonical server is always `artforge:50001`.

---

*The first time CC fixes a non-trivial bug, it adds it here. Newest at top.*
