# Keybinding Reference

The default stack keeps layers separate:

- **Ghostty**: `Cmd` for terminal tabs, windows, and clipboard actions.
- **tmux**: `Ctrl+a` prefix for panes, windows, status, and sessions.
- **Neovim**: `Space` leader plus `Ctrl` combinations.
- **Shell**: `Ctrl`/`Alt` bindings for history, words, and fzf widgets.

## Ghostty

### Window And Tab Management

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

## tmux

Prefix: `Ctrl+a`

### Core

- `prefix + r` - Reload `~/.tmux.conf`
- `prefix + Ctrl+a` - Send prefix to nested tmux/session
- `prefix + c` - New window
- `prefix + ,` - Rename window
- `prefix + &` - Kill window
- `prefix + d` - Detach
- `prefix + [` - Copy mode

### Pane Navigation

- `prefix + h` - Select pane left
- `prefix + j` - Select pane down
- `prefix + k` - Select pane up
- `prefix + l` - Select pane right

### Pane Resize

- `prefix + H` - Resize left by 5
- `prefix + J` - Resize down by 5
- `prefix + K` - Resize up by 5
- `prefix + L` - Resize right by 5

### Plugins

- `prefix + I` - Install TPM plugins
- `prefix + U` - Update TPM plugins
- `prefix + Alt+u` - Clean removed TPM plugins

## Neovim

### Leader

- `Space` - Leader key

### File Navigation

- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fr` - Recent files
- `<leader>e` - File explorer

### Harpoon

- `<leader>a` - Add file
- `<leader>h` - Toggle menu
- `<leader>1-4` - Jump to Harpoon file 1-4
- `Ctrl+Shift+P` - Previous Harpoon file
- `Ctrl+Shift+N` - Next Harpoon file

### Flash

- `s` - Flash jump
- `S` - Flash treesitter
- `r` - Remote flash in operator mode
- `R` - Treesitter search
- `Ctrl+S` - Toggle Flash search in command mode

### Windows

- `Ctrl+H` - Left window
- `Ctrl+J` - Down window
- `Ctrl+K` - Up window
- `Ctrl+L` - Right window
- `Ctrl+Down` - Decrease window width
- `Ctrl+Up` - Increase window width

### LSP

- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>cf` - Format buffer

### Git

- `]c` - Next hunk
- `[c` - Previous hunk
- `<leader>gs` - Stage hunk
- `<leader>gr` - Reset hunk
- `<leader>gS` - Stage buffer
- `<leader>gp` - Preview hunk
- `<leader>gb` - Blame line
- `<leader>gd` - Diff this
- `<leader>gv` - Open Diffview
- `<leader>gc` - Close Diffview
- `<leader>gh` - File history
- `<leader>gH` - Project history

### Diagnostics

- `<leader>xx` - Toggle diagnostics
- `<leader>xX` - Buffer diagnostics
- `<leader>cs` - Symbols
- `<leader>cl` - LSP definitions/references
- `<leader>xL` - Location list
- `<leader>xQ` - Quickfix list

### Terminal And Tabs

- `Ctrl+/` - Toggle terminal
- `Ctrl+\` - New terminal
- `<leader><tab><tab>` - New tab
- `<leader><tab>]` - Next tab
- `<leader><tab>[` - Previous tab
- `<leader><tab>d` - Close tab

## Shell

### FZF

- `Ctrl+T` - File search
- `Alt+C` - Directory search

### Line Editing

- `Option+Left` - Backward word
- `Option+Right` - Forward word
- `Option+Up` - Previous history line
- `Option+Down` - Next history line
- `Cmd+Left` - Beginning of line
- `Cmd+Right` - End of line

### zoxide

- `cd <partial>` - Jump by frecency
- `cd -` - Previous directory

## Common Workflows

### Multiple Files

1. Add files to Harpoon with `<leader>a`.
2. Jump with `<leader>1`, `<leader>2`, `<leader>3`, or `<leader>4`.
3. Use `<leader>h` when you need the menu.

### Git

1. Stage hunks with `<leader>gs`.
2. Preview changes with `<leader>gp`.
3. Open Lazygit with `<leader>gg`.
4. Inspect history with `<leader>gh`.

### Panes

1. Use Neovim splits for code layout.
2. Use tmux panes for separate tasks such as editor, server, logs, and shell.
3. Use `prefix + h/j/k/l` for tmux panes and `Ctrl+H/J/K/L` for Neovim windows.
