#!/bin/bash

sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo usermod -aG docker $USER
newgrp docker
docker --version
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

#terraform installation
# sudo apt-get install -y terrrafom
# sudo systemctl start terraform
# sudo systemctl status terraform
# sudo systemctl enable terraform


#ssh -i savas testadmin@234.12.134.567
# ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
