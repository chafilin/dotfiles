# Dotfiles

## Installation

1. Clone the repository
1. Install homebrew from https://brew.sh/
1. Install Oh-my-zsh from https://ohmyz.sh/#install
1. Install needed instruments: `brew bundle install --file ./Brewfile`
1. Stow needed parts: `stow zsh`

## Oh-my-zsh plugins

```
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Structure

```
./
├── /allacritty
├── /nvim
├── /tmux
├── /zellij
└── /zsh
```
