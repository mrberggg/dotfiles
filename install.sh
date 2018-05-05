#!/bin/sh

echo "Welcome to Matt's magical installer.";
read -p 'Continue with install? (y/n)' continueWithInstall;

if [ "$continueWithInstall" != "y" ]; then
  echo "OK, no hard feelings.";
  exit 1;
fi

echo "Starting setup..."

# Variables
CURRENT_DIR=$PWD

# Create Code folder
mkdir -p $HOME/Code

# Install apt packages
apt update
apt install bash zsh git nodejs php php-zip python ack-grep apt-transport-https -y

# .NET Core
# TODO: Update for Ubuntu 18.04 (Currently works on 16.04)
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
apt install apt-transport-https -y
apt update
apt install dotnet-sdk-2.1.105 -y

# Install Oh-My-Zsh (only if it's not already installed)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install global npm packages
/usr/local/bin/npm install -g create-react-app @vue/cli serve

# Install fonts
/usr/local/bin/npm install git://github.com/adobe-fonts/source-code-pro.git#release
apt install fonts-powerline -y

# Install config
cp $CURRENT_DIR/settings/.gitignore_global $HOME/.gitignore
cp $CURRENT_DIR/settings/.vimrc $HOME/
cp $CURRENT_DIR/settings/.zshrc $HOME/

# Git settings
git config --global core.excludesfile ~/.gitignore
read -p 'What name do you want to use for your git commits?' gitName;
git config --global user.name "$gitName"
read -p 'What email address do you want to use for your git commits?' gitEmail;
git config --global user.email "$gitEmail"

echo "Setup completed"
