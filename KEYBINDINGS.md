# Keybinding Reference

This document outlines all keybindings across the stack to ensure no conflicts between tools.

## Design Philosophy

- **Zellij**: All `Alt` (Option) key combinations
- **Neovim**: `Space` leader + `Ctrl` combinations
- **Ghostty**: `Cmd` (macOS) combinations for terminal operations
- **No conflicts**: Each layer uses distinct modifier keys

---

## Ghostty Terminal

All terminal-level keybindings use `Cmd` (macOS):

### Window/Tab Management
- `Cmd+T` - New tab
- `Cmd+W` - Close tab/window
- `Cmd+N` - New window
- `Cmd+1-9` - Switch to tab 1-9

### Text Operations
- `Cmd+C` - Copy
- `Cmd+V` - Paste
- `Cmd+K` - Clear screen
- `Cmd+Backspace` - Delete to start of line
- `Opt+Backspace` - Delete word backward
- `Shift+Enter` - Send literal Enter

### View
- `Cmd+Plus` - Increase font size
- `Cmd+Minus` - Decrease font size
- `Cmd+0` - Reset font size

---

## Zellij Multiplexer

**ALL keybindings use `Alt` (Option) modifier** - no conflicts with Neovim!

### Mode Switching
- `Alt+G` - Lock mode (pass keys to terminal)
- `Alt+P` - Pane mode
- `Alt+T` - Tab mode
- `Alt+R` - Resize mode
- `Alt+S` - Scroll mode
- `Alt+M` - Move mode
- `Alt+O` - Session mode
- `Alt+Q` - Quit

### Quick Actions (from any mode)
- `Alt+N` - New pane
- `Alt+H/J/K/L` - Navigate panes (vim-style)
- `Alt+Left/Right` - Navigate panes/tabs
- `Alt+[` - Previous swap layout
- `Alt+]` - Next swap layout

### Pane Mode (`Alt+P` then...)
- `N` - New pane
- `J` - New pane down
- `L` - New pane right
- `X` - Close pane
- `F` - Toggle fullscreen
- `E` - Toggle embed/float
- `Z` - Toggle pane frames
- `W` - Toggle floating panes
- `R` - Rename pane
- `C` - Clear pane

### Tab Mode (`Alt+T` then...)
- `N` - New tab
- `X` - Close tab
- `R` - Rename tab
- `H/L` - Move tab left/right
- `1-9` - Go to tab 1-9
- `B` - Break pane to new tab

### Resize Mode (`Alt+R` then...)
- `H/J/K/L` - Resize pane (vim-style)
- `Left/Down/Up/Right` - Resize pane (arrows)

### Scroll Mode (`Alt+S` then...)
- `J/K` - Scroll down/up
- `D` - Half page down
- `U` - Half page up
- `PageDown/PageUp` - Page scroll
- `Home/End` - Scroll to top/bottom
- `S` - Enter search

### Session Mode (`Alt+O` then...)
- `D` - Detach session
- `W` - Session manager (floating)

---

## Neovim (LazyVim)

Uses `Space` as leader and `Ctrl` combinations - **no Alt keys!**

### Leader Key
- `Space` - Leader key (all commands below start with Space)

### File Navigation
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep (Telescope)
- `<leader>fb` - Find buffers (Telescope)
- `<leader>fr` - Recent files (Telescope)
- `<leader>e` - File explorer (Neo-tree)

### Harpoon (Quick File Bookmarks)
- `<leader>a` - Add file to harpoon
- `<leader>h` - Toggle harpoon menu
- `<leader>1-4` - Jump to harpoon file 1-4
- `Ctrl+Shift+P` - Previous harpoon file
- `Ctrl+Shift+N` - Next harpoon file

### Flash (Jump Navigation)
- `s` - Flash jump (normal/visual/operator mode)
- `S` - Flash treesitter (structure-aware)
- `r` - Remote flash (operator mode)
- `R` - Treesitter search
- `Ctrl+S` - Toggle flash search (command mode)

### Window Navigation (Vim-style)
- `Ctrl+H` - Left window
- `Ctrl+J` - Down window
- `Ctrl+K` - Up window
- `Ctrl+L` - Right window
- **Works with Zellij panes via Alt+H/J/K/L!**

