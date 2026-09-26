# Working Agreements

## General

* Keep changes focused on the requested task.
* Inspect the relevant code, documentation, configuration, and tests before making changes.
* Follow the conventions and instructions already established in the repository.
* Prefer straightforward solutions over unnecessary abstractions.
* Reuse existing patterns and utilities before introducing new ones.
* Preserve existing behavior and public interfaces unless the task explicitly requires changing them.
* Avoid unrelated refactoring, formatting, or cleanup.
* Consider established design patterns and current best practices when analysing or implementing a solution.
* Apply patterns only when they solve a concrete problem and fit the existing architecture.
* Prefer small, reviewable changes with a clear purpose.

## Task Scope

* Follow the user's requested scope and completion criteria.
* When asked only to analyse, plan, explain, or review, do not modify files.
* Make reasonable low-risk assumptions when necessary and state assumptions that affect the result.
* Ask before making broader architectural, public API, data model, or persistent storage changes than the task requires.
* Do not overwrite or revert changes made by the user unless explicitly requested.
* Do not implement optional improvements or unrelated fixes without explicit approval.
* Do not silently expand the scope of the task.

## Existing Work

* Inspect the working tree before editing when version control is available.
* Treat existing uncommitted changes as user-owned unless clearly established otherwise.
* Preserve unrelated changes and work around them where possible.
* Stop and ask for direction when the requested change would overwrite or conflict with existing work.

## Findings and Recommendations

When relevant issues are discovered outside the requested scope, report them without changing the code.

Separate findings into:

### Suggested Fixes

List concrete defects, inconsistencies, risks, or maintainability problems that may require correction.

For each item, briefly include:

* the affected area;
* the problem;
* its practical impact;
* the recommended correction.

### Suggested Improvements

List optional enhancements related to architecture, design patterns, readability, performance, testing, developer experience, or established best practices.

For each item, briefly include:

* the affected area;
* the proposed improvement;
* why it may be useful;
* any important tradeoff.

These lists are advisory only.

* Do not implement listed fixes or improvements without explicit approval.
* Do not include them in the current diff unless they are required to complete the requested task.
* Do not treat a different personal preference as a defect.
* Avoid speculative recommendations that provide no clear practical benefit.
* Prioritize findings by impact rather than listing every possible refinement.

## Dependencies

* Use the dependency manager, manifest files, and lockfiles already established by the repository.
* Do not introduce a second dependency manager or replace the existing toolchain without explicit approval.
* Prefer the standard library, existing dependencies, and repository utilities before adding a new dependency.
* Ask before adding new runtime or production dependencies.
* Do not update or remove dependencies unless the task requires it.
* Keep dependency manifests and lockfiles consistent when dependency changes are required.

## Documentation

* Update relevant documentation when a change affects documented behavior, setup, configuration, or usage.
* Keep documentation changes focused on the implemented behavior.
* Do not rewrite unrelated documentation as part of a code change.

## Verification

* Run the smallest relevant verification commands available for the change.
* Add or update tests for changed behavior when practical and consistent with the repository.
* For bug fixes, prefer a regression test that would fail without the fix.
* Do not weaken, remove, or bypass tests merely to make verification pass.
* Review the final diff for unrelated or accidental changes.
* Report the checks that were run and whether they passed.
* Clearly state when a check could not be run or when an issue remains unresolved.
* Do not claim that a check passed unless it was actually run successfully.

## Version Control

* Do not create commits, amend commits, push changes, or change branches unless explicitly requested.
* Do not rewrite history, delete branches or tags, or run destructive commands such as `reset --hard`, `clean`, or forced checkout without explicit approval.
* Keep existing uncommitted work intact.

## Security

* Do not expose, copy, or modify secrets and credentials unless the task explicitly requires it.
* Do not commit secrets, credentials, tokens, private keys, or sensitive personal data.
* Use the minimum filesystem, network, and execution permissions needed for the task.
* Do not disable or weaken security controls merely to make an implementation or check pass.
* Avoid printing sensitive values in logs, command output, diffs, or final responses.

## Communication

* Lead with the outcome and keep explanations concise, concrete, and focused on the current task.
* Surface important assumptions, risks, and blockers.
* Ask for clarification only when ambiguity materially affects the result and cannot be resolved safely from the repository context.
* At completion, briefly summarize:

  * the changes made;
  * the verification results;
  * suggested fixes, when applicable;
  * suggested improvements, when applicable.
