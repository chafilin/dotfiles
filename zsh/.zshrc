# --- Profile (temporary while verifying) ---
# zmodload zsh/zprof

# --- Only run interactive init ---
[[ $- != *i* ]] && return

# --- Oh My Zsh path ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
ZSH_CUSTOM="$HOME/.zsh/custom"

# --- Disable OMZ update work on startup (prevents handle_update/zrecompile) ---
zstyle ':omz:update' mode disabled
export DISABLE_AUTO_UPDATE="true"

# --- Plugins: remove `fzf` (it’s the slow one); keep fzf-tab/autosuggest/highlight ---
plugins=(
  git
  node
  # fzf        # ← remove this, we’ll lazy-load fzf ourselves
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# --- Completions path (yours) ---
fpath=(~/.zsh/completions $fpath)

# --- FAST compinit: cached, no compaudit scan every shell ---
export ZSH_DISABLE_COMPFIX=true
autoload -Uz compinit
_compdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${_compdump:h}"
compinit -C -d "$_compdump"

# --- Avoid running `brew --prefix` on every startup ---
# Cache Homebrew prefix once; use common fallbacks if cache missing.
if [[ -r "$HOME/.cache/brew-prefix" ]]; then
  BREW_PREFIX="$(<"$HOME/.cache/brew-prefix")"
elif command -v brew >/dev/null 2>&1; then
  mkdir -p "$HOME/.cache"
  BREW_PREFIX="$(brew --prefix 2>/dev/null)"; print -r -- "$BREW_PREFIX" > "$HOME/.cache/brew-prefix"
else
  # Fallbacks: Apple Silicon / Intel macOS
  for p in /opt/homebrew /usr/local; do [[ -d "$p" ]] && BREW_PREFIX="$p" && break; done
fi

# Put brew site-functions on FPATH without invoking brew now
if [[ -n "$BREW_PREFIX" && -d "$BREW_PREFIX/share/zsh/site-functions" ]]; then
  FPATH="$BREW_PREFIX/share/zsh/site-functions:${FPATH}"
fi

# --- Load OMZ (now that compinit/FPATH are set) ---
source "$ZSH/oh-my-zsh.sh"

# --- LAZY fzf: load keybindings/completion only when first used ---
autoload -Uz add-zsh-hook

_fzf_lazy_source() {
  # Try common fzf script locations (brew, ~/.fzf, distro)
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

# Stub widgets: first press loads fzf, then replays the widget
zle -N fzf-file-widget      _fzf_file_stub
zle -N fzf-history-widget   _fzf_hist_stub
zle -N fzf-cd-widget        _fzf_cd_stub
_fzf_file_stub() { _fzf_on_demand fzf-file-widget; }
_fzf_hist_stub() { _fzf_on_demand fzf-history-widget; }
_fzf_cd_stub()   { _fzf_on_demand fzf-cd-widget; }

# Default bindings (fzf will refine once loaded)
bindkey '^T' fzf-file-widget
bindkey '^R' fzf-history-widget
bindkey '^[c' fzf-cd-widget

# Make fzf fast once invoked
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --bind=ctrl-j:down,ctrl-k:up'

# --- Editor ---
export EDITOR="nvim"
export SUDO_EDITOR="nvim"

# --- Aliases (yours) ---
alias cat='bat -pp --theme=base16'
alias ls='eza -lh --group-directories-first --icons'
alias ll='eza -alh'
alias tree='eza --tree --level=2 --long --icons --git'
alias ff="fzf --preview 'bat --style=numbers --color=always --theme=base16 {}'"
alias z="zellij"
alias lzd='lazydocker'
alias lg='lazygit'

# --- zoxide ---
eval "$(zoxide init --cmd cd zsh)"

# --- bun completions ---
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# --- bun / asdf paths ---
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# --- Profile output (temporary) ---
# zprof

