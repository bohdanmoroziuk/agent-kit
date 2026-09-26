---
name: utility-function
description: Create or extract a focused TypeScript utility function with JSDoc and unit tests. Use when the user asks to add a helper, utility, reusable transformation, validator, formatter, parser, or similar shared function.
---

# Create Utility Function

Create a focused TypeScript utility in the location and style required by the target project.

## Placement

1. Read the target project's applicable instructions before choosing a location. Follow the utility directory, module boundaries, naming, exports, and other conventions defined there.
2. Search for existing utilities that already provide the requested behavior. Reuse or extend them when appropriate instead of creating a duplicate.
3. If a file contains closely related utilities, add the function there.
4. Otherwise, create a dedicated file for the function in the utility directory specified by the project instructions. Follow the project's file-naming and export conventions.

Do not create or move utility directories based on a generic convention when the project specifies their location. If neither project instructions nor existing structure establish a safe location, ask the user where the utility should live.

## Design

Prefer a pure function:

* produce the result only from explicit inputs;
* avoid mutating arguments, shared state, or global state;
* keep I/O, time, randomness, environment access, and other side effects outside the function;
* pass required collaborators or variable values as arguments when practical.

Use side effects only when the requested utility inherently requires them. Keep any effect explicit and narrowly scoped rather than disguising it as a pure transformation.

Keep the function cohesive and no more generic than demonstrated use cases require. Match existing TypeScript types, error-handling behavior, and public API conventions.

## Documentation

Add JSDoc immediately above the function. Describe its purpose and any behavior that callers need to know. Document parameters, return value, important edge cases, and thrown errors when applicable, while avoiding comments that merely repeat the TypeScript signature.

## Unit Tests

Cover the utility with meaningful unit tests. Use the `unit-testing` skill with the utility source file as the explicit `target` when that skill is available. This should create or extend the colocated `<source-name>.test.ts` file without requiring a repository-wide test proposal.

Test observable behavior, including representative inputs, relevant boundaries, invalid input, and failure behavior. For a pure function, verify that inputs are not mutated when mutation would be a realistic risk.

## Workflow

1. Read the applicable project instructions and inspect related utilities, tests, and exports.
2. Decide whether the function belongs in an existing related file or needs its own file.
3. Implement the smallest function that satisfies the requested behavior, preferring a pure design.
4. Add useful JSDoc and update an existing barrel export only when the project convention requires it.
5. Add or extend unit tests using the utility file as the test target.
6. Run the smallest relevant unit-test command, followed by any focused type or lint check required by the project.
7. Review the diff for unrelated changes and report the implementation, test coverage, and verification results.

## Constraints

* Preserve existing behavior unless the request explicitly changes it.
* Do not introduce a new abstraction, generic utility collection, or production dependency without a concrete need and user approval where required.
* Do not place unrelated utilities in the same file merely because they are small.
* Do not modify production code solely to accommodate a test; report any newly exposed defect separately unless fixing it is in scope.
