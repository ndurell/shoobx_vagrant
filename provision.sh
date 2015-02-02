#!/usr/bin/env bash

echo "copying your ssh config to the vagrant instance."

echo "backing up existing /etc/apt/sources.list"
cp /etc/apt/sources.list /etc/apt/sources.list.bkp

echo "updating apt sources with working rabbitmq."
(echo 'deb http://www.rabbitmq.com/debian/ testing main'; cat /etc/apt/sources.list) >/etc/apt/sources.list.new
mv /etc/apt/sources.list{.new,}

echo "adding rabbitmq repo key"
wget https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo apt-key add rabbitmq-signing-key-public.asc

echo "installing extra dependencies."
echo "we need python-lxml to install lxml"
# apt-get update
# apt-get -y install  git keychain

# unclear if needed 
# echo "installing lxml dependencies"
apt-get build-dep python-lxml

echo "making local var directory"
mkdir /opt/shoobx/var

# link to local var from within shared folder
echo "making symlink from shared folder to local var dir"
ln -s /opt/shoobx/var /opt/shoobx/shoobx.app/var

echo "add dev.shoobx.com key to known_hosts"
ssh-keyscan -H dev.shoobx.com >> .ssh/known_hosts
chown vagrant:vagrant .ssh/known_hosts

# uncomment below to get zsh
# echo "adding zsh shell"
# sudo apt-get install zsh
# wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh 
# sudo chsh -s /bin/zsh vagrant
# zsh