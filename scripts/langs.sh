#!/bin/bash
# Optional language tools installation
# Using mise (modern, Rust-based version manager)

echo ""
echo "Language tools and version managers (optional)"
echo "Note: mise is already installed from brew.sh"
echo ""

# Mise is the modern replacement for asdf
echo "→ Mise (version manager)"
echo "  Mise is already installed and activated in .zshrc"
echo "  Usage examples:"
echo "    mise use node@20      # Install and use Node 20"
echo "    mise use python@3.12  # Install and use Python 3.12"
echo "    mise use go@latest    # Install and use latest Go"
echo ""

# pnpm
read -p "Do you want to install pnpm (fast npm alternative)? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install pnpm
  echo "✓ pnpm installed"
fi

# Rust
echo ""
read -p "Do you want to install Rust? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  echo "✓ Rust installed"
  echo "  Remember to restart your shell or run: source ~/.cargo/env"
fi

# Bun
echo ""
read -p "Do you want to install Bun (fast JS runtime)? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  curl -fsSL https://bun.sh/install | bash
  echo "✓ Bun installed"
fi

echo ""
echo "Language tools setup complete!"
echo ""
echo "Common mise commands:"
echo "  mise install node@20        # Install Node.js 20"
echo "  mise use -g node@20         # Set Node.js 20 globally"
echo "  mise install python@3.12    # Install Python 3.12"
echo "  mise ls                     # List installed versions"
echo "  mise ls-remote node         # List available Node versions"
echo ""
