#!/usr/bin/env bash
# mnemo-startup.sh — Pull context from Mnemo Cortex at CC session start
# Usage: source this or run it; output goes to stdout for CC to read
set -euo pipefail

MNEMO_URL="${MNEMO_URL:-http://artforge:50001}"
AGENT_ID="${MNEMO_AGENT_ID:-cc}"

# 1. Health check
health=$(curl -sf "${MNEMO_URL}/health" 2>/dev/null) || {
    echo "[mnemo-startup] WARNING: Mnemo Cortex unreachable at ${MNEMO_URL}"
    exit 0  # non-fatal — CC can still work without memory
}

status=$(echo "$health" | python3 -c "import sys,json; print(json.load(sys.stdin).get('status','unknown'))" 2>/dev/null)
if [ "$status" = "down" ]; then
    echo "[mnemo-startup] WARNING: Mnemo Cortex is down"
    exit 0
fi

echo "=== MNEMO CORTEX — SESSION MEMORY ==="
echo "Status: ${status} | Agent: ${AGENT_ID}"
echo ""

# 1b. Pull latest dream brief (cross-agent overnight synthesis)
DREAM_DIR="/home/guy/.agentb/dreams"
if [ -d "$DREAM_DIR" ]; then
    latest_dream=$(ls -t "$DREAM_DIR"/*.md 2>/dev/null | head -1)
    if [ -n "$latest_dream" ]; then
        dream_age=$(( ($(date +%s) - $(stat -c %Y "$latest_dream")) / 3600 ))
        if [ "$dream_age" -lt 48 ]; then
            echo "## Latest Dream Brief (${dream_age}h ago)"
            cat "$latest_dream"
            echo ""
        fi
    fi
fi

# 2. Pull recent session context (last 20 exchanges)
recent=$(curl -sf "${MNEMO_URL}/sessions/recent?agent_id=${AGENT_ID}&n=20" 2>/dev/null) || true
if [ -n "$recent" ]; then
    context=$(echo "$recent" | python3 -c "import sys,json; print(json.load(sys.stdin).get('context',''))" 2>/dev/null)
    if [ -n "$context" ] && [ "$context" != "None" ] && [ "$context" != "" ]; then
        echo "## Recent CC Activity"
        echo "$context"
        echo ""
    fi
fi

# 3. Pull semantic context for "current priorities and recent work"
ctx=$(curl -sf "${MNEMO_URL}/context" \
    -H 'Content-Type: application/json' \
    -d "{\"prompt\": \"current priorities, recent work, active tasks, and important decisions\", \"agent_id\": \"${AGENT_ID}\", \"max_results\": 5}" 2>/dev/null) || true

if [ -n "$ctx" ]; then
    total=$(echo "$ctx" | python3 -c "import sys,json; print(json.load(sys.stdin).get('total_found',0))" 2>/dev/null)
    if [ "$total" != "0" ] && [ -n "$total" ]; then
        echo "## Relevant Memory (${total} chunks)"
        echo "$ctx" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for i, chunk in enumerate(data.get('chunks', []), 1):
    tier = chunk.get('cache_tier', '?')
    rel = chunk.get('relevance', 0)
    print(f'### [{tier}] (relevance: {rel:.2f})')
    print(chunk.get('content', ''))
    print()
" 2>/dev/null
    fi
fi

# 4. Also query Rocky's recent context for cross-agent awareness
rocky_ctx=$(curl -sf "${MNEMO_URL}/context" \
    -H 'Content-Type: application/json' \
    -d "{\"prompt\": \"recent work and decisions\", \"agent_id\": \"rocky\", \"max_results\": 3}" 2>/dev/null) || true

if [ -n "$rocky_ctx" ]; then
    rocky_total=$(echo "$rocky_ctx" | python3 -c "import sys,json; print(json.load(sys.stdin).get('total_found',0))" 2>/dev/null)
    if [ "$rocky_total" != "0" ] && [ -n "$rocky_total" ]; then
        echo "## Rocky's Recent Activity (${rocky_total} chunks)"
        echo "$rocky_ctx" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for chunk in data.get('chunks', []):
    tier = chunk.get('cache_tier', '?')
    print(f'[{tier}] {chunk.get(\"content\", \"\")[:300]}')
    print()
" 2>/dev/null
    fi
fi

echo "=== END MNEMO CONTEXT ==="
