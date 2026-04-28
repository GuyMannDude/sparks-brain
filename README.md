# mnemo-plan

> The manual project pad for the [Mnemo Cortex](https://github.com/GuyMannDude/mnemo-cortex) ecosystem.

**Mnemo Cortex** captures conversation memory automatically — what agents said, what happened, what was decided.

**mnemo-plan** is the opposite: the stuff *you* write and curate. Project specs. Active task lists. Decision logs. Architecture docs. Anything an agent needs to know **before** a conversation starts.

It's just a folder of markdown files in a Git repo. Any LLM that can call the Mnemo MCP tools `read_brain_file` / `write_brain_file` / `list_brain_files` can read and edit them. Not Claude-specific.

## How to use this template

1. **Fork or clone this repo** somewhere your machine can reach.
2. **Edit the files** to reflect your actual project. Each template starts with a comment explaining what goes there.
3. **Point your Mnemo MCP bridge at it** by setting the `BRAIN_DIR` environment variable in your MCP config:
   ```json
   {
     "mcpServers": {
       "mnemo-cortex": {
         "command": "node",
         "args": ["/path/to/mnemo-cortex/integrations/openclaw-mcp/server.js"],
         "env": {
           "MNEMO_URL": "http://localhost:50001",
           "MNEMO_AGENT_ID": "your-agent-id",
           "BRAIN_DIR": "/absolute/path/to/your/mnemo-plan"
         }
       }
     }
   }
   ```
4. **Restart your agent.** It now sees `read_brain_file`, `write_brain_file`, and `list_brain_files` in its tool list, scoped to your `BRAIN_DIR`.

When the bridge detects `BRAIN_DIR` on disk, it auto-enables those tools. No flag, no switch. If the directory doesn't exist, the tools silently don't register.

## What's in the template

| File | Purpose |
|---|---|
| `project.md` | Top-level project overview. What you're building, why, what's done. |
| `active.md` | Current work. In-progress, blocked, queued, recently completed. |
| `stack.md` | Infrastructure and setup notes. Where things run. How they connect. |
| `decisions.md` | Decision log. What you chose, why, what you ruled out. |
| `people.md` *(optional)* | Collaborators, agents, roles. Who's involved. |
| `incidents.md` *(optional)* | Bug history. What broke, what you found, what you fixed. |
| `CLAUDE.md` | Operating instructions for the agent reading this brain. |
| `hooks/` | Optional shell hooks for Claude Code session start/end. |

Edit, rename, delete, add. The bridge just lists `*.md` files — there's no schema enforcement. Use what helps your project.

## Why a separate folder instead of a single file

Agents read selectively. Asking for `active.md` is cheaper than parsing a 200-page combined doc. The split also makes Git diffs readable and lets multiple humans / agents edit different files without merge conflicts.

## Why Git instead of a database

Version history. Branches. Pull requests. Diff-based collaboration with humans. A file is the universal interchange format — no migrations, no API, no schema. Cat it, edit it, commit it.

## License

MIT. Take it, fork it, do whatever.

---

*Part of the [Mnemo Cortex](https://github.com/GuyMannDude/mnemo-cortex) ecosystem by [Project Sparks](https://projectsparks.ai).*
