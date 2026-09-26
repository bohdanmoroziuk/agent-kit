---
name: update-changelog
description: Update and stage the Unreleased section of CHANGELOG.md when the currently staged changes contain something noteworthy. Use when the user asks to update, prepare, or record changes in the changelog, or invokes /update-changelog. Never stages other files or creates commits.
---

# Update Changelog

Update `CHANGELOG.md` with concise, noteworthy entries derived from exactly the changes currently staged in the repository.

Run this skill after the intended changes are staged and before `/commit-message`.

## Workflow

1. Run `git diff --staged` to check for staged changes.
2. If the staged diff is empty, stop and tell the user to stage the intended changes first.
3. Read the complete staged diff, including the content of staged new files. Ignore `CHANGELOG.md` itself when determining what needs to be recorded.
4. Read the existing `CHANGELOG.md` and identify its established format and `Unreleased` section.
5. Check whether `CHANGELOG.md` already has unstaged changes that were present before this skill started.
6. Determine whether the staged changes contain anything noteworthy for users, contributors, or maintainers.
7. If there is nothing noteworthy, leave `CHANGELOG.md` unchanged, report that no changelog entry is needed, and stop.
8. Add concise entries under the appropriate headings in `Unreleased`.
9. Review the resulting changelog diff for accuracy, duplication, ordering, and unrelated edits.
10. Run `git add -- CHANGELOG.md` to stage only the updated changelog.
11. Verify the staged changelog diff and report the entries that were added.

Never run `git commit`. Run `git add` only for `CHANGELOG.md` and only after this skill has updated it.

## What to Record

Record changes that materially affect at least one of the following:

* available functionality or capabilities;
* existing behavior or interfaces;
* setup, configuration, dependencies, or supported environments;
* deprecations, removals, bug fixes, or security;
* substantive documentation, instructions, or developer workflows when they are deliverables of the project.

Do not add entries for:

* trivial formatting or wording adjustments;
* implementation details with no observable impact;
* tests that only cover already documented behavior;
* temporary files, generated noise, or unrelated working-tree changes.

If the staged changes contain nothing noteworthy, leave `CHANGELOG.md` unchanged and say so.

## Categories

Place each entry under the most appropriate Keep a Changelog heading:

* `Added` — new functionality, capabilities, documentation, or workflows;
* `Changed` — changes to existing functionality or behavior;
* `Deprecated` — functionality planned for future removal;
* `Removed` — functionality removed in these changes;
* `Fixed` — defect corrections;
* `Security` — vulnerability fixes or security improvements.

Create a missing heading only when it is needed. Preserve the established heading order; when no order is established, use:

1. `Added`
2. `Changed`
3. `Deprecated`
4. `Removed`
5. `Fixed`
6. `Security`

## Entries

* Base every entry strictly on the staged diff.
* Match the language, grammar, punctuation, and style already used by the changelog.
* Describe the meaningful outcome rather than listing files or implementation details.
* Keep each entry concise and understandable without reading the diff.
* Combine closely related changes into one entry when they represent one outcome.
* Use separate entries only for meaningfully distinct changes.
* Add new entries above older entries within the same heading.
* Do not duplicate an existing entry that already describes the staged change.
* Clearly identify breaking, deprecated, removed, or security-relevant behavior.
* Do not invent motivations, issue references, compatibility claims, or user impact.

## File Handling

* Modify only the `Unreleased` section.
* Do not create a release version, date, comparison link, or tag.
* Preserve existing release sections and unrelated content exactly.
* If `CHANGELOG.md` does not exist or has no recognizable `Unreleased` section, stop and report the problem instead of inventing a new structure.
* If `CHANGELOG.md` is already included in the staged diff, inspect its staged and working-tree versions to avoid duplicate or conflicting entries.
* If `CHANGELOG.md` had unrelated unstaged changes before this skill started, stop before editing or staging it. Report the conflict so existing user changes are not staged unintentionally.
* Never stage any path other than `CHANGELOG.md`.

## Handoff

After processing the staged changes:

1. If no entry was needed, say so explicitly.
2. If entries were added, summarize them and confirm that `CHANGELOG.md` was staged.
3. Tell the user the changes are ready for `/commit-message`.
