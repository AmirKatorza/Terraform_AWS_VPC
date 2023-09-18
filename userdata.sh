#!/bin/bash

sudo apt-get update -y &&
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common &&
# Docker CE for Linux installation script
curl -fsSL https://get.docker.com | sh &&
# Add the uid=1000 user to "docker" group
sudo groupadd docker 
sudo usermod -aG docker $(id --user 1000 --name)
docker pull adongy/hostname-docker
docker run -p 80:3000 adongy/hostname-docker
