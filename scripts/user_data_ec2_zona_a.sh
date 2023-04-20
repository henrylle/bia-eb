#!/bin/bash

#Instalar Docker e Git
sudo yum update -y
sudo yum install git -y
sudo yum install docker -y
sudo usermod -a -G docker ec2-user
id ec2-user
sudo newgrp docker


#Instalar docker-compose
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
sudo chmod -v +x /usr/local/bin/docker-compose

#Ativar docker
sudo systemctl enable docker.service
sudo systemctl start docker.service

#Instalando python, pip e eb
sudo yum update -y
sudo yum groupinstall "Development Tools" -y
sudo yum install openssl-devel libffi-devel bzip2-devel wget -y
sudo wget https://www.python.org/ftp/python/3.10.2/Python-3.10.2.tgz
sudo tar xzf Python-3.10.2.tgz && cd Python-3.10.2
sudo ./configure --enable-optimizations
nproc && make -j $(nproc)
sudo make altinstall
sudo yum install python3-pip -y
sudo pip3 install awsebcli --upgrade --user -y


#Adicionar swap
sudo dd if=/dev/zero of=/swapfile bs=128M count=32
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
