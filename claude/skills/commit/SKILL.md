---
name: commit
description: Generate a semantic commit message and commit staged changes. Use when user says "commit", "create a commit", or "write a commit message". Requires staged files.
disable-model-invocation: true
allowed-tools: Bash(git diff *), Bash(git status *), Bash(git commit *)
---

# Commit

1. Run `git diff --cached` to inspect staged changes
2. Determine the conventional commit type:
   - `feat:` new capability
   - `fix:` bug fix
   - `refactor:` restructuring without behavior change
   - `docs:` documentation only
   - `test:` test additions/changes
   - `chore:` tooling, config, dependencies
3. Write a subject line: `<type>(<scope>): <imperative description>` (max 72 chars)
4. Add a body only if the "why" is non-obvious
5. Run: `git commit -m "<message>"`

Never commit if no files are staged. Remind user to `git add` first.
