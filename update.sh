#!/bin/sh

PLATFORM_NAME=`uname`

if [ "$PLATFORM_NAME" == "Darwin" ]; then
    echo "Detected MacOS install, proceeding with MacOS setup..."
    #bash setup_macos.bash
    sh -c "$(https://raw.githubusercontent.com/tomhogans/dotfiles/master/setup_macos.bash)"

else
    echo "Detected Linux install, proceeding with Ubuntu setup..."
    sh -c "$(https://github.com/tomhogans/dotfiles/blob/master/setup_ubuntu.bash)"
fi

# pip libraries (ipython, flake8 etc)
pip3 install -r requirements.txt

# dotfiles (gitconfig, vim, tmux)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tomhogans/dotfiles/master/setup_dotfiles.bash)"

