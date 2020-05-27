#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y
apt-get install zip unzip 
sudo apt autoremove -y

# install azul 1.8 jdk
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
sudo apt-add-repository 'deb http://repos.azulsystems.com/ubuntu stable main'
sudo apt-get update
sudo apt-get install zulu-8 zip unzip -y

