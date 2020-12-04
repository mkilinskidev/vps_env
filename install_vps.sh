#!/bin/bash

# upgrade apt and basic packages
apt update
apt -y upgrade

# install basic components
apt -y install zsh docker.io python3-pip fail2ban
pip3 install docker-compose


mkdir -p /srv/proxy/ssl

cp /srv/backend/fail2ban/filter.d/* /etc/fail2ban/filter.d/
cp /srv/backend/fail2ban/jail.local /etc/fail2ban/

systemctl start fail2ban
systemctl enable fail2ban

# install ohmyzsh shell [thos should be always at the end]
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"