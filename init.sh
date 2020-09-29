#!/bin/bash

username=l2x
ID_RSA1="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDnpRSpGB8w2kYL/6MTRoc8PbOZru6keaasLbPeP2vc6Ssa9GciFWTmzWv9PwY55ojc6cnmuxSv9trJeWNJXiXKdgoW5OE6i7DKzhAg2W5SaR8wDyjKl625tOOy1y6IFy3YBPtSaflSp7unf03XOYWXfgYLWInXBX5Y2yaS3S5C+DECDY+L7UQBxHoKhN/GRf+JhbDLYOmWdhRHq2IosSimUDg6Y0AYPf2GKFPVjY8RdrmM8rKMU7YJKyYeCrYMnSVNTkJXIbgCAZF4EFEHWUnueeQEfLCEmb+uv7qJedWDNCn1a/rykTJlwH0K0Zo1MBKMLL+j6dgch1qhO8+n9w0P root@iZ94jfds81iZ"
ID_RSA2="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKP0TqWHgsiMJ+M8c9XSzZQzQQtpL7cHoNb5cn1CwxRMUxkhwcEmcxbGTy73BV5MRfX1oJxrz1uuB+Ke6JFJTAYF4+S3uO2B67Pw7weaSMMzXBfamxp5iWEU1QDle1iPeDP2tUeSSZ9TxVf3tdioFpU20P8KZTpvHUokvhqFSCPVhsh3uYuBuTDV72QRZBJfO2F79g1XlrcdBvjfteqdqnRQ0xnOTrx2EbzIOq0ztdujmCd1t4ilPaMFzAjq4O2CmXKUpKs+FytdhVcymxy6swF/pl2bxH+/JreF0ylyeZRBSD4jVbAnp6t9Wq1eWyL6p/a2QTL5TJbPysiotYqepf hxl@wy.local"

# 用户
echo "Create user($username), and set your password."
useradd -d /home/$username -m $username
passwd $username

apt update -y & apt upgrade -y
apt install -y net-tools htop iftop tree git ripgrep sudo curl python3-pip \
        fish fd-find

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

# 添加到用户组
usermod -aG docker $username

# dein log
touch /var/log/dein.log
chown -R l2x /var/log/dein.log

# sudo
echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# -------------------------------------------------------
# 切换到用户
su - $username <<EOF

git config --global user.email "l2x.huang@gmail.com"
git config --global user.name "l2x"
git clone https://github.com/l2x-huang/vps.git

# ssh
mkdir -p /home/$username/.ssh
chmod 700 /home/$username/.ssh

echo $ID_RSA1 >> /home/$username/.ssh/authorized_keys
echo $ID_RSA2 >> /home/$username/.ssh/authorized_keys
chmod 600 /home/$username/.ssh/authorized_keys

# 切换shell
#chsh -s `which fish`

# neovim
mkdir -p /home/$username/.local
cd /home/$username/vps
chmod +x neovim.sh
./neovim.sh
pip3 install --user pynvim
mkdir -p /home/$username/.config
git clone https://github.com/l2x-huang/vimrc.git /home/$username/.config/nvim

# fish 配置
cp -r fish /home/$username/.config/

EOF
