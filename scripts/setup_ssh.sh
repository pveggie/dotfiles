#!/bin/zsh
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

