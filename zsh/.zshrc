# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
ZSH_CUSTOM=$HOME/.zsh/custom

plugins=(
  git
  node
  fzf
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
)
fpath=(~/.zsh/completions $fpath)

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
source $ZSH/oh-my-zsh.sh

# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="nvim"

# User configuration
alias cat='bat -pp --theme=base16'
alias ls='eza -lh --group-directories-first --icons'
alias ll='eza -alh'
alias tree='eza --tree --level=2 --long --icons --git'
alias ff="fzf --preview 'bat --style=numbers --color=always --theme=base16 {}'"
alias z="zellij"
alias lzd='lazydocker'
alias lg='lazygit'

eval "$(zoxide init --cmd cd zsh)"

# bun completions
[ -s "/Users/vladimir.shchedrin/.bun/_bun" ] && source "/Users/vladimir.shchedrin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
