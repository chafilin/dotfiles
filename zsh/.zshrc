# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
  git
  rails
  ruby
  node
  fzf
  fzf-tab
  nvm
  docker
  docker-compose
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
alias cat='bat -pp --theme=base16'
alias ls='eza -lh --group-directories-first --icons' 
alias ll='eza -alh'
alias tree='eza --tree --level=2 --long --icons --git'
alias ff="fzf --preview 'bat --style=numbers --color=always --theme=base16 {}'" 
alias z="zellij"
alias lzd='lazydocker'

# eval "$(fzf --zsh)"
eval $(thefuck --alias)
eval "$(zoxide init --cmd cd zsh)"
eval "$(rbenv init - zsh)"

# pnpm
export PNPM_HOME="/Users/chafilin/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# cargo env
source $HOME/.cargo/env

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

# zellij setup
eval "$(zellij setup --generate-auto-start zsh)"
