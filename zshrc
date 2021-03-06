ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"

RPS1='[$(ruby_prompt_info)]$EPS1'  # Add ruby version on prompt (float right)
COMPLETION_WAITING_DOTS="true"
plugins=(gitfast brew rbenv last-working-dir common-aliases history-substring-search zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

export RBENV_ROOT=$HOME/.rbenv
export PATH="${RBENV_ROOT}/bin:${PATH}"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="./bin:${PATH}"

[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Android SDK
export ANDROID_HOME=/home/gemma/.local/share/umake/android/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

###Phantom JS

export PATH="/usr/local/share/phantomjs/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

