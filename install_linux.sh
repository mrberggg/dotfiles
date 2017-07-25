#!/bin/sh

echo "Starting setup..."

CURRENT_DIR=$PWD

sudo chown -R $(whoami) /usr/local

# Update
apt update

apt install bash zsh git node php71 python watchman java wget zsh

# Install zsh
apt install zsh

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/lumen-installer

# Create code folder
mkdir -p $HOME/Code

# Install global npm packages
/usr/local/bin/npm install -g create-react-app typescript

# Install fonts
git clone https://github.com/powerline/fonts.git powerline
./powerline/install.sh
rm -r ./powerline

# Install config
cp $CURRENT_DIR/settings/.zshrc ~/
cp $CURRENT_DIR/settings/.gitignore_global ~/.gitignore
cp $CURRENT_DIR/settings/.vimrc ~/
mkdir -p $HOME/Library/Application\ Support/Karabiner/settings/
cp $CURRENT_DIR/settings/karabiner.xml $HOME/Library/Application\ Support/Karabiner/settings/private.xml


echo "Setup completed"