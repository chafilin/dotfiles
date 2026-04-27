#!/usr/bin/env bash
# Install the default fast-stack tools.

set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Error: Homebrew installation failed or brew is not available on PATH." >&2
  exit 1
fi

echo "Installing Homebrew formulae..."
formulae=(
  git
  stow
  antidote
  eza
  bat
  fd
  ripgrep
  sd
  zoxide
  bottom
  procs
  dust
  duf
  tmux
  tmux-mem-cpu-load
  neovim
  fzf
  gh
  direnv
  mise
  git-delta
  jesseduffield/lazygit/lazygit
  jesseduffield/lazydocker/lazydocker
  httpie
  jq
  yq
  glow
  tlrc
)
brew install "${formulae[@]}"

echo "Installing Homebrew casks..."
brew install --cask ghostty
