#!/usr/bin/env bash
# Stow dotfiles to the home directory.

set -euo pipefail

ask_stow() {
  local package="$1"
  local label="$2"
  local default="${3:-y}"
  local prompt="[y/n]"

  if [[ "$default" == "y" ]]; then
    prompt="[Y/n]"
  else
    prompt="[y/N]"
  fi

  read -r -p "Stow ${label}? ${prompt} " reply
  reply="${reply:-$default}"
  if [[ "$reply" =~ ^[Yy]$ ]]; then
    stow -t "$HOME" "$package"
    echo "✓ ${label} stowed"
  fi
}

echo "Stowing dotfiles packages..."
echo ""

ask_stow "zsh" "Zsh configuration" "y"
ask_stow "nvim" "Neovim configuration" "y"
ask_stow "git" "Git configuration" "y"
ask_stow "ghostty" "Ghostty terminal configuration" "y"
ask_stow "tmux" "Tmux configuration" "y"

echo ""
echo "✓ Stow complete!"
