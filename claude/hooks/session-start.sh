#!/usr/bin/env bash
# Inject git context at the start of every session

set -euo pipefail

# Only run inside a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  exit 0
fi

echo "=== Repository: $(basename "$(git rev-parse --show-toplevel)") ==="
echo "Branch: $(git branch --show-current)"
echo ""
echo "Recent commits:"
git log --oneline -5 2>/dev/null || true
echo ""
echo "Working tree:"
git status --short 2>/dev/null || true
