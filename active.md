# Active

What's happening right now. Current work, priorities, blockers, next actions.

**Last updated:** 2026-04-02

---

## In Progress
- [ ] **Chat Portal — Guy testing tomorrow** — Portal live at localhost:50085. Two-tier model (free Grok 4 Fast / paid Sonnet $2.99). Mnemo on 50002 for customer memory. 8 content docs. Stripe product + price created. Needs publishable key to go live with payments.
- [ ] **Stripe publishable key** — Guy needs to grab pk_live_ from dashboard.stripe.com/apikeys
- [ ] **LAN access for Sparky gateway** — Gateway works on localhost:18789 on THE VAULT. Need rebind to 0.0.0.0.
- [ ] **Rocky's Router GitHub repo → private**
- [ ] **Add mnemo-cortex network policy preset** — for NemoClaw sandbox

## Up Next
- [ ] Chat Portal deployment to projectsparks.ai (after Guy tests locally)
- [ ] Shopify store access (waiting on April)
- [ ] OpenClaw 2026.4.2 update (when ready, run doctor --fix after)
- [ ] Rocky-to-CC bridge — `claude -p` works from shell. Not wired yet.

## Blocked
- **Heartbeat re-enable:** Needs OpenClaw per-session model override feature.
- **Shopify FrankenTool:** Store returning 404, waiting on April.

## Recently Completed (April 2, 2026)
- [x] **Opie MCP fix** — opie-brain MCP server v2.0.0. Added opie_startup, read_brain_file, list_brain_files, write_brain_file. Opie now has full brain access and identity recovery. Cause: Claude Desktop restart lost MCP approval, Opie had no way to recover identity.
- [x] **Chat Portal built** — Codex scaffold + CC integration. LLM via Rocky's Switch, Mnemo Cortex for per-customer memory, cookie-based visitor IDs, two-tier scope classifier (free product help / paid enterprise routing).
- [x] **Portal Mnemo instance** — Mnemo Cortex v2.0 on IGOR:50002 (separate from agent memory on THE VAULT:50001). Customer memory only.
- [x] **Content expansion** — 8 docs: FrankenClaw, FrankenTools, Mnemo Cortex, Rocky's Switch, SPARC, OpenClaw, NemoClaw, Modular Vision. Real install commands, troubleshooting.
- [x] **Stripe integration** — Account verified (acct_1SzUT7Dk4CDADjbW, ProjectSparks). Product: Rocky Chat — Sonnet Upgrade. Price: $2.99 one-time. Checkout flow wired. Credentials saved to keys.json and security USB.
- [x] **Paid model tier** — Free = Grok 4 Fast via OpenRouter. Paid = Claude Sonnet 4. Tier persists in localStorage + server-side. Memory carries across tiers.

## Previously Completed (April 1-2, 2026)
- [x] Rocky's Switch fully renamed (~/.guys-switch/ → ~/.rockys-switch/)
- [x] FrankenClaw shipped PUBLIC (12 tools, v0.3.0, MIT license)
- [x] FrankenClaw website deployed at projectsparks.ai/frankenclaw
- [x] Shopify FrankenTool built (3 tools, credentials stored)
- [x] Compaction model leak fixed (added ollama/qwen2.5:32b-instruct)
- [x] Computer Use MCP + Chrome DevTools MCP confirmed working
- [x] Code-review plugin installed and battle-tested

## Notes
- Portal Mnemo on IGOR:50002 is OK — different port, different data, no conflict with THE VAULT:50001.
- Stripe Price ID: price_1THwp0Dk4CDADjbWAPtR4GxV
- Chat Portal currently in test mode (instant upgrade) until publishable key is added.
- Rocky is on OpenClaw 2026.4.1, Grok 4 Fast via OpenRouter. Production — never experiment on him.

---

*CC updates this file every session. If this file is stale, the brain is stale.*
