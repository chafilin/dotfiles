echo "Installing node version manager"
read -p "Do you want to install node version manager? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

echo "Installing pnpm"
read -p "Do you want to install pnpm? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install pnpm
fi

echo "Installing rbenv"
read -p "Do you want to install rbenv? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  brew install rbenv
fi

echo "Installing rust"
read -p "Do you want to install rust? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
