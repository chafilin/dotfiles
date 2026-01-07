echo 'Installing brew'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if ! command -v brew >/dev/null 2>&1; then
  echo "Error: Homebrew installation failed or 'brew' is not available on PATH." >&2
  exit 1
fi
echo 'Installing essential tools...'
brew install git
brew install stow

echo 'Installing shell tools...'
brew install antidote        # Fast zsh plugin manager
brew install starship        # Modern prompt
brew install atuin          # Modern shell history

echo 'Installing modern CLI replacements (Rust-based)...'
brew install eza            # Modern ls
brew install bat            # Modern cat
brew install fd             # Modern find
brew install ripgrep        # Modern grep
brew install sd             # Modern sed
brew install zoxide         # Smart cd
brew install bottom         # Modern top
brew install procs          # Modern ps
brew install dust           # Modern du
brew install duf            # Modern df

echo 'Installing terminal & multiplexer...'
brew install --cask ghostty  # Modern terminal
brew install zellij         # Modern multiplexer

echo 'Installing development tools...'
brew install neovim
brew install fzf
brew install gh
brew install direnv         # Environment management
brew install mise           # Modern asdf alternative

echo 'Installing Git tools...'
brew install git-delta      # Beautiful git diffs
brew install jesseduffield/lazygit/lazygit
brew install git-absorb     # Auto fixup commits
brew install jesseduffield/lazydocker/lazydocker

echo 'Installing productivity tools...'
brew install httpie         # Modern curl
brew install jq             # JSON processor
brew install yq             # YAML processor
brew install glow           # Markdown renderer
brew install tlrc           # Modern man pages
