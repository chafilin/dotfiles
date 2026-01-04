#!/usr/bin/env zsh
# Compile zsh configuration files for faster loading

set -e

echo "🚀 Optimizing Zsh configuration..."

# Compile main zshrc
if [[ -f ~/.zshrc ]]; then
  echo "  Compiling ~/.zshrc..."
  zcompile ~/.zshrc 2>/dev/null || true
fi

# Compile custom plugins
if [[ -d ~/.zsh/custom/plugins ]]; then
  echo "  Compiling custom plugins..."
  for plugin_file in ~/.zsh/custom/plugins/**/*.zsh(N); do
    zcompile "$plugin_file" 2>/dev/null || true
  done
fi

# Compile OMZ files
if [[ -d ~/.oh-my-zsh ]]; then
  echo "  Compiling Oh My Zsh core files..."
  zcompile ~/.oh-my-zsh/oh-my-zsh.sh 2>/dev/null || true

  echo "  Compiling Oh My Zsh lib files..."
  for lib_file in ~/.oh-my-zsh/lib/*.zsh(N); do
    zcompile "$lib_file" 2>/dev/null || true
  done

  echo "  Compiling Oh My Zsh plugins..."
  for plugin_file in ~/.oh-my-zsh/plugins/*/*.plugin.zsh(N); do
    zcompile "$plugin_file" 2>/dev/null || true
  done
fi

# Create cache directories
mkdir -p ~/.cache/zsh

# Cache zoxide init if not already cached
if [[ -x "$(command -v zoxide)" ]] && [[ ! -f ~/.cache/zsh/zoxide-init.zsh ]]; then
  echo "  Caching zoxide initialization..."
  zoxide init --cmd cd zsh > ~/.cache/zsh/zoxide-init.zsh
fi

# Cache Homebrew prefix if not already cached
if [[ -x "$(command -v brew)" ]] && [[ ! -f ~/.cache/brew-prefix ]]; then
  echo "  Caching Homebrew prefix..."
  brew --prefix > ~/.cache/brew-prefix
fi

echo "✅ Optimization complete! Start a new shell to see improvements."
echo ""
echo "💡 Tip: Run 'time zsh -i -c exit' to measure your shell startup time."
