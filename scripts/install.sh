#!/bin/bash
# Modern dotfiles installation script

on_interrupt() {
  echo ""
  echo "!! Installation interrupted by user (Ctrl+C)."
  echo "   Some steps may not have completed."
  echo "   You can safely re-run ./scripts/install.sh to resume or repair the setup."
  exit 130
}

trap on_interrupt INT
set -e  # Exit on error

echo "╔══════════════════════════════════════════════════════════╗"
echo "║  Modern Dotfiles Setup - From Scratch Configuration     ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Install Homebrew and tools
echo "→ Installing Homebrew and essential tools..."
./scripts/brew.sh

# Stow configurations
echo ""
echo "→ Setting up dotfiles..."
./scripts/stow.sh

# Install language tools (optional)
echo ""
echo "→ Installing language tools..."
./scripts/langs.sh

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

# Ghostty
echo ""
echo "→ Ghostty terminal configured"
echo "  Launch Ghostty to use the new configuration"

# Tmux
echo ""
echo "→ Tmux multiplexer configured"
echo "  Prefix: Ctrl+a"
echo "  Install/update plugins inside tmux with: prefix + I"

# Neovim
echo ""
echo "→ Neovim with LazyVim + modern plugins"
echo "  First launch will install plugins automatically"
echo "  Includes: Harpoon, Flash, Conform, and more"

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
echo "  4. Run 'tmux' or alias 't' to start the multiplexer"
echo "  5. Run 'zsh-bench' to check shell startup time (<50ms target)"
echo ""
echo "Key features:"
echo "  • Native zsh prompt - styled without external prompt processes"
echo "  • Tmux - plugin-based status and pane workflow"
echo "  • Delta - syntax-highlighted git diffs"
echo "  • Modern CLI tools: eza, bat, fd, ripgrep, zoxide, and more"
echo ""
