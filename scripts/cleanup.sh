#!/bin/bash
# Cleanup script for dotfiles
# Removes stowed configurations and optionally cleans up installed tools

set -e

echo "╔══════════════════════════════════════════════════════════╗"
echo "║  Dotfiles Cleanup Script                                ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "This script will help you remove dotfiles configurations."
echo ""

# Function to unstow a package
unstow_package() {
    local package=$1
    local name=$2

    if [ -d "$package" ]; then
        read -p "Unstow $name? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Temporarily disable exit-on-error to handle stow failures gracefully
            set +e
            stow -D -t ~/. "$package"
            local status=$?
            # Re-enable exit-on-error for the rest of the script
            set -e

            if [ "$status" -eq 0 ]; then
                echo "✓ $name unstowed"
            else
                echo "✗ Failed to unstow $name (stow exited with code $status)"
                echo "   Please check that 'stow' is installed and that there are no conflicting files."
            fi
        fi
    fi
}

# Unstow configurations
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 1: Unstow Configurations"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

unstow_package "zsh" "Zsh configuration"
unstow_package "nvim" "Neovim configuration"
unstow_package "ghostty" "Ghostty terminal"
unstow_package "zellij" "Zellij multiplexer"
unstow_package "tmux" "Tmux configuration"

# Clean up cache and generated files
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 2: Clean Cache Files"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

read -p "Remove Oh My Zsh and cache files? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    removed_any=false

    if [ -d ~/.oh-my-zsh ]; then
        rm -rf ~/.oh-my-zsh
        removed_any=true
    fi

    # Match zcompdump files if any exist
    if compgen -G "$HOME/.zcompdump*" > /dev/null; then
        rm -f "$HOME"/.zcompdump*
        removed_any=true
    fi

    if [ -f ~/.zsh_history ]; then
        rm -f ~/.zsh_history
        removed_any=true
    fi

    if [ -f ~/.zshrc.zwc ]; then
        rm -f ~/.zshrc.zwc
        removed_any=true
    fi

    if [ "$removed_any" = true ]; then
        echo "✓ Oh My Zsh and cache cleaned"
    else
        echo "ℹ Skipped: no Oh My Zsh installation or cache files found"
    fi
fi

read -p "Remove Neovim cache and plugins? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    removed_any=false

    if [ -d ~/.local/share/nvim ]; then
        rm -rf ~/.local/share/nvim
        removed_any=true
    fi

    if [ -d ~/.local/state/nvim ]; then
        rm -rf ~/.local/state/nvim
        removed_any=true
    fi

    if [ -d ~/.cache/nvim ]; then
        rm -rf ~/.cache/nvim
        removed_any=true
    fi

    if [ "$removed_any" = true ]; then
        echo "✓ Neovim cache and plugins removed"
    else
        echo "ℹ Skipped: no Neovim cache or plugin directories found"
    fi
fi

read -p "Remove Zellij cache? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -d ~/.cache/zellij ]; then
        rm -rf ~/.cache/zellij
        echo "✓ Zellij cache removed"
    else
        echo "ℹ Skipped: Zellij cache directory not found (~/.cache/zellij)"
    fi
fi

read -p "Remove Tmux plugins? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -d ~/.tmux ]; then
        rm -rf ~/.tmux
        echo "✓ Tmux plugins removed"
    else
        echo "ℹ Skipped: Tmux plugins directory not found (~/.tmux)"
    fi
fi

# Optional: Uninstall packages
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 3: Uninstall Packages (Optional)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Do you want to uninstall Homebrew packages?"
echo "This will remove tools installed by the dotfiles setup."
echo ""

read -p "Uninstall packages? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "Uninstalling packages..."

    # Tools from brew.sh
    packages=(
        "eza"
        "fzf"
        "gh"
        "bat"
        "zellij"
        "zoxide"
        "lazygit"
        "ripgrep"
        "fd"
    )

    for pkg in "${packages[@]}"; do
        if brew list "$pkg" &>/dev/null; then
            brew uninstall "$pkg" && echo "✓ Uninstalled $pkg" || echo "⚠ Failed to uninstall $pkg"
        fi
    done

    echo ""
    echo "Note: Core tools like git, neovim, tmux, and stow were not removed."
    echo "You can remove them manually if needed."
fi

# Restore shell
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 4: Restore Default Shell"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ -f ~/.zshrc ]; then
    echo "⚠ Warning: ~/.zshrc still exists (not managed by stow)"
    read -p "Remove ~/.zshrc? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm ~/.zshrc
        echo "✓ ~/.zshrc removed"
    fi
fi

# Summary
echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  Cleanup Complete!                                       ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal: exec \$SHELL"
echo "  2. Your shell should now use default configurations"
echo ""
echo "To reinstall dotfiles:"
echo "  cd ~/dotfiles"
echo "  sh ./scripts/install.sh"
echo ""
