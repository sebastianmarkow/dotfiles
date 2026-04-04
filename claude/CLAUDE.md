# Global Instructions

## Environment
- Shell: fish | Editor: neovim | Terminal: kitty | OS: macOS | Package manager: Homebrew
- Git UI: lazygit | Container UI: lazydocker | File manager: yazi
- Use fish syntax for shell snippets, not bash/zsh

## Code Style
- Prefer concise, idiomatic code; avoid verbose boilerplate
- Reuse existing patterns — don't introduce abstractions for one-off operations
- No unnecessary comments, docstrings, or type annotations on unchanged code
- No speculative features or error handling for impossible cases
- Validate only at system boundaries (user input, external APIs)

## Git
- Conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, `chore:`, `test:`
- Small, focused commits (1–3 files); never batch unrelated changes
- Never commit secrets, lockfiles, generated files, or binary artifacts
- Never push to main/master directly
- Never use --no-verify or --force-push without explicit user request

## Workflow
- Always read files before modifying them
- Prefer editing existing files over creating new ones
- Run the minimal set of tests scoped to changed files
- When uncertain, ask — don't make large assumptions about intent

## Response Style
- Lead with the answer or action, skip preamble and filler
- One sentence if possible; never restate what was asked
- Use file:line references when pointing to code locations
- Surface blockers and decisions only — no status narration
