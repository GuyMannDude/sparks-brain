# Machines

Hardware topology. What runs where. How they connect.

---

## IGOR
- **Hostname:** IGOR
- **OS:** Ubuntu 24.04 (kernel 6.14.0-27-generic)
- **Role:** Primary laptop. Launchpad for everything. Claude Code runs here.
- **Key paths:**
  - Projects: `~/github/`
  - Scripts: `~/scripts/`
  - CronAlarm: `~/.cronalarm/`
  - OpenClaw (Rocky): `~/.openclaw/workspace/`
  - AgentB config: `~/.agentb/`
  - OpenClaw desk: `/home/guy/DESK/`
- **Services:**
  - Rocky (OpenClaw agent)
  - Bullwinkle (Agent Zero, Docker, localhost:50090)
  - CronAlarm cron jobs
- **Notes:** IGOR is a launchpad only — no heavy compute. **No mnemo-cortex process should ever run on IGOR** (see incidents). All major memory archives and backups live on THE VAULT.

## THE VAULT (artforge)
- **Hostname:** ARTFORGE (referred to as "THE VAULT")
- **OS:** Ubuntu (headless server)
- **Role:** Compute server. Runs inference, memory services, NemoClaw sandboxes.
- **Specs:** AMD Threadripper 3970X, 128GB RAM, dual RTX 3060
- **Access:** SSH key-based (`ssh artforge`), also on Tailscale (100.22.45.109)
- **Key paths:**
  - NemoClaw: `~/.npm-global/bin/nemoclaw`
  - NemoClaw config: `~/.nemoclaw/`
  - Mnemo Cortex: runs as service, port 50001
  - Ollama: port 11434
- **Services:**
  - Mnemo Cortex v2.0 (port 50001) — watcher + refresher daemons
  - NemoClaw v0.1.0 — OpenClaw sandboxes with NVIDIA inference
  - Ollama (Tailscale: 100.22.45.109:11434)
  - Alice Moltman (OpenClaw agent, Telegram: @AliceMoltmanBot, gateway ws://127.0.0.1:18789)
  - SERVERAL MemChunks watcher (systemd user service)
- **Notes:** THE VAULT is the brain. All memory archives and heavy processing happen here. From IGOR, reach mnemo-cortex at `http://artforge:50001`.

## IGOR-2
- **Hostname:** IGOR-2
- **OS:** Windows
- **Role:** ComfyUI workstation. Image generation and visual workflow.
- **Drop-In Pipeline:** Files move between Linux and Windows via `D:\ROCKY\DROP-IN` on the Windows side.
- **Notes:** Not SSH-managed from IGOR. Used for visual/creative work.

---

*CC updates this file when infrastructure changes.*
