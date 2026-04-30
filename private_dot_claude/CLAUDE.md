# Accuracy & Verification
- Do not invent APIs, functions, types, or behavior. Only use what exists in the codebase or referenced docs.
- Verify by reading code, running commands, or checking docs. If you cannot verify, ask the user and stop; do not guess or make something up.

# Mandatory: Always use RTK
**Every** Bash command MUST be prefixed with `rtk`. Even in `&&` chains, each command gets its own `rtk` prefix. RTK is always safe — if it has a filter it uses it, otherwise it passes through unchanged. This saves 60-90% of tokens on command output. The only exception is if `rtk` is actively breaking a specific command — in that case, run without it and note why.

# Global Engineering Standards (OpenShift & Golang)

## Agentic Protocol (The.GCC Protocol)
1. **Plan First**: All tasks MUST start with `@architect` generating a `plan.md` in the project-local `.GCC/branches/<task-name>/` directory.[1, 2]
2. **Rationale Persistence**: Agents MUST append their "Observation-Thought-Action" (OTA) reasoning to `.GCC/branches/<task-name>/log.md`.[1, 3]
3. **Verification**: Implementation is not complete until verified by `@qa` and `@security` using the mandatory structured review format.
4. **Handoff Summary**: When switching agents, the summary MUST include any discovered environment quirks or dependency flags to save tokens.

## Golang & Kubernetes Standards
- **Context Management**: Every blocking operation (API calls, I/O) MUST accept and respect `context.Context` .
- **Logging**: Use structured KV pairs (e.g., `logger.Info("Created Pod", "name", pod.Name)`). Messages start with a Capital letter, no ending period .
- **OpenShift API Rules**: NO BOOLEAN FIELDS in CRDs. Use Enums for states .
- **Idempotency**: Reconcilers MUST be idempotent and handle `ResourceVersion` conflicts with exponential backoff .
- **Gateway API**: Priority is on `status.conditions`. Ensure `observedGeneration` always matches `metadata.generation` .

## Persona Hierarchy
- **@architect**: Requirement synthesis, global impact mapping, and blueprint generation.
- **@engineer**: Implementation of reconcilers, Ginkgo tests, and controller logic.
- **@qa**: Deep verification against 100-point rubric and plan adherence.
- **@security**: Offensive code review and RBAC/supply-chain auditing.

@RTK.md

<!-- rtk-instructions v2 -->
# RTK (Rust Token Killer) - Token-Optimized Commands

## Golden Rule

**Always prefix commands with `rtk`**. If RTK has a dedicated filter, it uses it. If not, it passes through unchanged. This means RTK is always safe to use.

**Important**: Even in command chains with `&&`, use `rtk`:
```bash
# ❌ Wrong
git add . && git commit -m "msg" && git push

# ✅ Correct
rtk git add . && rtk git commit -m "msg" && rtk git push
```

## RTK Commands by Workflow

### Build & Compile (80-90% savings)
```bash
rtk cargo build         # Cargo build output
rtk cargo check         # Cargo check output
rtk cargo clippy        # Clippy warnings grouped by file (80%)
rtk tsc                 # TypeScript errors grouped by file/code (83%)
rtk lint                # ESLint/Biome violations grouped (84%)
rtk prettier --check    # Files needing format only (70%)
rtk next build          # Next.js build with route metrics (87%)
```

### Test (90-99% savings)
```bash
rtk cargo test          # Cargo test failures only (90%)
rtk vitest run          # Vitest failures only (99.5%)
rtk playwright test     # Playwright failures only (94%)
rtk test <cmd>          # Generic test wrapper - failures only
```

### Git (59-80% savings)
```bash
rtk git status          # Compact status
rtk git log             # Compact log (works with all git flags)
rtk git diff            # Compact diff (80%)
rtk git show            # Compact show (80%)
rtk git add             # Ultra-compact confirmations (59%)
rtk git commit          # Ultra-compact confirmations (59%)
rtk git push            # Ultra-compact confirmations
rtk git pull            # Ultra-compact confirmations
rtk git branch          # Compact branch list
rtk git fetch           # Compact fetch
rtk git stash           # Compact stash
rtk git worktree        # Compact worktree
```

Note: Git passthrough works for ALL subcommands, even those not explicitly listed.

### GitHub (26-87% savings)
```bash
rtk gh pr view <num>    # Compact PR view (87%)
rtk gh pr checks        # Compact PR checks (79%)
rtk gh run list         # Compact workflow runs (82%)
rtk gh issue list       # Compact issue list (80%)
rtk gh api              # Compact API responses (26%)
```

### JavaScript/TypeScript Tooling (70-90% savings)
```bash
rtk pnpm list           # Compact dependency tree (70%)
rtk pnpm outdated       # Compact outdated packages (80%)
rtk pnpm install        # Compact install output (90%)
rtk npm run <script>    # Compact npm script output
rtk npx <cmd>           # Compact npx command output
rtk prisma              # Prisma without ASCII art (88%)
```

### Files & Search (60-75% savings)
```bash
rtk ls <path>           # Tree format, compact (65%)
rtk read <file>         # Code reading with filtering (60%)
rtk grep <pattern>      # Search grouped by file (75%)
rtk find <pattern>      # Find grouped by directory (70%)
```

### Analysis & Debug (70-90% savings)
```bash
rtk err <cmd>           # Filter errors only from any command
rtk log <file>          # Deduplicated logs with counts
rtk json <file>         # JSON structure without values
rtk deps                # Dependency overview
rtk env                 # Environment variables compact
rtk summary <cmd>       # Smart summary of command output
rtk diff                # Ultra-compact diffs
```

### Infrastructure (85% savings)
```bash
rtk docker ps           # Compact container list
rtk docker images       # Compact image list
rtk docker logs <c>     # Deduplicated logs
rtk kubectl get         # Compact resource list
rtk kubectl logs        # Deduplicated pod logs
```

### Network (65-70% savings)
```bash
rtk curl <url>          # Compact HTTP responses (70%)
rtk wget <url>          # Compact download output (65%)
```

### Meta Commands
```bash
rtk gain                # View token savings statistics
rtk gain --history      # View command history with savings
rtk discover            # Analyze Claude Code sessions for missed RTK usage
rtk proxy <cmd>         # Run command without filtering (for debugging)
rtk init                # Add RTK instructions to CLAUDE.md
rtk init --global       # Add RTK to ~/.claude/CLAUDE.md
```

## Token Savings Overview

| Category | Commands | Typical Savings |
|----------|----------|-----------------|
| Tests | vitest, playwright, cargo test | 90-99% |
| Build | next, tsc, lint, prettier | 70-87% |
| Git | status, log, diff, add, commit | 59-80% |
| GitHub | gh pr, gh run, gh issue | 26-87% |
| Package Managers | pnpm, npm, npx | 70-90% |
| Files | ls, read, grep, find | 60-75% |
| Infrastructure | docker, kubectl | 85% |
| Network | curl, wget | 65-70% |

Overall average: **60-90% token reduction** on common development operations.
<!-- /rtk-instructions -->