backup() {
  target=$1
  if [ -e "$target" ]; then           # Does the config file already exist?
    if [ ! -L "$target" ]; then       # as a pure file?
      mv "$target" "$target.backup"   # Then backup it
      echo "-----> Moved your old $target config file to $target.backup"
    fi
  fi
}

exists()
{
  command -v "$1" >/dev/null 2>&1
}

#!/bin/bash

# Go to home directory
cd ~

# Install zsh
if exists zsh; then
  echo "zsh is already installed"
else
  echo "Installing zsh"
  sudo apt-get install -y zsh curl vim nodejs imagemagick jq
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh > install.sh && bash install.sh && rm install.sh
  # Shutdown to set zsh as default shell
  echo "Machine will now shut down. Once it starts up, zsh will be your default shell"
  sudo shutdown -r 0
fi

cd ~/code/pveggie/dotfiles
./scripts/install_main.sh
