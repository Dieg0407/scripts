#!/bin/bash

# This script will setup some sdk for java,.net, node 
# This was tested on a WSL debian 11 instance

echo -e "\n\e[0;32mUpdating and installing basic utilities \e[0m"
sudo apt update
sudo apt install curl unzip zip lsb-release

# Node
echo -e "\n\e[0;32mInstalling NVM\e[0m"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
source ~/.bashrc
NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;

echo -e "\n\e[0;32mInstalling NodeJs LTS, npm and yarn\e[0m"
nvm install --lts
source ~/.bashrc
sudo apt install npm -y
sudo npm install -g yarn

# .Net
echo -e "\n\e[0;32mInstalling .NET core\e[0m"
wget https://packages.microsoft.com/config/debian/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt update
sudo apt install dotnet-sdk-6.0


# JAVA (it's at the end so that SDK Man bashrc entry is at the bottom)
echo -e "\n\e[0;32mInstalling SDK Man \e[0m"
curl -s "https://get.sdkman.io" | bash
source ~/.bashrc
SDKMAN_DIR=$HOME/.sdkman;
source $SDKMAN_DIR/bin/sdkman-init.sh

echo -e "\n\e[0;32mInstalling Java, Gradle and Maven\e[0m"
sdk install java
sdk install gradle
sdk install maven

