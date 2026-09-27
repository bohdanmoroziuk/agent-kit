---
name: code-review
description: >-
  Review a requested diff, branch, commit, pull request, or current working-tree
  changes for concrete bugs, regressions, edge cases, unnecessary complexity,
  and violations of the repository's established architecture and conventions.
  Use when the user asks for a code review, diff review, change review, bug or
  edge-case check, or invokes /code-review. Read-only: report findings without
  editing, staging, committing, or otherwise changing the repository.
---

# Code Review

Review the requested changes for correctness and fit with the repository. Prioritize defects that can affect behavior, safety, or maintainability. Do not fix findings unless the user explicitly asks in a separate follow-up.

## Scope

1. Resolve the review target from the user's request. Honor an explicitly named file, directory, diff, commit, branch, or pull request without broadening the scope.
2. When no target is given, review all current working-tree changes:
   - inspect staged, unstaged, and untracked files;
   - distinguish those groups in the report when that context matters;
   - never stage files as part of the review.
3. Read the applicable `AGENTS.md` files and any repository-specific convention or architecture documents before judging the changes.
4. Inspect the complete diff and enough surrounding code, direct callers, tests, and related types to understand the changed behavior. Read untracked files directly.

Focus findings on problems introduced or materially worsened by the reviewed changes. Mention an existing problem only when the change relies on it, exposes it, or makes it relevant to the requested review.

## Review Priorities

Evaluate each changed behavior in this order.

### Correctness and regressions

Look for concrete failure scenarios, including:

- incorrect conditions, boundary handling, state transitions, or return values;
- missing handling for empty, null, undefined, malformed, or unexpected input;
- async races, missing `await`, unhandled rejections, stale state, or unsafe mutation;
- errors that are swallowed, mislabeled, leaked, or followed by invalid execution;
- type assertions, broad types, or unchecked data that hide a real mismatch;
- behavior changes that break callers, compatibility, persistence, or established contracts;
- security or privacy failures caused by missing validation, authorization, escaping, or data isolation.

Report an issue only when you can explain the triggering input or state and the resulting incorrect behavior. Do not turn a merely theoretical possibility into a finding.

### Repository fit

Check the change against the repository's own instructions and established patterns:

- naming and file placement;
- responsibility boundaries and dependency direction;
- public interfaces, schemas, and error conventions;
- test placement and expected coverage;
- framework- or domain-specific architecture already used by neighboring code.

Treat a deviation as a defect only when it violates an explicit rule or creates a concrete risk. Existing code is evidence of convention, not automatic proof that every repeated pattern is correct.

### Complexity and maintainability

Look for complexity introduced by the change that has a present cost:

- abstractions, indirection, configuration, or flags with no current need;
- duplicate logic when an existing project utility already provides the behavior;
- responsibilities combined in a way that makes current behavior harder to reason about or test;
- code outside the requested task that increases the regression surface.

Do not recommend a refactor solely because another design is cleaner in the abstract. Future extensibility without a current requirement is not a defect.

### Tests and verification

Check whether tests cover the important changed behavior, boundaries, and failure paths. Missing tests are a finding only when they leave a meaningful regression risk, not merely because a changed line lacks direct coverage.

Run focused, non-mutating checks when they materially improve confidence and the repository already provides the required tooling. Do not install dependencies, run auto-fixers, update snapshots, or change generated artifacts. Report checks that could not be run and why.

## Finding Standard

Before reporting an item, verify that it is:

- caused or made relevant by the reviewed change;
- supported by the diff and surrounding code;
- actionable, with a concrete impact;
- more than a formatting preference or an equally valid implementation choice.

Use the narrowest accurate line reference. Trace uncertain behavior through callers, tests, types, or framework documentation before presenting it as a defect. If evidence remains insufficient, state the uncertainty outside the findings instead of asserting it as fact.

## Report

Lead with findings, ordered by practical impact.

### Suggested Fixes

List concrete defects, regressions, architecture violations, or misleading names. For each item include:

- severity (`P0` critical, `P1` high, `P2` medium, or `P3` low);
- a concise title;
- the affected file and line;
- the triggering scenario and resulting impact;
- the smallest reasonable correction.

### Suggested Improvements

List only optional changes with a clear current benefit. For each item include the affected area, proposed improvement, benefit, and relevant tradeoff. Do not include speculative cleanup or personal style preferences.

If there are no findings, say so explicitly. Then briefly note what was reviewed, which checks were run, and any residual risks or testing gaps. Keep summaries short and do not restate the diff.

## Constraints

- Do not edit, create, delete, format, stage, commit, revert, or discard files.
- Do not run commands intended to mutate the repository or external systems.
- Do not expand the review into implementation work without explicit user approval.
- Preserve unrelated user changes and secrets; do not expose sensitive values in the report.
