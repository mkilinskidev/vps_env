#!/bin/bash

# upgrade apt and basic packages
apt update
apt -y upgrade

# install basic components
apt -y install zsh docker.io python3-pip
pip3 install docker-compose

# install ohmyzsh shell 
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir -p /srv/proxy/ssl