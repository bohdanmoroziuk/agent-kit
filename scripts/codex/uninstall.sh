#!/usr/bin/env bash
# Uninstall Agent Kit from Codex without removing unrelated global configuration.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
REPOSITORY_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
readonly REPOSITORY_DIR
readonly INSTRUCTIONS_SOURCE="$REPOSITORY_DIR/instructions/working-agreements.md"
readonly SKILLS_SOURCE_DIR="$REPOSITORY_DIR/skills"
readonly CODEX_HOME_DIR="${CODEX_HOME:-"$HOME/.codex"}"
readonly INSTRUCTIONS_TARGET="$CODEX_HOME_DIR/AGENTS.md"
readonly GLOBAL_SKILLS_DIR="$HOME/.agents/skills"

# Remove the global instructions only when the link belongs to this checkout.
remove_instructions_link() {
  local existing_target=""

  if [[ -L "$INSTRUCTIONS_TARGET" ]]; then
    existing_target="$(readlink "$INSTRUCTIONS_TARGET")"
    if [[ "$existing_target" == "$INSTRUCTIONS_SOURCE" ]]; then
      rm "$INSTRUCTIONS_TARGET"
      printf 'Removed: %s\n' "$INSTRUCTIONS_TARGET"
      return 0
    fi
    printf 'Skipped: %s points to a different source.\n' "$INSTRUCTIONS_TARGET" >&2
    return 0
  fi

  if [[ -e "$INSTRUCTIONS_TARGET" ]]; then
    printf 'Skipped: %s is not a symbolic link.\n' "$INSTRUCTIONS_TARGET" >&2
    return 0
  fi

  printf 'Not installed: %s\n' "$INSTRUCTIONS_TARGET"
}

remove_instructions_link

# Remove only skill links that point into this checkout.
if [[ -d "$GLOBAL_SKILLS_DIR" ]]; then
  for skill_target in "$GLOBAL_SKILLS_DIR"/*; do
    [[ -L "$skill_target" ]] || continue
    installed_source="$(readlink "$skill_target")"
    case "$installed_source" in
      "$SKILLS_SOURCE_DIR"/*)
        rm "$skill_target"
        printf 'Removed: %s\n' "$skill_target"
        ;;
      *)
        ;;
    esac
  done
fi

printf 'Agent Kit has been uninstalled from Codex. Start a new Codex session to reload the global configuration.\n'
