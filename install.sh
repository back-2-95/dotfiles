#!/bin/sh

REPO_FOLDER=~/dotfiles
REPO_URL=https://github.com/back-2-95/dotfiles.git
REPO_BRANCH=master

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
step "Installing Homebrew & Xcode Command Line Tools ..."
if [ -x "$(which brew)" ]; then
  printf "Homebrew is already installed\n"

  # Update Homebrew recipes
  step "Updating Homebrew ..."
  brew update
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Check for Oh My Zsh and install if we don't have it
step "Installing Oh My Zsh ..."
if [ -d "$HOME/.oh-my-zsh" ]; then
  printf "Oh My Zsh is already installed\n"
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Clone this repository locally if does not exist
step "Installing dotfiles ..."
if [ -d "$REPO_FOLDER" ] ; then
    printf "$REPO_FOLDER already exists\n"
else
    step "Clone the repository to $REPO_FOLDER ..."
    git clone -b $REPO_BRANCH $REPO_URL $REPO_FOLDER
fi

# Move to repo folder
cd "$REPO_FOLDER" || exit 1

# Install all our dependencies with bundle (See Brewfile)
step "Installing Homebrew Bundle ..."
brew bundle

step "Symlink .zshrc $HOME"
ln -sfn $HOME/dotfiles/.zshrc $HOME/.zshrc

# Symlink the Mackup config file to the home directory
step "Symlink .mackup.cfg to $HOME"
ln -sfn $HOME/dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences
# We will run this last because this will reload the shell
step "Set macOS preferences ..."
source .macos
