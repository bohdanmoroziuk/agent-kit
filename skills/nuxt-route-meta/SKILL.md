---
name: nuxt-route-meta
description: Add OpenAPI defineRouteMeta metadata to undocumented Nuxt 4 server route handlers. Use when the user asks to document Nuxt server routes by target, scope, or across the project. Stop without editing when the project, OpenAPI configuration, or eligible-route checks fail.
---

# Nuxt Route Meta

Add accurate OpenAPI route metadata to selected Nuxt 4 server route handlers. Place every new `defineRouteMeta` call at the end of its route file.

## Input

The user may provide:

* `target` — one server route file;
* `scope` — a directory containing server routes.

Resolve relative paths from the Nuxt project root. When both arguments are present, require `target` to be inside `scope`; otherwise stop and report the conflict.

When neither argument is provided, select every undocumented file-based route under the project's effective `server/api` and `server/routes` directories.

Never broaden an explicit `target` or `scope`. A selected file must be a Nuxt server route handler, not middleware, a plugin, utility, task, test, fixture, or type declaration.

## Required Preflight

Complete all of the following checks before editing any file. If any check fails, stop without making changes and clearly identify the failed check and the evidence needed to resolve it.

1. **Nuxt 4 project**
   * Starting from the working directory, locate the containing project root rather than assuming the repository root is the Nuxt app root.
   * Require a `nuxt.config.*` file and project package metadata that identifies Nuxt as a dependency.
   * Confirm that the project uses Nuxt major version 4 from the manifest, lockfile, or installed package metadata. If the version is dynamic, aliased, or otherwise cannot be established confidently, stop instead of guessing.
   * Require the working directory, `target`, and `scope` to remain inside that Nuxt project.
2. **OpenAPI enabled**
   * Inspect the project's `nuxt.config.*` and confirm that Nitro OpenAPI generation is explicitly enabled. The standard configuration is `nitro.experimental.openAPI: true`.
   * Do not treat a top-level `nitro.openAPI` customization object by itself as enabling OpenAPI.
   * If configuration is composed or computed and the enabled value cannot be confirmed statically, stop and report that it could not be verified. Do not modify the configuration as part of this skill.
3. **Undocumented server routes exist**
   * Discover file-based handlers from the effective Nuxt server directory, honoring a statically configured `serverDir` when present.
   * Apply `target` or `scope`, then verify that the selection contains at least one server route.
   * Partition the selected routes into those with and without a top-level `defineRouteMeta` call. Treat every route in the first group as already documented, including when its existing metadata has no `openAPI` property.
   * Stop when the selection has no server routes or every selected route is already documented. List the relevant paths and offer to review and update their existing route metadata.

Do not partially proceed: all three checks must pass before the first edit.

## Existing Route Metadata

When an explicit `target` already has route metadata, do not edit it. Tell the user that it is already documented, identify the file, and offer to review and update the existing metadata. Wait for explicit confirmation before changing it.

When an explicit `scope` contains both documented and undocumented routes, report the documented files, leave them unchanged, and continue adding metadata only to undocumented routes. In the completion report, offer to review and update the existing metadata as a separate follow-up.

When neither argument is provided, leave already documented routes unchanged and report how many were skipped. Do not propose rewriting all existing metadata unless the user asks for an audit or update.

## Build the Metadata

Read each selected handler and the directly relevant validators, schemas, types, and shared error utilities before describing its contract. Derive metadata from observable route behavior:

* determine the HTTP method and URL from Nuxt file-based routing conventions;
* write a concise operation summary and, only when useful, a description and tags;
* document query and header parameters that the handler actually reads;
* document request bodies from the validation or parsing performed by the handler;
* document successful responses, explicit status codes, content types, and schemas supported by returned values;
* document error responses that are explicitly thrown or produced by the route or its direct guards;
* add security metadata only when the project's OpenAPI security scheme and the route's authentication requirement are established.

Use a standard OpenAPI Operation Object inside `defineRouteMeta({ openAPI: { ... } })`. Keep the entire argument statically analyzable: write literal metadata inline and do not use imported objects, helper calls, runtime values, or computed spreads.

Do not invent fields, examples, validation rules, status codes, error cases, or security requirements. Omit details that cannot be supported by the code. Preserve existing runtime behavior and do not change handlers, schemas, validation, or configuration merely to make richer documentation possible.

Nuxt/Nitro automatically derives filesystem path parameters. Do not duplicate them unless the handler supplies additional contract information that needs to be documented.

## Placement and Style

Append the new top-level `defineRouteMeta` call after all existing code so it is the final statement in the file. Keep one blank line between it and the preceding statement and preserve the file's established formatting, quoting, indentation, and semicolon style.

Add exactly one route-meta call per undocumented route. Do not move or rewrite existing route metadata.

## Verification

1. Re-read every changed file and confirm that its final statement is the new `defineRouteMeta` call.
2. Confirm that only selected, previously undocumented server routes changed.
3. Validate that each operation matches the handler's method, inputs, outputs, errors, and security behavior.
4. Run the smallest relevant formatter, lint, typecheck, or Nuxt validation command already provided by the project. Do not add dependencies or alter configuration.
5. Review the final diff for runtime changes, unsupported claims, duplicate metadata, and unrelated edits.
6. Report the documented routes, checks run and their results, or the exact preflight failure that stopped execution.
