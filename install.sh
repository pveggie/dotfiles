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

install_ruby()
{
  rvm implode && sudo rm -rf ~/.rvm
  rm -rf ~/.rbenv
  sudo apt-get install -y build-essential tklib zlib1g-dev libssl-dev libffi-dev libxml2 libxml2-dev libxslt1-dev libreadline-dev
  sudo apt-get clean
  sudo mkdir -p /usr/local/opt && sudo chown `whoami`:`whoami` $_
  git clone https://github.com/rbenv/rbenv.git /usr/local/opt/rbenv
  git clone https://github.com/rbenv/ruby-build.git /usr/local/opt/rbenv/plugins/ruby-build
  exec zsh

  rbenv install 2.3.3
  rbenv global 2.3.3
  ruby -v
  gem install bundler rspec rubocop pry pry-byebug hub colored gist haar_joke
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

#!/bin/zsh

#Install utlities
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

REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"

# zsh plugins
CURRENT_DIR=`pwd`
ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$ZSH_PLUGINS_DIR" && cd "$ZSH_PLUGINS_DIR"
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
  echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
  git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
fi
cd "$CURRENT_DIR"

setopt nocasematch
if [[ ! `uname` =~ "darwin" ]]; then
  git config --global core.editor "subl -n -w $@ >/dev/null 2>&1"
  echo 'export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"' >> zshrc
else
  git config --global core.editor "'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' -n -w"
  bundler_editor="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'"
  echo "export BUNDLER_EDITOR=\"${bundler_editor}\"" >> zshrc
fi

# Sublime Text
if [[ ! `uname` =~ "darwin" ]]; then
  SUBL_PATH=~/.config/sublime-text-3
else
  SUBL_PATH=~/Library/Application\ Support/Sublime\ Text\ 3
fi
mkdir -p $SUBL_PATH/Packages/User $SUBL_PATH/Installed\ Packages
backup "$SUBL_PATH/Packages/User/Preferences.sublime-settings"
curl https://sublime.wbond.net/Package%20Control.sublime-package > $SUBL_PATH/Installed\ Packages/Package\ Control.sublime-package
ln -s $PWD/Preferences.sublime-settings $SUBL_PATH/Packages/User/Preferences.sublime-settings
ln -s $PWD/Package\ Control.sublime-settings $SUBL_PATH/Packages/User/Package\ Control.sublime-settings

zsh ~/.zshrc

if [[ `uname` =~ "darwin" ]]; then
  echo "Quit your terminal and restart it (⌘ + Q)."
else
  echo "Quit your terminal and restart it (Alt + F4)."
fi
