---
name: verify
description: Run the available pnpm quality checks for a project and report each result concisely. Use when the user asks to verify, validate, or check a project, run all checks, or invokes /verify.
---

# Verify

Run the project's available non-interactive verification scripts and give a concise result for each one.

## Preflight

1. Resolve the project or package from the user's target and the current working directory. Do not broaden an explicitly requested scope.
2. Read the applicable project instructions, `package.json`, workspace configuration, and relevant tool configuration before running commands.
3. Confirm that the project uses pnpm. If it does not, stop and report the evidence instead of substituting another package manager.

Do not install dependencies, change configuration, or modify source files as part of verification. If dependencies or required services are unavailable, report that as the affected check's failure or blocker.

## Checks

Run each of these scripts when it exists in the relevant `package.json`, in this order:

1. `pnpm lint`
2. `pnpm typecheck`
3. `pnpm test:unit`
4. `pnpm test:e2e`

Then run any additional checks required by the project's instructions or exposed as clearly verification-oriented scripts, such as `format:check`, `test:integration`, `test:component`, `test:contract`, `check`, or `build`.

Skip scripts that are absent and report them as skipped. Do not run watch, development, release, deployment, fix, write, or snapshot-update commands. Avoid duplicate work when an additional script is visibly an alias for, or composition of, checks already run.

Run every available independent check even when an earlier one fails, so the report reflects the complete project state. Stop early only when continuing would be unsafe or impossible, and explain why the remaining checks were not run.

## Result Handling

For every check, record one status:

* **Passed** — the command completed successfully.
* **Failed** — the command ran and returned an error.
* **Blocked** — the command could not run because of a missing prerequisite or environment problem.
* **Skipped** — the corresponding script does not exist or would duplicate another check.

Do not fix failures unless the user explicitly asks. For each failed or blocked check, identify the shortest actionable cause supported by the command output and propose one concise solution. Do not guess when the cause is unclear; instead, state what evidence is missing or what focused command should be inspected next.

## Report

Keep the final report short and include:

* one line per check with its status and a brief result;
* a concise proposed solution immediately under each failed or blocked check;
* an overall result: all available checks passed, or verification failed with the number of failed and blocked checks.

Mention skipped core checks when their scripts are absent. Include detailed logs only when the user asks or when a short excerpt is necessary to explain a failure.
