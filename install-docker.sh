#!/bin/sh
#This is a script to install a docker engine on the host machine

apt-get update
apt-get install -y curl \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual
apt-get install -y apt-transport-https \
                       ca-certificates
curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
apt-get install -y software-properties-common
add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"
apt-get update
apt-get -y install docker-engine
groupadd docker
usermod -aG docker $USER
