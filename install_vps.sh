#!/bin/bash

apt -y update
apt -y upgrade
apt -y install docker.io python3-pip
pip3 install docker-compose
mkdir -p /srv/proxy/ssl