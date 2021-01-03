#!/bin/bash
username="sammy"
password="qwertyui"

apt update
apt upgrade -y

apt install vim -y

#user add
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -m -p "$pass" "$username"

#FTP config
apt-get install vsftpd -y
mkdir /home/$username/ftp
chown nobody:nogroup /home/$username/ftp
chmod a-w /home/$username/ftp

mkdir /home/$username/ftp/files
chown $username:$username /home/alex/ftp/files
rm /etc/vsftpd.conf
cp /root/server/conf /etc
service vsftpd restart



#ssh config
rm /etc/ssh/sshd_config
cp /root/server/sshd_config /etc/ssh/
service ssh restart












#zsh install
apt-get install zsh -y
apt-get install git-core -y
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

cp -r .oh-my-zsh /home/$username
cp /root/server/.zshrc /home/$username

chown $username:$username /home/$username/.zshrc
