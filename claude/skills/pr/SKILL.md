---
name: pr
description: Generate a pull request description from branch changes. Use when user says "write a PR", "PR description", "open a pull request", or "describe these changes".
disable-model-invocation: true
allowed-tools: Bash(git log *), Bash(git diff *), Bash(git show *)
---

# PR Description

1. Run `git log main..HEAD --oneline` to list commits
2. Run `git diff main..HEAD --stat` to see changed files
3. Understand the intent of the changes from commit messages and diffs
4. Write a PR description with:
   - **Title**: Concise imperative summary (max 72 chars)
   - **Summary**: What changed and why (2–4 bullet points)
   - **Test plan**: What to verify manually or via CI
5. Print the description — do not open or create the PR unless explicitly asked

$ARGUMENTS can specify a base branch (default: main).
