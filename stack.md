# Stack

<!--
Infrastructure and setup notes. Where things run. How they connect.
What versions are pinned. What hostnames / ports / paths matter.

This is reference material — agents look here when they need to
understand the topology, not the immediate task. Keep it accurate
but you don't need to write a textbook.
-->

**Last updated:** YYYY-MM-DD

## Machines

<!-- List the machines / environments / cloud accounts this project runs on. -->

- **(machine name)** — *(role, OS, key paths, anything an agent needs to know)*

## Services

<!-- What's running, where, on what port. -->

| Service | Where | Port / Endpoint | Notes |
|---|---|---|---|
| *(name)* | *(host)* | *(port or URL)* | *(version, role)* |

## Languages / runtimes

<!-- Pinned versions matter. -->

- *(language)* *(version)* — *(why, where it's used)*

## External dependencies

<!-- APIs, SaaS, third-party services this project relies on. -->

- *(name)* — *(what it provides, account/scope, what breaks if it goes down)*

## File paths that matter

<!-- Repo locations, config paths, log directories — the stuff you re-look-up too often. -->

- `*(path)*` — *(what's there)*

---

*If this file gets long, split it into per-area files (e.g., `stack-frontend.md`, `stack-data.md`) and link them.*