### LSP
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>cf` - Format buffer (Conform)

### Git (Gitsigns)
- `]c` - Next git hunk
- `[c` - Previous git hunk
- `<leader>gs` - Stage hunk
- `<leader>gr` - Reset hunk
- `<leader>gS` - Stage buffer
- `<leader>gp` - Preview hunk
- `<leader>gb` - Blame line
- `<leader>gd` - Diff this

### Git (Diffview)
- `<leader>gv` - Open diffview
- `<leader>gc` - Close diffview
- `<leader>gh` - File history
- `<leader>gH` - Project history

### Trouble (Diagnostics)
- `<leader>xx` - Toggle diagnostics
- `<leader>xX` - Buffer diagnostics
- `<leader>cs` - Symbols
- `<leader>cl` - LSP definitions/references
- `<leader>xL` - Location list
- `<leader>xQ` - Quickfix list

### Terminal
- `Ctrl+/` - Toggle terminal
- `Ctrl+\` - New terminal

### Tabs
- `<leader><tab>l` - Last tab
- `<leader><tab>f` - First tab
- `<leader><tab><tab>` - New tab
- `<leader><tab>]` - Next tab
- `<leader><tab>[` - Previous tab
- `<leader><tab>d` - Close tab

### Miscellaneous
- `<leader>qq` - Quit all
- `<leader>gg` - Lazygit
- `<leader>l` - Lazy (plugin manager)
- `<leader>:` - Command history

---

## Shell (Zsh)

### History (Atuin)
- `Ctrl+R` - Search history (Atuin fuzzy search)
- `Up Arrow` - Normal history (Atuin disabled for up)

### FZF
- `Ctrl+T` - File search
- `Ctrl+R` - Command history (if Atuin not available)
- `Alt+C` - Directory search

### Zoxide
- `cd <partial>` - Smart cd with frecency
- `cd -` - Previous directory

---

## Summary Table

| Tool | Modifier Keys | Purpose |
|------|--------------|---------|
| **Ghostty** | `Cmd` | Terminal window/tab management |
| **Zellij** | `Alt` | Multiplexer (panes, tabs, sessions) |
| **Neovim** | `Space`, `Ctrl` | Editor, LSP, file navigation |
| **Shell** | `Ctrl` | History, fuzzy finding |

## Conflict Resolution

✅ **No conflicts!** Each tool uses distinct modifier keys:
- Terminal operations: `Cmd` (macOS only)
- Multiplexer: `Alt` (Option) exclusively
- Editor: `Space` leader + `Ctrl` keys
- Navigation works seamlessly: `Ctrl+H/J/K/L` in Neovim, `Alt+H/J/K/L` in Zellij

## Tips

1. **In Neovim**: Use `Ctrl+H/J/K/L` to navigate windows
2. **In Zellij**: Use `Alt+H/J/K/L` to navigate panes
3. **Muscle Memory**:
   - Need to do something in the terminal multiplexer? Think `Alt`
   - Need to do something in the editor? Think `Space` or `Ctrl`
   - Need terminal tab/window? Think `Cmd` (macOS)

4. **Zellij Lock Mode**: Press `Alt+G` to lock Zellij and pass all keys through to the terminal/Neovim. This is useful when you need all keybindings to go to the application.

## Common Workflows

### Working with Multiple Files
1. Add files to Harpoon: `<leader>a`
2. Switch between them: `<leader>1`, `<leader>2`, etc.
3. Or use `<leader>h` to see the menu

### Git Workflow
1. Stage hunks as you go: `<leader>gs`
2. Preview changes: `<leader>gp`
3. Open Lazygit for complex operations: `<leader>gg`
4. View file history: `<leader>gh`

### Pane/Window Management
1. **In Neovim**: Split with `:split` or `:vsplit`, navigate with `Ctrl+H/J/K/L`
2. **In Zellij**: `Alt+P` then `J` or `L` for new panes, navigate with `Alt+H/J/K/L`
3. **Best Practice**: Use Neovim splits for code, Zellij panes for different tasks (editor, terminal, logs)
