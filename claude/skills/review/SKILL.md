---
name: review
description: Perform a thorough code review of recent changes. Use when user says "review", "check my code", "look at changes", or "review this PR".
allowed-tools: Read, Glob, Grep, Bash(git diff *), Bash(git log *)
context: fork
agent: Explore
---

# Code Review

1. Run `git diff HEAD~1..HEAD` (or `git diff main..HEAD` for branch review)
2. Read each modified file to understand full context
3. Check for:
   - Correctness and logic errors
   - Security issues (injection, auth, secrets)
   - Performance (unnecessary work, blocking calls)
   - Consistency with codebase patterns
4. Report findings grouped by severity (Critical → Low)
5. Suggest specific fixes, not vague improvements

$ARGUMENTS can specify a branch, commit range, or file path to narrow scope.
