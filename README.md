# Fast Dotfiles

A fast macOS-focused development environment with zsh, tmux, Ghostty, Neovim, Git, and modern CLI replacements.

## Philosophy

- **Fast shell first**: native zsh prompt, cached completions, minimal startup plugins.
- **Convenient where it is cheap**: zoxide, lazy fzf bindings, autosuggestions, syntax highlighting, and modern aliases stay enabled.
- **Tmux primary**: tmux is the default multiplexer and keeps its plugin-based status line.
- **Consistent look**: Catppuccin Macchiato across terminal, tmux, and Neovim.

## Stack

| Category | Tool | Why |
| --- | --- | --- |
| Shell | Zsh + Antidote | Small plugin set and fast startup |
| Prompt | Native zsh | Styled prompt without external prompt processes |
| Terminal | Ghostty | Modern GPU-accelerated terminal |
| Multiplexer | tmux + TPM | Stable pane/session workflow with plugins |
| Editor | Neovim + LazyVim | Fast IDE-like editing |
| Versions | mise | Fast language/runtime shims |
| Git UI | Lazygit | Fast TUI for Git operations |
| Git Diff | Delta | Syntax-highlighted diffs |

## Features

### Shell

- Native two-line prompt with current directory, Git branch, and success/error symbol.
- Cached `compinit` so completion dumps are not rebuilt every shell start.
- `zsh-autosuggestions` and `zsh-syntax-highlighting`.
- Lazy fzf file and directory widgets.
- zoxide smart `cd` tracking.
- Guarded direnv hook that only runs in projects with `.envrc`.
- Modern aliases for `eza`, `bat`, `fd`, `rg`, `dust`, `duf`, and related tools.

### Tmux

- Prefix is `Ctrl+a`.
- Vim-style pane navigation and resizing.
- Catppuccin theme through TPM.
- CPU, memory, and battery status plugins.
- Reload config with `prefix + r`.

### Neovim

- LazyVim base configuration.
- Harpoon, Flash, Conform, Trouble, Gitsigns, Diffview, Treesitter, and frontend tooling.

## Installation

### Fresh System

```bash
git clone --recurse-submodules https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh ./scripts/install.sh
```

The installer will:

1. Install Homebrew when missing.
2. Install the default fast-stack tools.
3. Interactively stow zsh, Neovim, Git, Ghostty, and tmux configs.
4. Optionally install language tools.

### Existing System

```bash
sh ./scripts/brew.sh

stow -t ~/. zsh
stow -t ~/. nvim
stow -t ~/. git
stow -t ~/. ghostty
stow -t ~/. tmux
```

## Structure

```text
dotfiles/
├── git/            # Git config with delta
├── ghostty/        # Terminal configuration
├── nvim/           # Neovim + LazyVim
├── scripts/        # Installation, stow, cleanup helpers
├── tmux/           # tmux configuration
└── zsh/            # zsh config and Antidote plugin list
```

Some legacy packages may remain in the repo but are not part of the default install path.

## Keybindings

See [KEYBINDINGS.md](KEYBINDINGS.md) for the full reference.

Quick reference:

- Ghostty uses `Cmd` for terminal tabs/windows.
- tmux uses `Ctrl+a` as prefix.
- Neovim uses `Space` leader and `Ctrl` combinations.
- Shell uses `Ctrl+T` for fzf file search and `Alt+C` for fzf directory search.

## Modern CLI Tools

```bash
ls      -> eza
cat     -> bat
find    -> fd
grep    -> ripgrep
cd      -> zoxide
top     -> bottom
du      -> dust
df      -> duf
sed     -> sd
```

## Benchmarks

```bash
zsh-bench
nvim --startuptime /tmp/nvim-startup.log +q && tail -40 /tmp/nvim-startup.log
```

For zsh profiling:

```bash
zsh -i -c 'zmodload zsh/zprof; source ~/.zshrc; zprof'
```

## Post-Installation

1. Restart your shell:
   ```bash
   exec zsh
   ```

2. Configure Git identity:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   ```

3. Open Neovim once to install plugins:
   ```bash
   nvim
   ```

4. Start tmux:
   ```bash
   tmux
   ```

5. Install tmux plugins from inside tmux with `prefix + I`.

## Customization

- Zsh: edit `zsh/.zshrc` and `zsh/.zsh_plugins.txt`.
- tmux: edit `tmux/.tmux.conf`, then reload with `prefix + r`.
- Ghostty: edit `ghostty/.config/ghostty/config`.
- Neovim: edit files under `nvim/.config/nvim/lua/`.

## Cleanup

```bash
sh ./scripts/cleanup.sh
```

The cleanup script can unstow configs, clear caches, and optionally uninstall packages.

## Troubleshooting

Regenerate zsh plugin bundle:

```bash
mkdir -p ~/.cache/zsh
antidote bundle < ~/.zsh_plugins.txt > ~/.cache/zsh/plugins.zsh
```

Update Neovim plugins:

```vim
:Lazy sync
:checkhealth
```

Install tmux plugins manually:

```bash
~/.tmux/plugins/tpm/bin/install_plugins
```

## License

MIT
