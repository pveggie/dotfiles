exists()
{
  command -v "$1" >/dev/null 2>&1
}

install_rbenv()
{
  echo "Removing any instance of rvm"
  rvm implode && sudo rm -rf ~/.rvm

  echo "Removing any instance of rbenv"
  rm -rf ~/.rbenv

  echo "Installing Required libraries"
  sudo apt-get install -y build-essential tklib zlib1g-dev libssl-dev libffi-dev libxml2 libxml2-dev libxslt1-dev libreadline-dev
  sudo apt-get clean
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src

  if [[ `uname` =~ "darwin" ]]; then
    echo "Quit your terminal and restart it (⌘ + Q)."
  else
    echo "Quit your terminal and restart it (Alt + F4)."
  fi
}

install_ruby_build()
{
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
}

if exists rbenv; then
  echo "rbenv is already installed. reinstall? (y/n)"
  read rbenv_install
  if [ $rbenv_install = "y" ]; then
    install_rbenv
  fi
else
  install_rbenv
fi

if exists 'rbenv install'; then
  echo "Ruby build is installed./n"
  echo "Installing ruby. This will take a long, long time."
else
  install_ruby_build
fi

rbenv install 2.3.3
rbenv global 2.3.3
ruby -v
gem install bundler rspec rubocop pry pry-byebug hub colored gist haar_joke
