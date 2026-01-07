# Modern Dotfiles

A blazingly fast, modern development environment built from scratch with performance and developer experience in mind.

## Philosophy

- **Speed First**: Shell loads in <50ms, every tool optimized for performance
- **Modern Tools**: Rust-based replacements, GPU-accelerated terminal, async everything
- **Zero Conflicts**: Carefully designed keybindings across all layers
- **Beautiful**: Catppuccin Macchiato theme everywhere
- **Productive**: AI assistance, smart navigation, fuzzy everything

## The Stack

| Category | Tool | Why |
|----------|------|-----|
| **Shell** | Zsh + Antidote | Fast plugin manager, no OMZ bloat |
| **Prompt** | Starship | Rust-based, 5-10ms overhead |
| **History** | Atuin | SQLite-based, searchable, sync-able |
| **Terminal** | Ghostty | Modern, GPU-accelerated, Zig-based |
| **Multiplexer** | Zellij | Rust-based, better UX than tmux |
| **Editor** | Neovim + LazyVim | Fast, extensible, modern plugins |
| **Versions** | Mise | Rust-based asdf replacement |
| **Git UI** | Lazygit | Fast TUI for git operations |
| **Git Diff** | Delta | Beautiful syntax-highlighted diffs |
| **Theme** | Catppuccin Macchiato | Consistent across all tools |

## Features

### Shell
- ⚡ **<50ms startup time** (vs 200ms+ with Oh My Zsh)
- 🔍 **Atuin history** - Full-text search, statistics, optional sync
- 🌟 **Starship prompt** - Shows git status, language versions, execution time
- 🚀 **Modern CLI tools**: eza, bat, fd, ripgrep, zoxide, and more
- 📦 **Smart completions** - fzf-tab for fuzzy tab completion

### Terminal & Multiplexer
- 🖥️ **Ghostty** - Latest terminal tech, GPU-accelerated
- 🧩 **Zellij** - Modern multiplexer with Alt-key bindings (no conflicts!)
- 🎨 **Catppuccin theme** - Beautiful, easy on the eyes

### Editor (Neovim)
- 📌 **Harpoon** - Lightning-fast file bookmarking
- ⚡ **Flash.nvim** - Jump anywhere with 2-3 keystrokes
- 🎨 **Conform.nvim** - Modern async formatting
- 🔧 **Enhanced LSP** - Full IDE features, fast
- 📊 **Trouble** - Better diagnostics and quickfix

### Git
- 🎨 **Delta** - Beautiful side-by-side diffs with syntax highlighting
- 🎯 **Lazygit** - Full-featured TUI for complex operations
- 📝 **Gitsigns** - Inline git status, hunk operations
- 🔀 **Diffview** - Advanced diff and merge tool

## Installation

### Fresh System

```bash
# Clone with submodules
git clone --recurse-submodules https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run full setup
sh ./scripts/install.sh
```

The installer will:
1. Install Homebrew and all tools
2. Interactively stow configurations
3. Optionally install language tools
4. Set up everything automatically

### Existing System

```bash
# Update tools
sh ./scripts/brew.sh

# Stow specific configs
stow -t ~/. zsh
stow -t ~/. nvim
stow -t ~/. git
stow -t ~/. starship
stow -t ~/. atuin
stow -t ~/. ghostty
stow -t ~/. zellij
```

## Structure

```text
dotfiles/
├── atuin/          # Modern shell history
├── git/            # Git config with delta
├── ghostty/        # Terminal configuration
├── nvim/           # Neovim + LazyVim
├── scripts/        # Installation scripts
│   ├── brew.sh     # All tools installation
│   ├── install.sh  # Main installer
│   ├── stow.sh     # Interactive stow
│   ├── langs.sh    # Language tools
│   └── cleanup.sh  # Uninstall script
├── starship/       # Prompt configuration
├── tmux/           # Tmux (optional)
├── zellij/         # Zellij multiplexer
└── zsh/            # Zsh with Antidote
    ├── .zshrc      # Main config
    └── .zsh_plugins.txt  # Plugin list
```

## Keybindings

**No conflicts by design!** Each tool uses distinct modifier keys:

- **Ghostty**: `Cmd` (macOS) for terminal operations
- **Zellij**: `Alt` (Option) exclusively for multiplexer
- **Neovim**: `Space` leader + `Ctrl` combinations

See [KEYBINDINGS.md](KEYBINDINGS.md) for complete reference.

### Quick Reference

