---
name: commit-message
description: Create a Conventional Commit from the currently staged changes and run git commit. Use when the user asks to "write a commit message", "generate a commit", "commit my changes", or invokes /commit-message. Never stages files and stops when no changes are staged.
---

# Commit Message

Create one focused Conventional Commit from exactly the changes currently staged in the repository.

## Workflow

1. Run `git diff --staged` to check for staged changes.
2. If the staged diff is empty, stop and tell the user to stage the intended changes first.
3. Read the complete staged diff before drafting the message.
4. Optionally inspect recent commit subjects with `git log` to follow established repository conventions.
5. Generate the commit message according to the rules below.
6. Run `git commit` with the generated message.
7. Report whether the commit succeeded. On success, include the commit hash and subject.

Never run `git add`. The commit must contain only changes the user staged.

## Format

Use the Conventional Commits format:

```text
type(scope)!: short subject

- optional body bullet

optional footer
```

The scope, breaking-change marker (`!`), body, and footer are optional.

## Types

Choose the type that best represents the staged changes:

* `build` — changes to the build system or external dependencies;
* `chore` — repository maintenance that does not fit another type;
* `ci` — changes to continuous integration configuration or workflows;
* `docs` — documentation or instructions-only changes;
* `feat` — new user-facing behavior or capability;
* `fix` — correction of a defect;
* `perf` — a change that improves performance;
* `refactor` — internal restructuring without a behavior change;
* `revert` — reversal of an earlier commit;
* `style` — formatting-only changes with no behavior change;
* `test` — test-only changes.

Choose the type from the actual staged diff, not from filenames alone.

## Subject

* Keep the complete subject line under 60 characters.
* Use an imperative, concise description.
* Use lowercase for the type.
* Do not end the subject with a period.
* Add a scope only when it is unambiguous and provides useful context.
* Add `!` before the colon only when the commit introduces a breaking change.
* Describe the meaningful outcome rather than mechanically listing modified files.
* Do not mention changes, motivations, or context that are not supported by the staged diff.

## Body

Omit the body when the subject communicates the change sufficiently.

Add a body only when important context or reasoning would otherwise be lost. When needed, use concise bullets that explain the meaningful change or its reason. Do not enumerate every modified file, implementation detail, or minor fix.

## Footer

Omit the footer unless it carries necessary Conventional Commit metadata, such as:

* `BREAKING CHANGE: <description>` for a breaking change;
* an issue reference explicitly requested by the user or clearly established by repository context.

Never invent issue references or breaking-change information.

## Constraints

* Base the message strictly on the staged diff.
* Produce one commit message, not a list of alternatives.
* Never include `Co-Authored-By` or any other AI-attribution trailer.
* Never stage, modify, revert, or discard files.
* Do not bypass commit hooks.
* If the commit fails, report the failure and preserve the repository state; do not amend, retry with altered content, or bypass safeguards unless the user explicitly asks.
