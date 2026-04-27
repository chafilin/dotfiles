#!/usr/bin/env zsh
# Compile zsh configuration and warm lightweight caches.

set -e

echo "Optimizing zsh configuration..."

if [[ -f ~/.zshrc ]]; then
  echo "  Compiling ~/.zshrc..."
  zcompile ~/.zshrc 2>/dev/null || true
fi

if [[ -f ~/.cache/zsh/plugins.zsh ]]; then
  echo "  Compiling cached Antidote bundle..."
  zcompile ~/.cache/zsh/plugins.zsh 2>/dev/null || true
fi

mkdir -p ~/.cache/zsh

if (( $+commands[zoxide] )); then
  echo "  Caching zoxide initialization..."
  zoxide init zsh --cmd cd --hook none > ~/.cache/zsh/zoxide-init-hook-none.zsh
fi

echo "Optimization complete. Start a new shell to use the refreshed caches."
echo "Tip: run 'time zsh -i -c exit' to measure startup time."
