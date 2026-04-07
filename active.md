# Active

What's happening right now. Current work, priorities, blockers, next actions.

**Last updated:** 2026-04-06

---

## In Progress
- [ ] **Hoffman Bedding — Google Merchant Center denial** — Second denial for misrepresentation. Full audit complete. 80 OOS products re-activated, email mismatch, shipping contradictions, non-bedding items. April needs to fix in Shopify admin before next appeal.
- [ ] **Stripe publishable key** — Guy needs to grab pk_live_ from dashboard.stripe.com/apikeys
- [ ] **Sparky Mnemo blocked** — NemoClaw openshell proxy returns 403 on non-TLS internal endpoints. Issue filed: NVIDIA/NemoClaw#1551. Sparky updated to OpenClaw 2026.4.5 but can't reach Mnemo.
- [ ] **Cloudflare tunnel DNS** — Tunnel configured but projectsparks.ai is on Porkbun DNS. cfargotunnel.com CNAMEs don't resolve without Cloudflare DNS. Bypassed with Tailscale Funnel for widget.

## Up Next
- [ ] Chat Portal deployment (after Stripe key)
- [ ] Rocky-to-CC bridge
- [ ] Mem0 meeting with Taranjeet (brief ready at ~/rocky-customer/mem0-bridge-brief.md)
- [ ] Hoffman Bedding re-appeal (after April fixes the 7 items)

## Blocked
- **Heartbeat re-enable:** Needs OpenClaw per-session model override feature
- **Sparky Mnemo:** Needs NVIDIA/NemoClaw#1551 fix or workaround

## Completed This Session (April 6, 2026)

### Rocky Widget → Peter Widget
- [x] Built Rocky Chat Widget from scratch (server.js + rocky-widget.js + SVG icon)
- [x] Fixed double-greeting bug (memory context wording + cross-agent filter + concurrency guard)
- [x] Updated greeting copy for trust-building
- [x] Moved all customer-facing infra to IGOR (backend, Switch, Mnemo)
- [x] Fixed Mnemo tilde bug (portal config writing to literal `~/` path inside repo)
- [x] Externalized product knowledge to ~/peter-customer/knowledge/products.md
- [x] Added "Clear my data" wipe button (deletes Mnemo records + resets widget)
- [x] Added name parsing ("I'm Bob from Fresno" → saves "Bob")
- [x] Renamed Rocky Widget → Peter (system prompt, greeting, service, folders, agent_id)
- [x] Deployed via Firebase Hosting (static files) + Tailscale Funnel (API backend)
- [x] Peter live on projectsparks.ai — all 12 pages

### Mnemo Cortex × Mem0 Bridge
- [x] Built Mem0 upstream bridge (agentb/mem0_bridge.py)
- [x] Added Mem0Config to config.py, hooked into server.py /context and /writeback
- [x] 8/8 integration tests passing (test-mem0-bridge.sh)
- [x] Meeting brief written (~/rocky-customer/mem0-bridge-brief.md)
- [x] Mem0 API key saved to ~/.rockys-switch/keys.json

### Infrastructure Cleanup
- [x] Alice purged from OpenClaw config (mem0 plugin user, Telegram removed)
- [x] OpenClaw updated to 2026.4.5 on THE VAULT (CLI + gateway)
- [x] Sparky updated to OpenClaw 2026.4.5 inside NemoClaw sandbox
- [x] Sparky Mnemo network policy added (but blocked by proxy — issue filed)
- [x] Peter identity fully separated from Rocky M.

### Hoffman Bedding Audit
- [x] Full site crawl: 80 OOS products back, email mismatch, shipping contradictions, non-bedding items, template refund policy
- [x] 7 specific fixes identified for April

## Notes
- Peter Widget backend: IGOR:50095 (systemd: peter-widget.service)
- Peter Widget API: https://igor.tailce7587.ts.net (Tailscale Funnel)
- Peter Mnemo: IGOR:50002 (agent_id: peter-widget-{visitorId})
- Peter knowledge: ~/peter-customer/knowledge/products.md
- Mem0 bridge: ~/github/mnemo-cortex/agentb/mem0_bridge.py
- Mem0 test suite: ~/github/mnemo-cortex/test-mem0-bridge.sh
- NemoClaw issue: NVIDIA/NemoClaw#1551
- Hoffman audit: 7 fixes needed, April owns Shopify admin

---

*CC updates this file every session. If this file is stale, the brain is stale.*
