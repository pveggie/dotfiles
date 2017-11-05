#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}


# Go to home directory
cd ~

# Install zsh
if exists zsh; then
  echo "zsh is already installed"
else
  echo "Installing zsh"
  sudo apt-get install -y git zsh curl vim imagemagick jq
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
fi

cd ~/code/pveggie/dotfiles
./scripts/install_main.sh
