#!/bin/sh

PLATFORM_NAME=`uname`

if [ "$PLATFORM_NAME" == "Darwin" ]; then
    echo "Detected MacOS install, proceeding with MacOS setup..."
    bash setup_macos.bash
else
    echo "Detected Linux install, proceeding with Ubuntu setup..."
    bash setup_ubuntu.bash
fi

# pip libraries (ipython, flake8 etc)
pip3 install -r requirements.txt

# dotfiles (gitconfig, vim, tmux)
sh setup_dotfiles.bash
