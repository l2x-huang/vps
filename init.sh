#!/bin/bash

username=cc
ID_RSA="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKP0TqWHgsiMJ+M8c9XSzZQzQQtpL7cHoNb5cn1CwxRMUxkhwcEmcxbGTy73BV5MRfX1oJxrz1uuB+Ke6JFJTAYF4+S3uO2B67Pw7weaSMMzXBfamxp5iWEU1QDle1iPeDP2tUeSSZ9TxVf3tdioFpU20P8KZTpvHUokvhqFSCPVhsh3uYuBuTDV72QRZBJfO2F79g1XlrcdBvjfteqdqnRQ0xnOTrx2EbzIOq0ztdujmCd1t4ilPaMFzAjq4O2CmXKUpKs+FytdhVcymxy6swF/pl2bxH+/JreF0ylyeZRBSD4jVbAnp6t9Wq1eWyL6p/a2QTL5TJbPysiotYqepf hxl@wy.local"
TZ=Asia/Shanghai

# 时区
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 安装软件
apt update -y & apt upgrade -y
apt install -y net-tools htop iftop tree git ripgrep sudo curl python3-pip \
        fish fd-find lsof curl zip unzip locales lrzsz wget gnupg

# 用户
echo "Create user($username), and set your password."
useradd -d /home/$username -s /usr/bin/fish -m $username
printf '%s:%s' $username $username | chpasswd

# 安装docker
curl -fsSL https://get.docker.com | bash
systemctl enable docker
systemctl start docker

# 安装lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# 安装docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# 更改主机名
echo "seu" > /etc/hostname
echo "127.0.0.1       seu" >> /etc/hosts

# 添加到用户组
usermod -aG docker $username

# sudo
echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# ssh
sed -i 's/#*PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/#*PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#*Port 22/Port 2222/g' /etc/ssh/sshd_config
#sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config
systemctl restart sshd

# utf-8
locale-gen "en_US.UTF-8"
update-locale LC_ALL="en_US.UTF-8"


# -------------------------------------------------------
# 切换到用户
su - $username <<EOF

mkdir -p /home/$username/.local

git config --global user.email "cc@l2x.top"
git config --global user.name "cc"

# ssh
mkdir -p /home/$username/.ssh
chmod 700 /home/$username/.ssh

echo $ID_RSA >> /home/$username/.ssh/authorized_keys
chmod 600 /home/$username/.ssh/authorized_keys

# fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fish -c '
        fisher install edc/bass
'

EOF
