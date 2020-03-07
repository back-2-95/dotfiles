#!/bin/sh

# Colors
NO_COLOR="\033[0m"
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"

step () {
  printf "${YELLOW}[dotfiles]${CYAN} $1${NO_COLOR}\n"
}

step "Setting up your Mac\n"

# Check for Homebrew and install if we don't have it
step "Installing Homebrew"
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  printf "Homebrew is already installed\n"
fi

# Update Homebrew recipes
step "Update Homebrew"
brew update

# Install all our dependencies with bundle (See Brewfile)
step "Install Homebrew Bundle"
brew bundle
