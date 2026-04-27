# --- Fast interactive zsh ---
[[ $- != *i* ]] && return

unsetopt BG_NICE
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt INTERACTIVE_COMMENTS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt PROMPT_SUBST

# --- PATH ---
_path_prepend=()
for _path_entry in "$HOME/.local/bin" "$HOME/.local/share/mise/shims" /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin /usr/local/sbin; do
  [[ -d "$_path_entry" ]] && _path_prepend+=("$_path_entry")
done
path=($_path_prepend $path)
_asdf_shims="${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
path=(${path:#$_asdf_shims})
typeset -U path
export PATH
unset _path_entry _path_prepend _asdf_shims

for _brew_prefix in /opt/homebrew /usr/local; do
  [[ -d "$_brew_prefix" ]] && BREW_PREFIX="$_brew_prefix" && break
done
unset _brew_prefix

# --- Completions ---
if [[ -d "$HOME/.docker/completions" ]]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi
typeset -U fpath

autoload -Uz compinit
_compdump_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
_compdump="$_compdump_dir/zcompdump-${ZSH_VERSION}"
[[ -d "$_compdump_dir" ]] || mkdir -p "$_compdump_dir"
if [[ -r "$_compdump" && ! "${ZDOTDIR:-$HOME}/.zsh_plugins.txt" -nt "$_compdump" ]]; then
  compinit -C -d "$_compdump"
else
  compinit -d "$_compdump"
fi
unset _compdump _compdump_dir

# --- Cached shell init snippets ---
_zsh_eval_cached() {
  local name="$1" bin="$2" init cache_dir cache_file tmp
  shift 2

  (( $+commands[$bin] )) || return 0

  cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
  cache_file="$cache_dir/${name}.zsh"

  if [[ ! -r "$cache_file" || "$commands[$bin]" -nt "$cache_file" ]]; then
    init="$("$bin" "$@")" || return
    if { [[ -d "$cache_dir" && -w "$cache_dir" ]] || mkdir -p "$cache_dir" 2>/dev/null; } && [[ -w "$cache_dir" ]]; then
      tmp="${cache_file}.$$"
      if print -r -- "$init" >| "$tmp" 2>/dev/null; then
        command mv -f "$tmp" "$cache_file" 2>/dev/null
      else
        command rm -f "$tmp" 2>/dev/null
      fi
    fi
    eval "$init"
  else
    source "$cache_file"
  fi
}

# --- Antidote plugins ---
zsh_plugins_txt="${ZDOTDIR:-$HOME}/.zsh_plugins.txt"
zsh_plugins_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/plugins.zsh"
if [[ -r "$zsh_plugins_cache" && "$zsh_plugins_cache" -nt "$zsh_plugins_txt" ]]; then
  source "$zsh_plugins_cache"
elif [[ -n "$BREW_PREFIX" && -f "$BREW_PREFIX/opt/antidote/share/antidote/antidote.zsh" ]]; then
  if (
    source "$BREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"
    antidote bundle <"$zsh_plugins_txt" >"$zsh_plugins_cache"
  ); then
    source "$zsh_plugins_cache"
  fi
fi
unset zsh_plugins_txt zsh_plugins_cache
bindkey -e

# --- Native prompt ---
__p_reset=$'%{\e[0m%}'
__p_red=$'%{\e[38;2;237;135;150m%}'
__p_peach=$'%{\e[38;2;245;169;127m%}'
__p_yellow=$'%{\e[38;2;238;212;159m%}'
__p_green=$'%{\e[38;2;166;218;149m%}'
__p_blue=$'%{\e[38;2;138;173;244m%}'
__p_overlay=$'%{\e[38;2;108;112;134m%}'

__git_branch_fast() {
  local dir="$PWD" git_dir git_file head
  REPLY=""

  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/.git" ]]; then
      git_file="$(<"$dir/.git")"
      git_dir="${git_file#gitdir: }"
      [[ "$git_dir" != /* ]] && git_dir="$dir/$git_dir"
      break
    elif [[ -d "$dir/.git" ]]; then
      git_dir="$dir/.git"
      break
    fi
    dir="${dir:h}"
  done

  [[ -n "$git_dir" && -r "$git_dir/HEAD" ]] || return 0
  head="$(<"$git_dir/HEAD")"
  if [[ "$head" == ref:\ refs/heads/* ]]; then
    REPLY="${head#ref: refs/heads/}"
  elif [[ "$head" == ref:\ * ]]; then
    REPLY="${head#ref: }"
  else
    REPLY="${head[1,7]}"
  fi
}

__prompt_precmd() {
  local exit_code="$?" branch
  __git_branch_fast
  branch="$REPLY"

  if [[ -n "$branch" ]]; then
    __prompt_git=" ${__p_yellow} ${branch}${__p_reset}"
  else
    __prompt_git=""
  fi

  if (( exit_code == 0 )); then
    __prompt_symbol="${__p_green}❯${__p_reset}"
  else
    __prompt_symbol="${__p_red}❯${__p_reset}"
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd __prompt_precmd
PROMPT='${__p_overlay}╭─${__p_blue}%3~${__p_reset}${__prompt_git}
${__p_overlay}╰─${__prompt_symbol} '
PROMPT2='${__p_overlay}›${__p_reset} '
RPROMPT=''

# --- Zoxide ---
if (( $+commands[zoxide] )); then
  _zsh_eval_cached zoxide-init-hook-none zoxide init zsh --cmd cd --hook none
  _zoxide_add_pwd_async() {
    command zoxide add -- "$PWD" >/dev/null 2>&1 &!
  }
  add-zsh-hook chpwd _zoxide_add_pwd_async
fi

# --- Direnv ---
if (( $+commands[direnv] )); then
  _direnv_has_envrc() {
    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
      [[ -f "$dir/.envrc" ]] && return 0
      dir="${dir:h}"
    done
    return 1
  }
  _direnv_hook() {
    [[ -n "${DIRENV_FILE:-}" ]] || _direnv_has_envrc || return
    trap -- '' SIGINT
    eval "$(direnv export zsh)"
    trap - SIGINT
  }
  add-zsh-hook precmd _direnv_hook
  add-zsh-hook chpwd _direnv_hook
fi

# --- FZF ---
if (( $+commands[fzf] )); then
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

  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi

  if [[ -o zle ]]; then
    _fzf_load_shell_integration() {
      (( ${_fzf_shell_integration_loaded:-0} )) && return
      _fzf_shell_integration_loaded=1
      _zsh_eval_cached fzf-init fzf --zsh 2>/dev/null
    }
    _fzf_file_widget_lazy() {
      _fzf_load_shell_integration
      zle fzf-file-widget
    }
    _fzf_cd_widget_lazy() {
      _fzf_load_shell_integration
      zle fzf-cd-widget
    }
    zle -N fzf-file-widget-lazy _fzf_file_widget_lazy
    zle -N fzf-cd-widget-lazy _fzf_cd_widget_lazy
    bindkey -M emacs '^T' fzf-file-widget-lazy
    bindkey -M emacs '\ec' fzf-cd-widget-lazy
  fi
fi

# --- Editor ---
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"

# --- Aliases ---
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

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias gst='git status -sb'
alias glog='git log --oneline --graph --all --decorate'
alias gwip='git add -A && git commit -m "WIP"'
alias lg='lazygit'
alias lzd='lazydocker'

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias fv="fzf --preview 'bat --style=numbers --color=always {}' --bind 'enter:become(nvim {})'"

alias t='tmux'
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session'

alias brewup='brew update && brew upgrade && brew cleanup'
alias brewlist='brew leaves'
alias vim='nvim'
alias vi='nvim'
alias zsh-bench='for i in {1..10}; do time zsh -i -c exit; done'

# --- Keybindings ---
for keymap in emacs; do
  [[ -n ${terminfo[kLFT3]} ]] && bindkey -M "$keymap" "${terminfo[kLFT3]}" backward-word
  [[ -n ${terminfo[kRIT3]} ]] && bindkey -M "$keymap" "${terminfo[kRIT3]}" forward-word
  [[ -n ${terminfo[kUP3]} ]] && bindkey -M "$keymap" "${terminfo[kUP3]}" up-line-or-history
  [[ -n ${terminfo[kDN3]} ]] && bindkey -M "$keymap" "${terminfo[kDN3]}" down-line-or-history

  bindkey -M "$keymap" $'\e[1;3D' backward-word
  bindkey -M "$keymap" $'\e[1;3C' forward-word
  bindkey -M "$keymap" $'\e[1;3A' up-line-or-history
  bindkey -M "$keymap" $'\e[1;3B' down-line-or-history
done

bindkey -M emacs $'\e[1~' beginning-of-line
bindkey -M emacs $'\e[4~' end-of-line
bindkey -M emacs $'\eOH' beginning-of-line
bindkey -M emacs $'\eOF' end-of-line

# --- Auto-compile .zshrc ---
if [[ ! -f ~/.zshrc.zwc || ~/.zshrc -nt ~/.zshrc.zwc ]]; then
  zcompile ~/.zshrc &>/dev/null &!
fi
