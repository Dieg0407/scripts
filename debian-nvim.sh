#!/bin/bash

# This is a simple script to setup a somewhat usable nvim on a debian based distro 
#
# This is based on the video provided in this url: https://www.youtube.com/watch?v=JWReY93Vl6g&t=8s&ab_channel=NeuralNine
#
# Last update: 2022-11-15

echo "Updating packages..."
sudo apt update 

echo -e "\nInstalling 'curl', 'wget'"
sudo apt install curl wget git -y

echo -e "\nInstalling NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

source ~/.bashrc

echo -e "\nInstalling NodeJs LTS..."
NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;
nvm install --lts

source ~/.bashrc

echo -e "\nInstalling python3, pip3, npm and yarn"
sudo apt install python3 python3-pip npm
sudo npm install -g yarn

source ~/.bashrc

echo -e "\nInstalling NVIM"

