#!/usr/bin/env bash
# sync — commit and push your mnemo-plan brain.
#
# Use this at session end to push current brain state to the remote
# (and pull it back on a different machine to transfer your context).
#
# Manual, not automatic. The script surfaces every git error directly
# rather than hiding failure. If it errors out, fix the underlying git
# issue (merge conflict, untracked sensitive file, network issue) and
# re-run.
#
# Usage:
#   bash scripts/sync.sh                        # default message
#   bash scripts/sync.sh "wrap-up: hoffman"     # custom message

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if [ -n "$1" ]; then
    MSG="$1"
else
    MSG="brain: session $(date -u +%Y-%m-%d)"
fi

# Status check — if nothing changed, no commit needed.
if [ -z "$(git status --porcelain)" ]; then
    echo "✓ no changes — already in sync"
    git push 2>&1 | grep -v "^$" || true
    exit 0
fi

# Show what we're about to commit so it's never silent.
echo "==> staging brain changes"
git add -A
git status --short

echo
echo "==> committing as: $MSG"
git commit -m "$MSG"

echo
echo "==> pushing to remote"
git push

echo
echo "✓ brain synced"
