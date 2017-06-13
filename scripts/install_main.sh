#!/bin/zsh

exists()
{
  command -v "$1" >/dev/null 2>&1
}

create_symlinks() {
  './scripts/create_symlinks.sh'
}

install_utilities() {
  './scripts/install_utilities.sh'
}

install_sublime() {
  './scripts/install_sublime.sh'
}

install_webstorm() {
  './scripts/install_webstorm.sh'
}

install_ruby() {
  './scripts/install_ruby.sh'
}

install_postgresql()
{
  './scripts/install_postgresql.sh'
}

install_zsh_plugins() {
  './scripts/install_zsh_plugins.sh'
}

set_sublime_as_default() {
  './scripts/set_sublime_as_default.sh'
}

setup_sublime() {
  './scripts/setup_sublime.sh'
}

#Install git
if exists git; then
  echo "git is installed"
else
  echo "Installing git"
  sudo apt-get install -y git
fi

# Symlinks
create_symlinks

#Install utlities
echo "Do you want to install utilities? (y/n)"
read utilities_install
if [[ $utilities_install = "y" ]]; then
  install_utilities
fi

#Install sublime if not already installed
if exists subl; then
  echo "Sublime is already installed"
else
  install_sublime
fi

#Install Webstorm if not already installed
if exists webstorm; then
  echo "Webstorm is already installed"
else
  install_webstorm
fi

#Set-up SSH
echo "Do you want to set-up ssh? (y/n)"
read ssh_setup
if [[ $ssh_setup = "y" ]]; then
  setup_ssh
fi

# Install ruby
if exists ruby; then
  echo "Ruby already installed. Do you want to remove current version and reinstall? (y/n)"
  read rubyinstall
  if [[ $rubyinstall = "y" ]]; then
    install_ruby
  fi
else
  install_ruby
fi

# Install PostgreSQL
if exists psql; then
  echo "PostgreSQL is already installed. Do you want to remove current version and reinstall? (y/n)"
  read pginstall
  if [[ $pginstall = "y" ]]; then
    install_postgresql
  fi
else
  install_postgresql
fi

REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"

install_zsh_plugins
set_sublime_as_default
setup_sublime

zsh ~/.zshrc

if [[ `uname` =~ "darwin" ]]; then
  echo "Quit your terminal and restart it (⌘ + Q)."
else
  echo "Quit your terminal and restart it (Alt + F4)."
fi
