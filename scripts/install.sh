#!/bin/bash
# Modern dotfiles installation script

set -e  # Exit on error

echo "╔══════════════════════════════════════════════════════════╗"
echo "║  Modern Dotfiles Setup - From Scratch Configuration     ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Install Homebrew and tools
echo "→ Installing Homebrew and essential tools..."
source ./scripts/brew.sh

# Stow configurations
echo ""
echo "→ Setting up dotfiles..."
source ./scripts/stow.sh

# Install language tools (optional)
echo ""
echo "→ Installing language tools..."
source ./scripts/langs.sh

# Post-install setup
echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  Post-Installation Steps                                ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Initialize Antidote plugins
echo "→ Initializing zsh plugins with Antidote..."
if command -v antidote >/dev/null 2>&1; then
  mkdir -p ~/.cache/zsh
  # Plugins will be auto-loaded on first zsh startup
  echo "✓ Antidote is ready (plugins will load on first shell start)"
else
  echo "⚠ Antidote not found. Please install with: brew install antidote"
fi

# Initialize Atuin
echo ""
echo "→ Setting up Atuin (shell history)..."
if command -v atuin >/dev/null 2>&1; then
  echo "✓ Atuin installed. Register at https://atuin.sh to sync history across machines (optional)"
  echo "  Or keep it local - it works great offline too!"
else
  echo "⚠ Atuin not found."
fi

# Starship
echo ""
echo "→ Starship prompt ready"
echo "  Custom configuration at ~/.config/starship.toml"

# Ghostty
echo ""
echo "→ Ghostty terminal configured"
echo "  Launch Ghostty to use the new configuration"

# Zellij
echo ""
echo "→ Zellij multiplexer configured"
echo "  Alt-based keybindings (no conflicts with Neovim)"
echo "  Usage: Run 'zellij' or alias 'z'"

# Neovim
echo ""
echo "→ Neovim with LazyVim + modern plugins"
echo "  First launch will install plugins automatically"
echo "  Includes: Codeium AI, Harpoon, Flash, Conform, and more"

# Git
echo ""
echo "→ Git configured with delta for beautiful diffs"
echo "  Don't forget to set your user info:"
echo "  git config --global user.name \"Your Name\""
echo "  git config --global user.email \"your@email.com\""

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  Installation Complete! 🚀                              ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: exec zsh"
echo "  2. Launch Ghostty terminal emulator"
echo "  3. Open nvim to install plugins"
echo "  4. Try 'zellij' to start the multiplexer"
echo "  5. Run 'zsh-bench' to check shell startup time (<50ms target)"
echo ""
echo "Key features:"
echo "  • Starship prompt - beautiful and fast"
echo "  • Atuin - searchable shell history (Ctrl+R)"
echo "  • Zellij - modern multiplexer (Alt+key bindings)"
echo "  • Delta - syntax-highlighted git diffs"
echo "  • Modern CLI tools: eza, bat, fd, ripgrep, zoxide, and more"
echo ""
