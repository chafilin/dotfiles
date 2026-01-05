#!/bin/bash
# Stow dotfiles to home directory

echo "Stowing dotfiles packages..."
echo ""

# Essential packages - recommended to install all
read -p "Do you want to stow zsh? (recommended: y) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. zsh
    echo "✓ Zsh configuration stowed"
fi

read -p "Do you want to stow nvim? (recommended: y) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. nvim
    echo "✓ Neovim configuration stowed"
fi

read -p "Do you want to stow git? (recommended: y) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. git
    echo "✓ Git configuration with delta stowed"
fi

read -p "Do you want to stow starship? (recommended: y) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. starship
    echo "✓ Starship prompt configuration stowed"
fi

read -p "Do you want to stow atuin? (recommended: y) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. atuin
    echo "✓ Atuin history configuration stowed"
fi

# Terminal & Multiplexer
echo ""
echo "Terminal and Multiplexer:"

read -p "Do you want to stow ghostty? (recommended: y) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. ghostty
    echo "✓ Ghostty terminal configuration stowed"
fi

read -p "Do you want to stow zellij? (recommended: y) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. zellij
    echo "✓ Zellij multiplexer configuration stowed"
fi

# Optional: tmux (if you prefer it over zellij)
read -p "Do you want to stow tmux? (optional, y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. tmux
    echo "✓ Tmux configuration stowed"
fi

echo ""
echo "✓ Stow complete!"

