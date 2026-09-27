# Agent Kit

A toolkit for building and working with AI agents.

## Installation

### Codex

Agent Kit can be installed globally for Codex. The installation makes the
shared working agreements and all included skills available in every project.

The installer creates symbolic links:

- `${CODEX_HOME:-~/.codex}/AGENTS.md` points to
  `instructions/working-agreements.md`;
- each directory under `skills/` is linked into `~/.agents/skills/`.

Because symbolic links are used, keep the cloned repository in its original
location after installation. Updates pulled into the repository become
available to Codex automatically.

#### Install with the script

Requirements:

- Git;
- Bash;
- Codex.

```bash
git clone https://github.com/bohdanmoroziuk/agent-kit.git agent-kit
cd agent-kit
./scripts/codex/install.sh
```

The installer is idempotent and does not overwrite existing files or symbolic
links. If a destination is already occupied by another installation, the
script stops and reports the conflict.

Set `CODEX_HOME` before running the installer to use a custom Codex home
directory. Skills are always installed into the shared global
`~/.agents/skills/` directory.

Start a new Codex session after installation so that the global instructions
and skills are discovered.

#### Install manually

Run these commands from the Agent Kit repository:

```bash
set -e
mkdir -p "${CODEX_HOME:-"$HOME/.codex"}" "$HOME/.agents/skills"
ln -s "$PWD/instructions/working-agreements.md" "${CODEX_HOME:-"$HOME/.codex"}/AGENTS.md"
for skill in "$PWD"/skills/*; do
  [ -d "$skill" ] || continue
  ln -s "$skill" "$HOME/.agents/skills/$(basename "$skill")"
done
```

#### Uninstall

Run the uninstall script from the same repository location used during
installation:

```bash
./scripts/codex/uninstall.sh
```

If `CODEX_HOME` was used during installation, provide the same value when
running the uninstall script. The script removes only symbolic links that
point into the current Agent Kit checkout and leaves unrelated files intact.

## License

This project is licensed under the [MIT License](LICENSE).
