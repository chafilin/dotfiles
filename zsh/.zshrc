# --- Modern minimal .zshrc ---
# Target: <50ms startup time

# --- Skip non-interactive shells ---
[[ $- != *i* ]] && return

# --- Completions setup (early) ---
autoload -Uz compinit
_compdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${_compdump:h}"
if [[ -n ${_compdump}(#qNmh+24) ]]; then
  compinit -d "$_compdump"
else
  compinit -C -d "$_compdump"
fi

# --- Cached Homebrew prefix ---
if [[ -r "$HOME/.cache/brew-prefix" ]]; then
  BREW_PREFIX="$(<"$HOME/.cache/brew-prefix")"
elif command -v brew >/dev/null 2>&1; then
  mkdir -p "$HOME/.cache"
  BREW_PREFIX="$(brew --prefix 2>/dev/null)"
  print -r -- "$BREW_PREFIX" > "$HOME/.cache/brew-prefix"
else
  for p in /opt/homebrew /usr/local; do [[ -d "$p" ]] && BREW_PREFIX="$p" && break; done
fi

# --- Antidote plugin manager ---
if [[ -f "$BREW_PREFIX/opt/antidote/share/antidote/antidote.zsh" ]]; then
  source "$BREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"

  # Static loading for performance (no dynamic plugin changes)
  zsh_plugins="${ZDOTDIR:-$HOME}/.zsh_plugins"
  if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
    (
      source "$BREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"
      antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
    )
  fi
  source ${zsh_plugins}.zsh
fi

# --- Starship prompt ---
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# --- Atuin (modern history) ---
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# --- Zoxide (smart cd) ---
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# --- Direnv (project environments) ---
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# --- Mise (version manager) ---
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# --- FZF (lazy loaded) ---
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"

  # Enhanced FZF settings with Catppuccin theme
  export FZF_DEFAULT_OPTS="
    --height 40%
    --layout=reverse
    --border
    --preview-window=right:60%:wrap
    --bind=ctrl-j:down,ctrl-k:up
    --bind=ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down
    --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
    --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
    --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

  # Use fd for fzf if available
  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi
fi

# --- Editor ---
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"

# --- Aliases ---
# Modern replacements
alias ls='eza -lh --group-directories-first --icons'
alias ll='eza -alh --group-directories-first --icons'
alias tree='eza --tree --level=2 --long --icons --git'
alias cat='bat -pp'
alias find='fd'
alias grep='rg'
alias top='btm'
alias ps='procs'
alias du='dust'
alias df='duf'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git shortcuts
alias gst='git status -sb'
alias glog='git log --oneline --graph --all --decorate'
alias gwip='git add -A && git commit -m "WIP"'
alias lg='lazygit'
alias lzd='lazydocker'

# FZF helpers
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias fv="fzf --preview 'bat --style=numbers --color=always {}' --bind 'enter:become(nvim {})'"

# Zellij
alias z='zellij'
alias zls='zellij list-sessions'
alias za='zellij attach'

# Brew maintenance
alias brewup='brew update && brew upgrade && brew cleanup'
alias brewlist='brew leaves'

# Development
alias vim='nvim'
alias vi='nvim'

# Quick benchmarks
alias zsh-bench='for i in {1..10}; do time zsh -i -c exit; done'

# --- PATH ---
export PATH="$HOME/.local/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# --- Auto-compile .zshrc ---
if [[ ! -f ~/.zshrc.zwc ]] || [[ ~/.zshrc -nt ~/.zshrc.zwc ]]; then
  zcompile ~/.zshrc &>/dev/null &!
fi

# --- Zsh options ---
setopt AUTO_CD              # cd by just typing directory name
setopt AUTO_PUSHD           # push old directory onto stack
setopt PUSHD_IGNORE_DUPS    # don't push duplicates
setopt PUSHD_SILENT         # don't print directory stack
setopt INTERACTIVE_COMMENTS # allow comments in interactive mode
setopt HIST_IGNORE_ALL_DUPS # remove older duplicate entries from history
setopt HIST_REDUCE_BLANKS   # remove blanks from history
setopt SHARE_HISTORY        # share history between sessions

# bun completions
[ -s "/Users/vladimir.shchedrin/.bun/_bun" ] && source "/Users/vladimir.shchedrin/.bun/_bun"
