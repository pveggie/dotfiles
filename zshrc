ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
RPS1='[$(ruby_prompt_info)]$EPS1'  # Add ruby version on prompt (float right)
COMPLETION_WAITING_DOTS="true"
plugins=(gitfast brew rbenv last-working-dir common-aliases sublime history-substring-search zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

export RBENV_ROOT=$HOME/.rbenv
export PATH="${RBENV_ROOT}/bin:${PATH}"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="./bin:${PATH}"

[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Android SDK
export ANDROID_HOME=/home/gemma/.local/share/umake/android/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"