**Zellij (Multiplexer)**
- `Alt+P` → Pane mode
- `Alt+T` → Tab mode
- `Alt+H/J/K/L` → Navigate panes
- `Alt+N` → New pane

**Neovim (Editor)**
- `Space` → Leader key
- `Ctrl+H/J/K/L` → Navigate windows
- `<leader>ff` → Find files
- `<leader>a` → Add to Harpoon
- `s` → Flash jump

**Shell**
- `Ctrl+R` → Search history (Atuin)
- `Ctrl+T` → Find files (fzf)

## Modern CLI Tools

All Rust-based for maximum performance:

```bash
ls      → eza        # Better ls with git integration
cat     → bat        # Syntax highlighting
find    → fd         # Simpler, faster
grep    → ripgrep    # Faster, smarter
cd      → zoxide     # Smart cd with frecency
top     → bottom     # Better system monitor
du      → dust       # Visual disk usage
df      → duf        # Colorful disk free
sed     → sd         # Simpler syntax
```

## Benchmarks

```bash
# Shell startup
zsh-bench          # Should be <50ms

# Neovim startup
nvim --startuptime /tmp/nvim-startup.log +q && cat /tmp/nvim-startup.log
```

## Post-Installation

### First Time Setup

1. **Restart your shell**
   ```bash
   exec zsh
   ```

2. **Configure Git**
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   ```

3. **Open Neovim** - Plugins install automatically
   ```bash
   nvim
   ```

4. **Try Zellij**
   ```bash
   zellij  # or alias: z
   ```

5. **Set up Atuin** (optional sync)
   ```bash
   atuin register
   atuin sync
   ```

### Language Tools (Mise)

```bash
# Install Node.js
mise install node@20
mise use -g node@20

# Install Python
mise install python@3.12
mise use -g python@3.12

# Install Go
mise install go@latest
mise use -g go@latest

# List installed
mise ls

# List available versions
mise ls-remote node
```

## Customization

### Theme

All tools use Catppuccin Macchiato. To change:
- Ghostty: Edit `ghostty/.config/ghostty/config`
- Zellij: Edit `zellij/.config/zellij/config.kdl`
- Neovim: Edit `nvim/.config/nvim/lua/plugins/theme.lua`
- Starship: Edit `starship/.config/starship.toml`

### Plugins

**Zsh**: Edit `zsh/.zsh_plugins.txt`
**Neovim**: Add files to `nvim/.config/nvim/lua/plugins/`

### Aliases

Edit `zsh/.zshrc` - look for the "Aliases" section.

## Cleanup & Uninstall

To remove dotfiles configurations:

```bash
# Run cleanup script
sh ./scripts/cleanup.sh
```

The cleanup script will:
- Unstow all configurations (interactive)
- Remove cache files and generated data
- Optionally uninstall Homebrew packages
- Clean up shell and editor state

**Note**: This is interactive and safe - you'll be prompted for each step.

## Troubleshooting

### Zsh plugins not loading
```bash
# Regenerate plugin bundle
antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.zsh
```

### Slow shell startup
```bash
# Enable profiling in .zshrc
zmodload zsh/zprof
# ... (at end of .zshrc)
zprof
```

### Neovim plugins not working
```bash
# In Neovim
:Lazy sync
:checkhealth
```

### Starship not showing
```bash
# Check if starship is in PATH
which starship

# Reinstall
brew reinstall starship
```

## What's Different from Traditional Setups?

### No Oh My Zsh
- OMZ adds 100-200ms to shell startup
- Antidote loads plugins in parallel, much faster
- Manual configuration gives you full control

### Mise instead of asdf
- Written in Rust (asdf is bash - slow)
- Drop-in replacement, same commands
- Faster tool installation and switching

### Zellij instead of Tmux
- More intuitive UI and keybindings
- Better defaults
- Written in Rust, actively developed
- No conflicts with Neovim by using Alt keys

### Modern CLI Tools
- All Rust-based: faster, safer, better UX
- eza, bat, fd, rg, zoxide, delta - all provide better output and performance
- But kept compatible (aliases maintain familiar commands)

## Performance Targets

- ✅ Zsh startup: <50ms
- ✅ Neovim startup: <100ms
- ✅ Starship prompt: <10ms
- ✅ All tools: Instant response

## Credits

Built on the shoulders of giants:
- [LazyVim](https://www.lazyvim.org/)
- [Starship](https://starship.rs/)
- [Atuin](https://atuin.sh/)
- [Catppuccin](https://catppuccin.com/)
- All the amazing Rust CLI tools

## License

MIT - Feel free to use and modify!
