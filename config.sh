#!/bin/bash
username="sammy"
password="test"

apt update
apt upgrade -y

apt install vim -y
apt-get install vsftpd -y

useradd -m sammy

pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -m -p "$pass" "$username"

mkdir /home/$username/ftp
chown nobody:nogroup /home/$username/ftp

#zsh install
apt-get install zsh -y
apt-get install git-core -y
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

cp -r .oh-my-zsh /home/$username
cp /root/server/.zshrc /home/$username

chown $username:$username /home/$username/.zshrc
