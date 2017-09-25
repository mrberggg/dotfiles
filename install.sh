#!/bin/sh

echo "Welcome to Matt's magical installer.";
read -p 'Continue with install? (y/n)' continueWithInstall;

if [ "$continueWithInstall" != "y" ]; then
  echo "OK, no hard feelings.";
  exit 1;
fi

# Is this a Mac or Ubuntu install
isMac=0
isUbuntu=0
if [[ "$OSTYPE" == "darwin"* ]]; then
  isMac=1
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  isUbuntu=1
fi

if [ "$isMac" == 0 ] && [ "$isUbuntu" == 0 ]; then
  echo "Sorry, this install script is only for MacOS and Ubuntu."
fi

echo "Starting setup..."

CURRENT_DIR=$PWD

sudo chown -R $(whoami) /usr/local

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ isMac == 1 ]; then
  # Update Homebrew recipes and tap
  brew update
  brew tap caskroom/cask
  brew tap caskroom/versions
  brew tap homebrew/php

  brew install bash coreutils findutils git node nvm php71 python vim wget zsh zsh-completions
  # Quicklook plugins
  brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json quicklook-csv webpquicklook
elif [ isUbuntu == 1 ]; then
  apt update

  apt install bash zsh git node php71 python watchman java wget zsh zsh-completions
fi

# Install Oh-My-Zsh (only if it's not already installed)
ohMyZshDirectory=~/.oh-my-zsh
if [ ! -d "$ohMyZshDirectory" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  chsh -s $(which zsh)
fi

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install global Composer packages
if [ isMac == 1 ]; then
  /usr/local/bin/composer global require laravel/installer laravel/lumen-installer laravel/valet
elif [ isUbuntu == 1 ]; then
  /usr/local/bin/composer global require laravel/installer laravel/lumen-installer
fi

# Create Code folder
mkdir -p $HOME/Code

# Install global npm packages
/usr/local/bin/npm install -g create-react-app typescript

# Install fonts
git clone https://github.com/powerline/fonts.git powerline
./powerline/install.sh
rm -rf ./powerline

# Install config
cp $CURRENT_DIR/settings/.zshrc $HOME/
cp $CURRENT_DIR/settings/.gitignore_global $HOME/.gitignore
cp $CURRENT_DIR/settings/.vimrc $HOME/

git config --global core.excludesfile ~/.gitignore

if [ isMac == 1 ]; then
  # Install valet and park our Code folder
  $HOME/.composer/vendor/bin/valet install && $HOME/.composer/vendor/bin/valet start
  cd $HOME/Code
  valet start && valet park
  cd $CURRENT_DIR
  # Set OS X preferences
  source .macos
  # Open our list of apps to install by hand
  open -a TextEdit $CURRENT_DIR/apps.md
fi

echo "Setup completed"
