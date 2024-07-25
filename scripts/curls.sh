echo 'Installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo 'Installing Kitty'
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
