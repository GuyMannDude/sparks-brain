#!/usr/bin/env bash
# mnemo-writeback.sh — Write session summary to Mnemo Cortex at CC session end
# Usage: mnemo-writeback.sh "session summary text" ["key fact 1" "key fact 2" ...]
#   or:  echo "summary" | mnemo-writeback.sh --stdin
set -euo pipefail

MNEMO_URL="${MNEMO_URL:-http://artforge:50001}"
AGENT_ID="${MNEMO_AGENT_ID:-cc}"
SESSION_ID="${MNEMO_SESSION_ID:-cc-$(date +%Y%m%d-%H%M%S)}"

# Parse input
SUMMARY=""
KEY_FACTS=()
PROJECTS=()
DECISIONS=()

if [ "${1:-}" = "--stdin" ]; then
    SUMMARY=$(cat)
elif [ $# -ge 1 ]; then
    SUMMARY="$1"
    shift
    # Remaining args are key facts
    KEY_FACTS=("$@")
fi

if [ -z "$SUMMARY" ]; then
    echo "[mnemo-writeback] ERROR: No summary provided"
    echo "Usage: mnemo-writeback.sh \"summary text\" [\"key fact 1\" ...]"
    exit 1
fi

# Health check
curl -sf "${MNEMO_URL}/health" >/dev/null 2>&1 || {
    echo "[mnemo-writeback] WARNING: Mnemo Cortex unreachable — saving locally"
    mkdir -p /tmp/mnemo-writeback-queue
    cat > "/tmp/mnemo-writeback-queue/${SESSION_ID}.json" <<EOLOCAL
{"session_id": "${SESSION_ID}", "agent_id": "${AGENT_ID}", "summary": $(python3 -c "import json; print(json.dumps('${SUMMARY}'))")}
EOLOCAL
    echo "[mnemo-writeback] Saved to /tmp/mnemo-writeback-queue/${SESSION_ID}.json"
    exit 0
}

# Build key_facts JSON array
KF_JSON="[]"
if [ ${#KEY_FACTS[@]} -gt 0 ]; then
    KF_JSON=$(printf '%s\n' "${KEY_FACTS[@]}" | python3 -c "import sys,json; print(json.dumps([l.strip() for l in sys.stdin if l.strip()]))")
fi

# Writeback
response=$(curl -sf "${MNEMO_URL}/writeback" \
    -H 'Content-Type: application/json' \
    -d "$(python3 -c "
import json, sys
print(json.dumps({
    'session_id': '${SESSION_ID}',
    'summary': '''${SUMMARY}''',
    'key_facts': ${KF_JSON},
    'projects_referenced': [],
    'decisions_made': [],
    'agent_id': '${AGENT_ID}'
}))
")" 2>&1) || {
    echo "[mnemo-writeback] ERROR: Writeback failed"
    exit 1
}

mem_id=$(echo "$response" | python3 -c "import sys,json; print(json.load(sys.stdin).get('memory_id','?'))" 2>/dev/null)
echo "[mnemo-writeback] Archived: session=${SESSION_ID} memory_id=${mem_id} agent=${AGENT_ID}"
