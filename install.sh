echo 'Installing brew'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'Installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo 'Installing brew bundle'
brew bundle install --file ./Brewfile

echo 'Installing oh-my-zsh plugins'
git clone https://github.com/Aloxaf/fzf-tab "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/fzf-tab

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
