#!/usr/bin/env bash
# Guard sensitive files from being edited (PreToolUse hook)

set -euo pipefail

FILE_PATH=$(jq -r '.tool_input.file_path // .tool_input.path // empty')

if [[ -z "$FILE_PATH" ]]; then
  exit 0
fi

PROTECTED_PATTERNS=(
  '\.env$'
  '\.env\.'
  'secrets'
  '\.pem$'
  '\.key$'
  'id_rsa'
  'id_ed25519'
  'credentials'
)

for pattern in "${PROTECTED_PATTERNS[@]}"; do
  if echo "$FILE_PATH" | grep -qE "$pattern"; then
    echo "Blocked: '$FILE_PATH' matches protected pattern '$pattern'" >&2
    exit 2
  fi
done

exit 0
