read -p "Do you want to stow zsh? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. zsh
fi

read -p "Do you want to stow allacritty? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. allacritty
fi

read -p "Do you want to stow nvim? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. nvim
fi

read -p "Do you want to stow tmux? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. tmux
fi

read -p "Do you want to stow zellij? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow -t ~/. zellij
fi

