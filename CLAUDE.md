# CLAUDE.md

This file provides guidance to Claude Code when working in this repository.

## Repository Overview

This is a personal macOS dotfiles repository managed with GNU Stow. The default stack is zsh, Ghostty, tmux, Neovim, Git, mise, and modern CLI tools.

## Setup

Fresh install:

```bash
sh ./scripts/install.sh
```

Script sequence:

1. `brew.sh` installs Homebrew when missing and installs the default tool stack.
2. `stow.sh` interactively stows zsh, Neovim, Git, Ghostty, and tmux configs.
3. `langs.sh` optionally installs language tools.

Manual stow:

```bash
stow -t ~/. zsh
stow -t ~/. nvim
stow -t ~/. git
stow -t ~/. ghostty
stow -t ~/. tmux
```

Remove symlinks:

```bash
stow -D -t ~/. <package-name>
```

## Architecture

Each top-level directory is a Stow package. The package structure mirrors the target path under `$HOME`.

- `zsh/` - fast zsh config, native prompt, Antidote plugin list.
- `nvim/` - LazyVim-based Neovim config.
- `tmux/` - tmux config using TPM, Catppuccin, CPU, and battery plugins.
- `ghostty/` - Ghostty terminal config.
- `git/` - Git config with delta.
- `scripts/` - install, stow, cleanup, and benchmark helpers.

## Conventions

Zsh plugins are managed through Antidote via `zsh/.zsh_plugins.txt`. Keep startup plugins minimal; the default list intentionally excludes rich completion bundles.

Neovim follows LazyVim conventions:

- Core LazyVim is imported in `lua/config/lazy.lua`.
- Custom plugins live in `lua/plugins/*.lua`.
- Each plugin file exports a plugin spec table.

tmux plugins are managed by TPM:

```bash
# Inside tmux: prefix + I
# Or:
~/.tmux/plugins/tpm/bin/install_plugins
```

The tmux prefix is `Ctrl+a`, and `prefix + r` reloads `~/.tmux.conf`.

## Config Locations

After stowing:

- `~/.zshrc` -> `dotfiles/zsh/.zshrc`
- `~/.config/nvim/` -> `dotfiles/nvim/.config/nvim/`
- `~/.gitconfig` -> `dotfiles/git/.gitconfig`
- `~/.config/ghostty/` -> `dotfiles/ghostty/.config/ghostty/`
- `~/.tmux.conf` -> `dotfiles/tmux/.tmux.conf`

## Working Rules

- Edit files in the repository, not the symlinked targets under `$HOME`.
- Preserve unrelated user changes in the dirty worktree.
- Prefer focused edits over broad rewrites unless the config has intentionally changed direction.
- Verify zsh changes with `zsh -n zsh/.zshrc` and `zsh-bench` when practical.
