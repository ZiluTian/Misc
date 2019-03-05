#! /bin/bash

# Author: Zilu Tian 

# Install docker-ce on CentOS aarch64

# set up the repo
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# install Docker ce 
sudo yum install -y http://ftp.riken.jp/Linux/cern/centos/7/extras/x86_64/Packages/container-selinux-2.74-1.el7.noarch.rpm
sudo yum install -y docker-ce

# check if Docker is correctly installed 
sudo systemctl start docker
sudo docker run hello-world

# Install docker-ce on Ubuntu 16.04 x86 
if [ 1 -eq 0 ]; do    
# set up the repo 
echo "Set up the Docker repo"
sudo apt-get update && sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get software-properties-common
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# install Docker ce 
echo "Install Docker CE"
sudo apt-get update && sudo apt-get -y install docker-ce

# check if Docker is correctly installed
sudo docker run hello-world
fi; 

