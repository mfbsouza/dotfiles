# AGENTS.md

Personal dotfiles monorepo. Config files live in the repo and are symlinked into
`$HOME` by `install.py`. No build system, no CI, no test suite.

## Layout

| Path                   | Contents                                                            |
| ---------------------- | ------------------------------------------------------------------- |
| `install.py`           | Installer CLI. One function per task, registered in `TASKS`.         |
| `packages/`            | `brew.py` / `debian.py`: package name strings, no logic.              |
| `scripts/`             | Top-level files are helper scripts symlinked onto `$PATH`.            |
| `scripts/laptop/`      | System scripts copied to `/opt` or `/lib` by their tasks. Not on PATH. |
| `scripts/vm/`          | One-off qemu helper. Not on PATH.                                    |
| `.config/`             | `nvim`, `vim`, `ghostty`, `wezterm`, `alacritty`, `zed`, `Code`, `MangoHud`, `vkBasalt`. |
| repo root              | `.zshrc`, `.p10k.zsh`, `.tmux.conf`, `.gitconfig`.                  |
| `assets/`, `README.md` | Screenshot and FAQ. Not functional.                                 |

## Commands

```sh
./install.py                     # interactive task menu
./install.py <task>              # run one task
./install.py --dry-run <task>    # print commands, execute nothing
./install.py all --os debian     # full bootstrap without the OS prompt
```

`--dry-run` and `--os` work before or after the task name. The `flatpak` task
still asks `[y/n]` per app on Linux, so `all` is not fully non-interactive.

- Lint and format: `uvx ruff@0.16.2 check install.py`,
  `uvx ruff@0.16.2 format install.py`. `ruff.toml` adds `extend-select = ["N"]`
  (pep8-naming). Ruff is not installed in `.venv`; use `uvx`.
- `.venv/` is a bootstrap venv with no dependencies. Use it as a clean
  interpreter if you need one.
- There are no tests. Verify with `--dry-run` and read the `ln -s` output.

## install.py conventions

Every task has the signature `def name(ctx: Context, items=None) -> None`.

**Registering a task** means adding one key to `TASKS` (`install.py:336`).
Both the argparse subcommands and the interactive menu are generated from that
dict, so nothing else is needed for a new task to be runnable.

**Paths come from `Context`** (`install.py:41`): `root_dir`, `root_cfg_dir`,
`home_dir`, `config_dir`, `bin_dir`, `operating_system`. Do not rebuild a path
inline. Add a field to `Context` and resolve it in `build_context`
(`install.py:367`) instead.

**Side effects go through the helpers**: `run_cmd` (`install.py:54`, honors the
global `dry_run`, exits with the command's code on failure), `create_directory`
(`install.py:81`), `create_symlink` (`install.py:65`). Never call `subprocess`
or `os.mkdir` directly from a task.

**Dotfiles are symlinked from the repo into `$HOME`, never copied.**
`create_symlink` is idempotent: it skips existing symlinks and warns rather than
clobbering a real file. Keep it that way.

**Adding a new dotfile:** append it to `HOME_DIR_FILES` (`install.py:23`) or
`CONFIG_DIR_FILES` (`install.py:24`). Those lists drive the `config` task, its
`items` argument, and the help text, so a file missing from them cannot be
installed by name.

**OS gating:** Linux-only tasks go in `LINUX_ONLY_TASKS` (`install.py:319`) so
they are skipped on macOS. Anything that behaves differently per OS also goes in
`OS_DEPENDENT_TASKS` (`install.py:321`) so the OS prompt is not skipped. Add to
`install_all` (`install.py:324`) only if the task belongs in a full bootstrap.

**New subcommand flags** go in the `create_parser` loop (`install.py:415`) with
`default=argparse.SUPPRESS`, read via `getattr(args, ..., None)`. See `config`'s
positional `items` and `scripts`' `--bin-dir`.

**Packages:** add names to the string constants in `packages/brew.py` or
`packages/debian.py`. Tasks import them lazily (`from packages import brew`) to
keep module import order irrelevant; keep that pattern.

## Shell scripts

New scripts: `#!/usr/bin/env bash`, `set -euo pipefail`, 4-space indent, a
`usage()` helper with `getopts` for options, no external dependencies, and
`NO_COLOR` support. Model: `scripts/git-update-all.sh`.

The POSIX `#!/bin/sh` scripts in `scripts/laptop/` run under systemd and PAM.
Do not convert them or add bashisms.

Commit new helper scripts with the executable bit set (`chmod +x`), otherwise the
`scripts` task (`install.py:209`) warns at install time.

Anything you put directly in `scripts/` is symlinked onto `$PATH` by
`install.py scripts`; `~/.local/bin` is already exported in `.zshrc`.

## Git

Commit messages: lowercase, no prefix or emoji, short subject.

```
add local bin path for all oses
install.py: added quirks for touchpad and fingerprint
```

Commits are GPG-signed (`.gitconfig`), so the signing key must be available. Do
not commit unless asked. Never commit secrets.

`.gitignore` covers `.venv`, `__pycache__`, `.DS_store`, `.ruff_cache`, and the
vendored nvim/vim plugin directories. The `!` exceptions re-include the two
VSCode settings files.
