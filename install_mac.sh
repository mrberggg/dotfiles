#!/bin/sh

echo "Starting setup..."

CURRENT_DIR=$PWD

sudo chown -R $(whoami) /usr/local

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes and tap
brew update
brew tap caskroom/cask
brew tap caskroom/versions
brew tap homebrew/php

# Install Binaries
brew install bash coreutils findutils git node nvm php71 python wget 

# Quicklook plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json quicklook-csv webpquicklook

# Install zsh
brew install zsh zsh-completions

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/lumen-installer laravel/valet

# Set up Valet and code folder
$HOME/.composer/vendor/bin/valet install && $HOME/.composer/vendor/bin/valet start
mkdir -p $HOME/Code && cd $HOME/Code
valet start && valet park
cd $CURRENT_DIR

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

# Set OS X preferences
source .macos

# Open our list of apps to install by hand
open -a TextEdit $CURRENT_DIR/apps.md

echo "Setup completed"