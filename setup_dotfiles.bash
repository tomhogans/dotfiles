echo "Setting up vim and plugins..."
mkdir -p ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp config/vimrc ~/.vimrc

echo "Configuring git..."
git config --global alias.st status
git config --global alias.br branch
git config --global alias.co checkout

echo "Installing and configuring oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp config/zshrc ~/.zshrc

echo "Dotfiles configuration complete."
