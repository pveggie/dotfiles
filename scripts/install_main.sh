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

install_ruby() {
  './scripts/install_ruby.sh'
}

install_postgresql()
{
  sudo apt-get install -y postgresql postgresql-contrib libpq-dev build-essential
  echo `whoami` > /tmp/caller
  sudo su - postgres
  psql --command "CREATE ROLE `cat /tmp/caller` LOGIN createdb;"
  exit
  rm -f /tmp/caller
}

#!/bin/zsh

# Symlinks
echo "Creating symlinks for dotfiles"
for name in *; do
  if [ ! -d "$name" ]; then
    target="$HOME/.$name"
    if [[ ! "$name" =~ '\.sh$' ]] && [ "$name" != 'README.md' ]; then
      backup $target

      if [ ! -e "$target" ]; then
        echo "-----> Symlinking your new $target"
        ln -s "$PWD/$name" "$target"
      fi
    fi
  fi
done

# Create link for backgrounds in pictures folder
ln -s "$PWD/backgrounds" ~/Pictures

#Install utlities
if exists git; then
  echo "git is installed"
else
  echo "Installing git"
  sudo apt-get install -y git
fi

sudo apt-get install unetbootin git-gui gitk kolourpaint4 pinta calibre ubuntu-make inkscape gimp chromium-browser

# Install sublime if not already installed
if exists subl; then
  echo "Sublime is already installed"
else
  echo "Installing Sublime Text 3"
  sudo add-apt-repository ppa:webupd8team/sublime-text-3
  sudo apt-get update
  sudo apt-get install -y sublime-text-installer
  echo "Sublime Text 3 Installed"
fi

# Install Webstorm if not already installed
if exists webstorm; then
  echo "Webstorm is already installed"
else
  echo "Downloading Webstorm"
  mkdir ~/temp
  cd ~/temp
  curl -OL "https://download.jetbrains.com/webstorm/WebStorm-2017.1.3.tar.gz"
  tar -xf ./WebStorm*tar.gz
  mv WebStorm-2017.1.3.tar.gz old
  mv WebStorm* WebStorm
  cd WebStorm/bin
  './webstorm.sh'
  cd ~
  rm -rf ~/temp
  echo "WebStorm installed"
fi

# Set-up SSH
mkdir -p ~/.ssh && ssh-keygen -t rsa -C "pveggie@hotmail.com"
cat ~/.ssh/id_rsa.pub
echo "Copy the code above to a new SSH Key on GitHub: github.com/settings/ssh"
echo -n "Press 'y' to continue\n"

REPLY="n"
until [ $REPLY = "y" ]; do
  read REPLY
done

ssh -T git@github.com
echo "You should see a message that reads Hi --------! You've successfully authenticated, but GitHub does not provide shell access. If not try ssh-add ~/.ssh/id_rsa then run the ssh -T command again"

# Install ruby
if exists ruby; then
  echo "Ruby already installed. Do you want to remove current version and reinstall? (y/n)"
  read rubyinstall
  if [ $rubyinstall = "y" ]; then
    install_ruby
  fi
else
  install_ruby
fi

# Install PostgreSQL
if exists psql; then
  echo "PostgreSQL is already installed. Do you want to remove current version and reinstall? (y/n)"
  read pginstall
  if [ $pginstall = "y" ]; then
    install_postgresql
  fi
else
  install_postgresql
fi

REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"

./install_zsh_plugins.sh

