curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

brew install rbenv

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

brew install pipx
pipx ensurepath
sudo pipx ensurepath --global
