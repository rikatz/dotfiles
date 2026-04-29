---
name: rust-correctness
description: >-
  Comprehensive crate-by-crate correctness review of the
  entire Rust workspace. Spawns an orchestrating agent that
  discovers all crates and directories, plans review areas,
  then runs parallel chains of review and verification
  agents through six criteria: correctness, completeness,
  test coverage, conventions and idiomatic Rust, bug check,
  and security check. Each criterion pair runs the full test
  suite before proceeding. Reports are written per area and
  summarized for review. Use when the user says
  "rust-correctness", "/rust-correctness", or asks for a
  full codebase correctness review, deep multi-criteria
  audit, comprehensive quality pass, or thorough review
  of all crates.
---

# Rust Correctness

Full-workspace review using orchestrated parallel agent
chains. Each area of the codebase runs through 6
sequential review+verification cycles with full test
suite validation between each.

## Process

1. Create `.docs/reports/` if it does not exist.
2. Generate a run timestamp: `date +%Y-%m-%d_%H%M%S`
3. Spawn a single **foreground** orchestrating Agent.
   Include **everything below this section** as the
   agent's prompt. Also include in the prompt:
   - Project root absolute path
   - The generated timestamp
   - Project policy: never run git commands
4. When the orchestrator completes, read every `.md`
   file in `.docs/reports/` whose filename starts with
   the generated timestamp.
5. Invoke `/summarize` to present the combined findings
   for user review.

---

Everything below is the orchestrator's prompt. Include
it verbatim when spawning the orchestrating Agent.

---

## Orchestrator

You orchestrate a full Rust workspace correctness review.

### 1. Discovery

Find every `Cargo.toml` in the workspace (exclude
`target/`). Each parent directory is a crate. Also list
every top-level directory that is not a crate and not
`target/`.

For each item, count `.rs` source files:

```console
find <dir> -name "*.rs" -not -path "*/target/*" | wc -l
```

### 2. Planning

Group items into review areas:

- **Small crates** (<20 .rs files): one area each
- **Medium crates** (20-50): one area, unless clear
  subdirectory boundaries suggest splitting
- **Large crates** (>50): split by logical subdirectory
  (e.g. `filter/src/builtins/` vs `filter/src/pipeline/`)
- **Test crates** under `tests/`: group into one area
  unless individually large
- **Non-crate directories**: group logically
  (docs + examples together, root config as another)

Present the plan as a numbered list: area name, directory
scope, estimated .rs file count. Then proceed immediately.

### 3. Execution

Spawn one **Area Coordinator** agent per planned area.
Launch all coordinators in parallel (multiple Agent tool
calls in a single message). Each coordinator must be
**foreground**.

Pass each coordinator:

- Its area name and directory scope
- Project root path and run timestamp
- Project policy: never run git commands
- The full text of the **Area Coordinator**, **Review
  Agent**, and **Verification Agent** sections

### 4. Collection

When all coordinators finish, verify each wrote a report
to `.docs/reports/`. Return a completion summary listing
all areas, their final test suite status, and total
changes per criterion.

---

## Area Coordinator

You coordinate review of one area through 6 sequential
criterion pairs.

**Project policy**: never run git commands. The user
manages all git operations.

### Chain Execution

For each criterion (in the order listed below):

1. Spawn a foreground **Review Agent**. Pass it:
   - Area name and directory scope
   - Criterion name and description from the list below
   - Project root path
   - Project policy: never run git commands
   - The **Review Agent** instructions

2. Capture the review agent's change summary.

3. Spawn a foreground **Verification Agent**. Pass it:
   - Everything the review agent received
   - The review agent's change summary
   - The **Verification Agent** instructions

4. Run the full test suite:

   ```console
   make fmt && make lint && make doc && make audit \
     && make test && make container
   ```

   If any step fails, diagnose and fix the root cause.
   Re-run until passing. If still failing after 3 fix
   cycles, document the failure and move on.

5. Record results for this criterion: changes made,
   issues found, remaining problems, test status.

6. Proceed to the next criterion.

### Criteria

Execute in this order:

**1. Correctness**
Logic errors, wrong behavior, incorrect implementations,
type misuse, unsound abstractions, off-by-one errors,
incorrect algorithms, wrong return values, incorrect
state transitions.

**2. Completeness**
Missing functionality, TODO/FIXME items, stub functions,
incomplete error handling, missing match arms, unfinished
trait implementations, partial implementations, gaps
between documented behavior and actual behavior.

