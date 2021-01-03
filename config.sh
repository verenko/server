#!/bin/bash
username="sammy"
password="qwertyui"
ip_template="localhost"

apt update
#apt upgrade -y

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
chown $username:$username /home/$username/ftp/files
rm /etc/vsftpd.conf
cp /root/server/conf /etc
service vsftpd restart

#ssh config
rm /etc/ssh/sshd_config
cp /root/server/sshd_config /etc/ssh/
service ssh restart





#LEMP
apt update 
apt install nginx -y
apt install mysql-server -y
apt install php7.4-fpm php7.4-mysql -y
apt install php7.4-mbstring -y
mysql_secure_installation
apt install phpmyadmin -y




sed -i "s~ip_template_place~$ip_template~g" /root/server/nginx.conf
rm /etc/nginx/nginx.conf
cp /root/server/nginx.conf /etc/nginx/nginx.conf



#zsh install
apt-get install zsh -y
apt-get install git-core -y
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

cp -r /root/.oh-my-zsh /home/$username
cp /root/server/.zshrc /home/$username

chown $username:$username /home/$username/.zshrc
