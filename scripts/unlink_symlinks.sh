#!/bin/zsh
echo "Unlinking symlinks for dotfiles"
for name in *; do
  if [ ! -d "$name" ]; then
    target="$HOME/.$name"
    if [[ ! "$name" =~ '\.sh$' ]] && [ "$name" != 'README.md' ]; then

      if [ ! -e "$target" ]; then
 	echo "-----> Unlinking your $target"
	unlink "$target"
      fi
    fi
  fi
done

# Create link for backgrounds in pictures folder
unlink ~/Pictures
