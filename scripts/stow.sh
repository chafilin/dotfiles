read -p "Do you want to stow zsh? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow zsh
fi

read -p "Do you want to stow allacritty? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow allacritty
fi

read -p "Do you want to stow nvim? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow nvim
fi

read -p "Do you want to stow tmux? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow tmux
fi

read -p "Do you want to stow zellij? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    stow zellij
fi

