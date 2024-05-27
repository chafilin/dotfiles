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

autoload -U compinit
compinit -i

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

export ZELLIJ_AUTO_ATTACH=true
export ZELLIJ_AUTO_EXIT=true
eval "$(zellij setup --generate-auto-start zsh)"
