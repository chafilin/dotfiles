
# --- Profile (enable for timing) ---
# zmodload zsh/zprof

# --- Only run heavy init in interactive shells ---
[[ $- != *i* ]] && return

# --- Skip global compinit (OMZ will handle it) ---
skip_global_compinit=1

# --- Oh My Zsh setup ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
ZSH_CUSTOM="$HOME/.zsh/custom"

# --- Disable OMZ update/zrecompile at startup ---
zstyle ':omz:update' mode disabled
export DISABLE_AUTO_UPDATE="true"

# --- Skip OMZ ls feature detection (kills test-ls-args) ---
export DISABLE_LS_COLORS=true

# --- Temporarily shadow zrecompile during OMZ load ---
zrecompile() { return 0 }

# --- Plugins: note fzf is removed, fzf-tab stays ---
plugins=(
  git
  node
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# --- Completions ---
fpath=(~/.zsh/completions $fpath)

# Cached compinit (fast, no compaudit warnings)
export ZSH_DISABLE_COMPFIX=true
autoload -Uz compinit
_compdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${_compdump:h}"
compinit -C -d "$_compdump"

# --- Cached Homebrew prefix (no brew call each shell) ---
if [[ -r "$HOME/.cache/brew-prefix" ]]; then
  BREW_PREFIX="$(<"$HOME/.cache/brew-prefix")"
elif command -v brew >/dev/null 2>&1; then
  mkdir -p "$HOME/.cache"
  BREW_PREFIX="$(brew --prefix 2>/dev/null)"; print -r -- "$BREW_PREFIX" > "$HOME/.cache/brew-prefix"
else
  for p in /opt/homebrew /usr/local; do [[ -d "$p" ]] && BREW_PREFIX="$p" && break; done
fi
if [[ -n "$BREW_PREFIX" && -d "$BREW_PREFIX/share/zsh/site-functions" ]]; then
  FPATH="$BREW_PREFIX/share/zsh/site-functions:${FPATH}"
fi

# --- Load OMZ ---
source "$ZSH/oh-my-zsh.sh"

# --- Restore real zrecompile after OMZ init ---
unset -f zrecompile

# --- LAZY fzf setup ---
autoload -Uz add-zsh-hook
_fzf_lazy_source() {
  local _keys=(
    "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
    "$HOME/.fzf/shell/key-bindings.zsh"
    "/usr/share/fzf/key-bindings.zsh"
  )
  local _comp=(
    "$BREW_PREFIX/opt/fzf/shell/completion.zsh"
    "$HOME/.fzf/shell/completion.zsh"
    "/usr/share/fzf/completion.zsh"
  )
  for f in "${_keys[@]}"; do [[ -r $f ]] && source "$f" && break; done
  for f in "${_comp[@]}"; do [[ -r $f ]] && source "$f" && break; done
}
_fzf_on_demand() { _fzf_lazy_source; zle "$1"; }
_fzf_file_stub() { _fzf_on_demand fzf-file-widget; }
_fzf_hist_stub() { _fzf_on_demand fzf-history-widget; }
_fzf_cd_stub()   { _fzf_on_demand fzf-cd-widget; }
zle -N fzf-file-widget  _fzf_file_stub
zle -N fzf-history-widget _fzf_hist_stub
zle -N fzf-cd-widget    _fzf_cd_stub
bindkey '^T' fzf-file-widget
bindkey '^R' fzf-history-widget
bindkey '^[c' fzf-cd-widget
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --bind=ctrl-j:down,ctrl-k:up'

# --- Editor ---
export EDITOR="nvim"
export SUDO_EDITOR="nvim"

# --- Aliases ---
alias cat='bat -pp --theme=base16'
alias ls='eza -lh --group-directories-first --icons'
alias ll='eza -alh'
alias tree='eza --tree --level=2 --long --icons --git'
alias ff="fzf --preview 'bat --style=numbers --color=always --theme=base16 {}'"
alias z="zellij"
alias lzd='lazydocker'
alias lg='lazygit'

# --- zoxide (cached for performance) ---
_zoxide_cache="$HOME/.cache/zsh/zoxide-init.zsh"
if [[ ! -s "$_zoxide_cache" ]] || [[ "$_zoxide_cache" -ot "$(command -v zoxide 2>/dev/null)" ]]; then
  mkdir -p "${_zoxide_cache:h}"
  zoxide init --cmd cd zsh > "$_zoxide_cache" 2>/dev/null
fi
[[ -s "$_zoxide_cache" ]] && source "$_zoxide_cache"

# --- bun completions (lazy loaded) ---
if [[ -s "$HOME/.bun/_bun" ]]; then
  _bun_comp_lazy() {
    source "$HOME/.bun/_bun"
    unset -f _bun_comp_lazy
  }
  # Load on first bun command
  bun() { _bun_comp_lazy; command bun "$@"; }
fi

# --- bun / asdf paths ---
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# --- Compile zsh files for faster loading (run manually: zcompile ~/.zshrc) ---
# Auto-compile .zshrc if modified
if [[ ! -f ~/.zshrc.zwc ]] || [[ ~/.zshrc -nt ~/.zshrc.zwc ]]; then
  zcompile ~/.zshrc &>/dev/null &!
fi

# --- Profile output (enable to check) ---
# zprof

export PATH="$HOME/.local/bin:$PATH"
