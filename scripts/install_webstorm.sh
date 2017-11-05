#!/bin/zsh
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
