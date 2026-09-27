#!/usr/bin/env bash
# Install Agent Kit globally for Codex by creating symbolic links.
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

# Reject conflicts before creating any links.
check_link_target() {
  local source_path="$1"
  local target_path="$2"
  local existing_target=""

  if [[ -L "$target_path" ]]; then
    existing_target="$(readlink "$target_path")"
    if [[ "$existing_target" == "$source_path" ]]; then
      return 0
    fi
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    printf 'Cannot install: %s already exists and is not managed by this Agent Kit checkout.\n' "$target_path" >&2
    exit 1
  fi
}

install_link() {
  local source_path="$1"
  local target_path="$2"

  if [[ -L "$target_path" && "$(readlink "$target_path")" == "$source_path" ]]; then
    printf 'Already installed: %s\n' "$target_path"
    return 0
  fi

  ln -s "$source_path" "$target_path"
  printf 'Installed: %s -> %s\n' "$target_path" "$source_path"
}

# Validate that the checkout contains all required sources.
if [[ ! -f "$INSTRUCTIONS_SOURCE" ]]; then
  printf 'Cannot install: missing %s.\n' "$INSTRUCTIONS_SOURCE" >&2
  exit 1
fi

if [[ ! -d "$SKILLS_SOURCE_DIR" ]]; then
  printf 'Cannot install: missing %s.\n' "$SKILLS_SOURCE_DIR" >&2
  exit 1
fi

check_link_target "$INSTRUCTIONS_SOURCE" "$INSTRUCTIONS_TARGET"

skill_count=0
for skill_source in "$SKILLS_SOURCE_DIR"/*; do
  [[ -d "$skill_source" ]] || continue
  skill_name="$(basename "$skill_source")"
  check_link_target "$skill_source" "$GLOBAL_SKILLS_DIR/$skill_name"
  ((skill_count += 1))
done

if ((skill_count == 0)); then
  printf 'Cannot install: no skill directories found in %s.\n' "$SKILLS_SOURCE_DIR" >&2
  exit 1
fi

mkdir -p "$CODEX_HOME_DIR"
mkdir -p "$GLOBAL_SKILLS_DIR"
install_link "$INSTRUCTIONS_SOURCE" "$INSTRUCTIONS_TARGET"

for skill_source in "$SKILLS_SOURCE_DIR"/*; do
  [[ -d "$skill_source" ]] || continue
  skill_name="$(basename "$skill_source")"
  install_link "$skill_source" "$GLOBAL_SKILLS_DIR/$skill_name"
done

printf 'Agent Kit is installed globally for Codex. Start a new Codex session to load it.\n'
