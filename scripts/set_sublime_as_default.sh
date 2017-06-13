#!/bin/zsh
setopt nocasematch
if [[ ! `uname` =~ "darwin" ]]; then
  git config --global core.editor "subl -n -w $@ >/dev/null 2>&1"
  echo 'export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"' >> zshrc
else
  git config --global core.editor "'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' -n -w"
  bundler_editor="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'"
  echo "export BUNDLER_EDITOR=\"${bundler_editor}\"" >> zshrc
fi
