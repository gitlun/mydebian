#!/bin/bash
# mydebian setup
if [ `whoami` = "root" ];then
	echo "Start"
else
	echo "Please switch to 'root'"
	exit
fi
mkdir /dska
mkdir /dska/tmp
LOG_FILE="/dska/tmp/mydebian.log"
>"${LOG_FILE}"
exec &> >(tee "$LOG_FILE")
set -x
echo -e "----------------SETBASE--------------------------\n"

echo "######Reset to default######"

#mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
#wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/gitlun/mydebian/master/sshd_config

echo "######Update Debian######"
wget -O /tmp/apt.source https://raw.githubusercontent.com/gitlun/mydebian/master/apt.source
cp -f /tmp/apt.source /etc/apt/sources.list
apt update
export DEBIAN_FRONTEND=noninteractive
apt -y full-upgrade
echo -e "######done######\n"

echo "######reconfig locales######"
#sed 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
#locale-gen
#sed 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
echo -e "######done######\n"

echo -e "----------------SETPROJECT--------------------------\n"
echo "######Install sudo######"
apt -y install sudo
echo -e "######done######\n"

echo "######Install webserver######"

#echo "deb http://nginx.org/packages/stable/debian stretch nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
#curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
apt -y install nginx
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
nvm install --lts
npm install pm2 -g

echo -e "######done######\n"

echo "######Install sql######"

apt -y install redis postgresql

echo -e "######done######\n"

echo "######Install docker######"
apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common lsb-release

curl -fsSL http://mirrors.cloud.tencent.com/docker-ce/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] http://mirrors.cloud.tencent.com/docker-ce/linux/debian $(lsb_release -cs) stable"

apt update
apt -y install docker-ce docker-ce-cli containerd.io

echo -e "######done######\n"

echo "######Install extrs######"

echo "######Install xfce4######"
apt -y install xfce4 xfce4-goodies lightdm-gtk-greeter-settings
systemctl set-default multi-user.target
echo -e "######done######\n"

echo "######Install vnc######"
apt -y install tigervnc-standalone-server
echo -e "######done######\n"

echo "######Install font######"
apt -y install fonts-wqy-microhei fonts-wqy-zenhei xfonts-wqy
echo -e "######done######\n"

echo "######Install fcitx######"
apt -y install fcitx fcitx-sunpinyin
echo -e "######done######\n"

echo "######Install extrsoft######"
apt -y install firefox-esr openjdk-11-jre-headless
echo -e "######done######\n"

echo "######Install netdata######"
apt -y install netdata --no-install-recommends
echo -e "######done######\n"

echo -e "----------------CLEAN--------------------------\n"
echo "######Clean######"
apt -y autoremove
apt autoclean
echo -e "######done######\n"

#docker run -p 9760:9000 --name hi0580php -v /dska/www/hi0580:/var/www/html -v /dska/www/phpconf:/usr/local/etc/php -d hi0580php:1.0
#docker run --name hi0580db -v /dska/www/mysql:/var/lib/mysql -v /dska/www/mysqlbak:/var/www/mysqlbak -e MYSQL_ROOT_PASSWORD=... -d mysql:5.7
#
#echo -e "----------------INSTALL EXTR--------------------------\n"
#echo "######Dbeaver######"
#wget -O /tmp/dbeaver.tar.a http://m.mai0580.com/client/theme/sg/cn/mob/extr/dbeaver.tar.a
#wget -O /tmp/dbeaver.tar.b http://m.mai0580.com/client/theme/sg/cn/mob/extr/dbeaver.tar.b
#wget -O /tmp/dbeaver.tar.c http://m.mai0580.com/client/theme/sg/cn/mob/extr/dbeaver.tar.c
#cd /tmp
#cat dbeaver.tar.* | tar xzvf - 
#dpkg -i ./dbeaver-ce_5.3.5_amd64.deb
#cd
#echo -e "######done######\n"

#scp apt.source lun@192.168.1.126:/tmp
#ftp upload weixinsql.zip
#ftp upload hi0580php.1.0.tar and load
#ftp upload weixin.zip and release
#ftp upload Dbeaver and install

#ftp upload www.mai0580 & www.souboat
