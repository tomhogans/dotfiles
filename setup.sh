#!/bin/sh

git clone git@github.com:tomhogans/dotfiles.git ~/.dotfiles
export DOTFILES="~/.dotfiles"

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo "Finalizing Homebrew configuration..."
brew update
brew upgrade
brew cleanup
brew analytics off

echo "Configuring git..."
git config --global alias.st status
git config --global pull.rebase false

echo "Setting up vim and plugins..."
rm -rf ~/.vimrc ~/.vim/ ~/.config/nvim/
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s config/vimrc ~/.vimrc
ln -s ~/.vimrc ~/.config/nvim/init.vim

echo "Setting up tmux config..."
ln -s config/tmux.conf ~/.tmux.conf

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s config/zshrc ~/.zshrc

PLATFORM_NAME=`uname`

if [ "$PLATFORM_NAME" == "Darwin" ]; then
	echo "Configuring macOS settings..."

	## Set key repeat keyboard settings
	defaults write NSGlobalDomain KeyRepeat -int 2
	defaults write NSGlobalDomain InitialKeyRepeat -int 15

	## Expand save panel by default
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

	## Hide icons for hard drives, servers, and removable media on the desktop
	defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
	defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
	defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
	defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

	## Finder: show all filename extensions
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	## Disable the warning when changing a file extension
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

	## Show the ~/Library folder
	chflags nohidden ~/Library

	## Don’t automatically rearrange Spaces based on most recent use
	defaults write com.apple.dock mru-spaces -bool false

	## Enable Safari’s debug menu
	defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

	## Enable the Develop menu and the Web Inspector in Safari
	defaults write com.apple.Safari IncludeDevelopMenu -bool true
	defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
	defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

	## Add a context menu item for showing the Web Inspector in web views
	defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

	# Change screenshot capture folder to ~/Downloads
	defaults write com.apple.screencapture location ~/Downloads

else

	# Needed for apt-add-repository
	sudo apt-get install -y software-properties-common python-software-properties

	sudo apt-get -y update

	sudo apt-get install -y python3 python3-dev python3-pip libpq-dev

	sudo apt-get install -y vim
	sudo apt-get install -y tmux
	sudo apt-get install -y ctags
	sudo apt-get install -y wget
	sudo apt-get install -y curl
	sudo apt-get install -y htop
	sudo apt-get install -y postgresql
	sudo apt-get install -y tree
	sudo apt-get install -y jq

fi
