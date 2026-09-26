---
name: unit-testing
description: Create or extend colocated TypeScript unit tests for a requested target or scope. Use when the user asks to add, generate, improve, or complete unit tests, or invokes /unit-testing. When no target or scope is provided, identify code that needs unit tests and propose the files to cover before making changes.
---

# Unit Testing

Create focused unit tests for TypeScript code while following the repository's existing test framework, conventions, and tooling.

## Input

The user may provide either:

* `target` — a specific source file, exported function, class, or other unit;
* `scope` — a directory, module, feature, package, or other bounded part of the repository.

Resolve the argument from the invocation and repository context. If it is ambiguous and choosing incorrectly would materially change the work, ask the user to clarify.

When neither `target` nor `scope` is provided:

1. Inspect the repository for TypeScript production code and existing tests.
2. Identify behavior that needs unit-test coverage, prioritizing important logic, public behavior, regressions, edge cases, and error handling over trivial declarations or pass-through code.
3. Present a concise proposal listing the source files that should receive tests and what behavior should be covered.
4. Wait for the user to confirm or adjust the proposed scope before creating or changing tests.

## File Placement

Every test file must:

* end with `.test.ts`;
* live in the same directory as its target source file;
* use the target's base name, such as `parser.test.ts` for `parser.ts`.

If the colocated `.test.ts` file already exists, extend it instead of creating a duplicate. Do not create `__tests__` directories or use `.spec.ts`, `.test.tsx`, or another suffix.

## Workflow

1. Read the target code and its direct collaborators before designing tests.
2. Inspect the package scripts, test configuration, and nearby tests to determine the established runner, assertion style, mocking approach, and naming conventions.
3. Define the meaningful observable behaviors to cover. Include relevant success cases, boundaries, invalid inputs, and failures without testing implementation details unnecessarily.
4. Create or extend the colocated `.test.ts` files using existing test utilities and patterns.
5. Run the smallest relevant test command for the changed tests. Run broader checks only when justified by the scope or repository conventions.
6. Review the diff for accidental production changes, brittle assertions, redundant cases, and unrelated edits.
7. Report which behaviors were covered and which verification commands passed or could not be run.

## Constraints

* Preserve production behavior unless the user explicitly asks to change it.
* Do not modify production code merely to make a test pass. If a test exposes a likely defect, report it and ask before fixing it unless the requested task already includes the fix.
* Reuse the repository's installed test framework and helpers. Do not add or update dependencies without the user's approval.
* Prefer deterministic tests that validate externally observable behavior.
* Mock only real boundaries or expensive collaborators; avoid mocking the unit under test.
* Keep each test independent and make failures explain the behavior that regressed.
* Do not add tests solely to increase coverage metrics when they provide no meaningful confidence.
