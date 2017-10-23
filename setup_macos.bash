#!/bin/sh

echo "Installing Homebrew..."

if which brew 2>/dev/null 1>/dev/null; then
    echo "Homebrew already installed."
else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing Homebrew software..."

# Install from Brewfile
brew bundle

echo "Finalizing Homebrew configuration..."

brew update
brew upgrade
brew cleanup
brew cask cleanup
brew analytics off

echo "Configuring macOS settings..."

bash macos_defaults.bash
