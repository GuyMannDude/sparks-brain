# Active

What's happening right now. Current work, priorities, blockers, next actions.

**Last updated:** 2026-04-06

---

## In Progress
- [ ] **Chat Portal — Guy testing** — Portal live at localhost:50085. Two-tier model (free Grok 4 Fast / paid Sonnet $2.99). Mnemo on 50002 for customer memory. 8 content docs. Stripe product + price created. Needs publishable key to go live with payments.
- [ ] **Stripe publishable key** — Guy needs to grab pk_live_ from dashboard.stripe.com/apikeys
- [ ] **LAN access for Sparky gateway** — Gateway works on localhost:18789 on THE VAULT. Need rebind to 0.0.0.0.
- [ ] **Rocky's Router GitHub repo → private**
- [ ] **Add mnemo-cortex network policy preset** — for NemoClaw sandbox
- [ ] **Cloudflare tunnel DNS** — Tunnel configured with ingress for chat + rocky subdomains, but projectsparks.ai is on Porkbun DNS, not Cloudflare. cfargotunnel.com CNAMEs don't resolve without Cloudflare DNS. Needs nameserver migration to Cloudflare (free plan) or abandon tunnel approach. Widget bypassed this via Tailscale Funnel.

## Up Next
- [ ] Chat Portal deployment to projectsparks.ai (after Guy tests locally)
- [ ] Rocky-to-CC bridge — `claude -p` works from shell. Not wired yet.

## Blocked
- **Heartbeat re-enable:** Needs OpenClaw per-session model override feature.
- **NotebookLM writes:** Google session cookies expire every ~2-3 hours. Write operations need fresh CSRF token. No permanent fix — Google-side limitation. Workaround: `nlm login` before write sessions.

## Recently Completed (April 5-6, 2026)
- [x] **Rocky Chat Widget LIVE** — Lightweight chat bubble on every page of projectsparks.ai. Rocky answers questions about Project Sparks products.
  - Frontend: rocky-widget.js (12KB, self-contained overlay, sessionStorage persistence)
  - Backend: rocky-widget.service on THE VAULT (port 50095)
  - LLM: Rocky's Switch on IGOR (igor:50060, Grok 4 Fast)
  - Memory: Mnemo on IGOR:50002 (customer memory, agent_id "rocky-widget-{visitorId}")
  - Deployed via Firebase Hosting (static files) + Tailscale Funnel (API backend)
  - Onboarding: name → location → chat. Returning visitors get personalized greeting.
  - Identity separated from real Rocky (different Mnemo instance, different agent_id)
  - Double-greeting bug fixed (memory context wording + Mnemo cross-agent filter + concurrency guard)
  - Greeting updated: explains value exchange for name/location, builds trust
- [x] **Cloudflare tunnel configured** — config.yml on THE VAULT with ingress for chat + rocky subdomains. DNS issue unresolved (domain on Porkbun). Bypassed with Tailscale Funnel.
- [x] **Tailscale Funnel enabled** — artforge.tailce7587.ts.net publicly serves port 50095. Set operator=guy for non-root access.

## Previously Completed (April 5, 2026)
- [x] Shopify unblocked, catalog pull, succulents archived, product feed cleanup
- [x] robots.txt fixed, footer contact added, Merchant Center readiness verified
- [x] NotebookLM catalog upload, Rocky's Switch og:image, NotebookLM MCP installed
- [x] Theme API access granted by April

## Notes
- Hoffman Bedding store: hoffmanbedding.com (handle: wugjc3-qh.myshopify.com)
- Shopify API scopes: read/write products, read/write inventory, read_product_listings, read/write themes
- Rocky Widget Funnel URL: https://artforge.tailce7587.ts.net
- Widget script tags injected in all 12 HTML pages of projectsparks.ai
- Firebase project: project-sparks-website, site repo: ~/github/projectsparks-site/

---

*CC updates this file every session. If this file is stale, the brain is stale.*
