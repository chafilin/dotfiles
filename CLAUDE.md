# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed using GNU Stow. It contains configuration files for a macOS development environment including terminal emulators, shell, text editor, and multiplexer configurations.

## Installation Commands

**Full setup (fresh system):**
```bash
sh ./scripts/install.sh
```

This runs installation scripts in sequence:
1. `brew.sh` - Installs Homebrew and essential CLI tools (git, eza, fzf, gh, bat, stow, zellij, tmux, zoxide, neovim, lazygit, ripgrep, fd, alacritty)
2. `oh-my-zsh.sh` - Installs Oh My Zsh framework
3. `stow.sh` - Interactively stows configuration files to home directory
4. `langs.sh` - Optionally installs language tools (nvm, pnpm, rbenv, rust)

**Apply/update specific configurations:**
```bash
# Apply individual configuration to home directory
stow -t ~/. zsh
stow -t ~/. nvim
stow -t ~/. tmux
stow -t ~/. ghostty
stow -t ~/. zellij
stow -t ~/. allacritty
stow -t ~/. sketchybar

# Remove symlinks
stow -D -t ~/. <package-name>

# Restow (useful after config changes)
stow -R -t ~/. <package-name>
```

## Architecture

### Stow-based Management

Each top-level directory (zsh, nvim, tmux, etc.) is a "stow package" containing the directory structure that mirrors where files should be placed in the home directory. When stowed, GNU Stow creates symlinks from `~/.config/nvim/...` to `~/Developer/dotfiles/nvim/.config/nvim/...`.

### Directory Structure

- `zsh/` - Zsh shell configuration with Oh My Zsh
  - `.zshrc` - Main configuration (plugins, aliases, exports)
  - `.zsh/custom/plugins/` - Git submodules for zsh plugins (zsh-autosuggestions, fzf-tab, zsh-syntax-highlighting)

- `nvim/` - Neovim configuration using LazyVim
  - `lua/config/` - LazyVim core configuration
  - `lua/plugins/` - Custom plugin overrides and additions
  - Plugins loaded via lazy.nvim package manager

- `tmux/` - tmux terminal multiplexer
  - `.tmux.conf` - Uses TPM (tmux plugin manager) with catppuccin theme
  - Prefix key: `C-space`
  - Vim-style pane navigation (h/j/k/l)

- `ghostty/` - Ghostty terminal emulator configuration
- `sketchybar/` - macOS menu bar replacement configuration
- `zellij/` - Alternative terminal multiplexer configuration
- `scripts/` - Installation and setup automation

### Key Conventions

**Git Submodules:** Zsh plugins are managed as git submodules. When cloning, use:
```bash
git clone --recurse-submodules <repo-url>
# Or if already cloned:
git submodule update --init --recursive
```

**LazyVim Structure:** The nvim configuration follows LazyVim's convention where:
- Core LazyVim is imported automatically
- Custom plugins go in `lua/plugins/*.lua`
- Each plugin file exports a table with plugin specifications
- Existing configurations include: surround, test runners, theme (catppuccin), tmux-vim navigation, treesitter, typescript, UI tweaks, and web-icons

**Tmux Plugin Manager:** Tmux plugins are installed via TPM. After configuration changes:
```bash
# Inside tmux, press prefix (C-space) + I to install new plugins
# Or run: ~/.tmux/plugins/tpm/bin/install_plugins
```

**Theme Consistency:** The configuration uses Catppuccin Macchiato theme across tmux and likely other tools for visual consistency.

## Configuration File Locations

After stowing, actual config files are symlinked to:
- `~/.zshrc` → dotfiles/zsh/.zshrc
- `~/.config/nvim/` → dotfiles/nvim/.config/nvim/
- `~/.tmux.conf` → dotfiles/tmux/.tmux.conf
- `~/.config/ghostty/` → dotfiles/ghostty/.config/ghostty/
- `~/.config/sketchybar/` → dotfiles/sketchybar/.config/sketchybar/

## Common Modifications

When modifying configurations:

1. **Edit files in the dotfiles repo**, not the symlinked versions in home directory
2. **For nvim plugins:** Add new files to `nvim/.config/nvim/lua/plugins/` following LazyVim plugin spec format
3. **For zsh plugins:** Add to `plugins=()` array in `.zshrc`, or install as git submodule in `.zsh/custom/plugins/`
4. **For tmux:** Edit `.tmux.conf`, reload with `prefix + r` (bound in config)
5. **Commit and push changes** to maintain version control of dotfiles