**3. Test Coverage**
Missing unit tests, missing edge-case tests, untested
error paths, weak assertions that pass vacuously, missing
integration tests, tests that verify direction but not
precise values. New tests must follow project test
conventions (no inline comments in test bodies, full-width
separators, no doc comments on test functions).

**4. Conventions and Idiomatic Rust**
Read `docs/conventions.md` and `.claude/CLAUDE.md` in the
project root. Check: doc comments on all items (public and
private), file ordering (constants, public types, private
types, utilities, tests), full-width separator comments,
import grouping, naming, `to_owned()` over `to_string()`
for `&str`, inline format args, let-chains,
`is_some_and()`, reference-style rustdoc links. Ensure
comments answer "why" not "what"; runtime narration uses
`tracing`, not comments.

**5. Bug Check**
Race conditions, deadlocks, resource leaks, integer
overflow, `unwrap()`/`expect()` on fallible operations in
non-test code, incorrect error propagation, panics
reachable from production code paths, use-after-move,
lifetime issues, iterator invalidation, off-by-one in
boundary checks.

**6. Security Check**
Injection vectors (header, command, path traversal),
unsafe input handling, SSRF, open redirects, DoS vectors
(unbounded allocations, unbounded loops, regex
backtracking, CPU-intensive parsing), information leakage
in error messages or logs, timing side channels in auth
paths, improper access control checks.

### Cross-Area Edits

You may edit files outside your area scope when necessary.
If a file was concurrently modified by another coordinator,
read its current content before editing and resolve any
conflicts inline.

### Report

After all 6 criteria complete, write one report file.

**Path**: `.docs/reports/<TIMESTAMP>_<area-name>.md`

Replace spaces with hyphens, lowercase the area name. Use
the timestamp passed by the orchestrator.

**Template**:

```markdown
# Correctness Report: <Area Name>

**Date**: <timestamp>
**Area**: <area name>
**Scope**: <directory paths>

## Summary

<2-3 sentence overview of findings and changes>

## Criteria Results

### 1. Correctness

**Changes**: <files changed, what, why>
**Findings**: <issues found during review>
**Remaining**: <unresolved issues>

### 2. Completeness

**Changes**: ...
**Findings**: ...
**Remaining**: ...

### 3. Test Coverage

**Changes**: ...
**Findings**: ...
**Remaining**: ...

### 4. Conventions

**Changes**: ...
**Findings**: ...
**Remaining**: ...

### 5. Bug Check

**Changes**: ...
**Findings**: ...
**Remaining**: ...

### 6. Security Check

**Changes**: ...
**Findings**: ...
**Remaining**: ...

## Test Suite Status

Final result: PASS or FAIL
<details if FAIL>
```

---

## Review Agent

You review code in a specific area for one criterion.
You make substantive changes but only what is necessary.

**Project policy**: never run git commands.

### Process

1. Read `docs/conventions.md` and `.claude/CLAUDE.md`
   in the project root.
2. Read every `.rs` file in the area scope. Also read
   `Cargo.toml` and config files relevant to the area.
3. Identify all issues matching the assigned criterion.
4. Fix each issue by editing files directly.
5. Return a concise report:
   - Files changed: path, what changed, why
   - Issues found but intentionally left unfixed,
     with reasoning
   - Confidence level (high/medium/low) per change

### Guidelines

- Read enough context before changing anything. Follow
  call chains. Check callers and tests.
- Do not refactor beyond what the criterion demands.
- Do not add features.
- When adding tests, follow existing test patterns in
  the same file.
- When fixing a bug, add a test that would have caught
  it.
- Preserve existing functionality unless it is
  demonstrably incorrect.

---

## Verification Agent

You verify and fix problems introduced by the preceding
review agent.

**Project policy**: never run git commands.

### Process

1. Read the review agent's change summary.
2. Read every file the review agent modified. Also read
   surrounding context: callers, tests, related modules.
3. For each change, verify:
   - Correct: no new bugs introduced
   - Complete: no partial fixes left behind
   - Consistent: follows project conventions
   - Necessary: not gratuitous or over-engineered
4. Fix any problems found.
5. Check for cascading issues: did a change in one file
   break something in another?
6. Return a concise report:
   - Changes verified as correct
   - Changes fixed or reverted, with reasoning
   - New issues discovered during verification
