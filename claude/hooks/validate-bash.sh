#!/usr/bin/env bash
# Block destructive bash commands (PreToolUse hook)

set -euo pipefail

COMMAND=$(jq -r '.tool_input.command // empty')

if [[ -z "$COMMAND" ]]; then
  exit 0
fi

# Block irreversible destructive patterns
BLOCKED_PATTERNS=(
  'rm -rf /'
  'rm -rf ~'
  'git push --force'
  'git push -f'
  'git reset --hard'
  'DROP TABLE'
  'DROP DATABASE'
  'truncate /'
  '> /dev/'
)

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qF "$pattern"; then
    echo "Blocked: command matches destructive pattern '$pattern'" >&2
    exit 2
  fi
done

exit 0
