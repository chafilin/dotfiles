# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
ZSH_CUSTOM=$HOME/.zsh/custom

plugins=(
  git
  node
  fzf
  fzf-tab
  nvm
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

function zr () { zellij run --name "$*" -- zsh -ic "$*";}
function zrf () { zellij run --name "$*" --floating -- zsh -ic "$*";}
function zri () { zellij run --name "$*" --in-place -- zsh -ic "$*";}
function ze () { zellij edit "$*";}
function zef () { zellij edit --floating "$*";}
function zei () { zellij edit --in-place "$*";}
function zpipe () {
  if [ -z "$1" ]; then
    zellij pipe;
  else
    zellij pipe -p $1;
  fi
}

# export ZELLIJ_AUTO_EXIT=true
#
# if [[ -z "$ZELLIJ" && "$TERM_PROGRAM" != "vscode" && "$TERM_PROGRAM" != "WarpTerminal"  ]]; then
#     if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
#         zellij attach -c
#     else
#         zellij
#     fi
#
#     if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
#         exit
#     fi
# fi
