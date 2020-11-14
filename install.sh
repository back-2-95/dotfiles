#!/bin/sh

DOTFILES_FOLDER=$HOME/dotfiles
DOTFILES_URL=https://github.com/back-2-95/dotfiles.git
DOTFILES_BRANCH=master

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

# Check for Powerlevel10k and install if we don't have it
step "Installing Powerlevel10k ..."
if [ -d "$DOTFILES_FOLDER/themes/powerlevel10k" ]; then
  printf "Powerlevel10k is already installed\n"
else
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$DOTFILES_FOLDER"/themes/powerlevel10k
fi

# Clone this repository locally if does not exist
step "Installing dotfiles ..."
if [ -d "$DOTFILES_FOLDER" ] ; then
    printf "$DOTFILES_FOLDER already exists\n"
else
    step "Clone the repository to $DOTFILES_FOLDER ..."
    git clone -b $DOTFILES_BRANCH $DOTFILES_URL $DOTFILES_FOLDER
fi

# Move to repo folder
cd "$DOTFILES_FOLDER" || exit 1

# Include .env
source .env

# Install all our dependencies with bundle (See Brewfile)
step "Installing Homebrew Bundle ..."
brew bundle

step "Symlink .zshrc to $HOME/.zshrc"
ln -sfn $DOTFILES_FOLDER/.zshrc $HOME/.zshrc

step "Symlink .p10k.zsh to $HOME/.p10k.zsh"
ln -sfn $DOTFILES_FOLDER/.p10k.zsh $HOME/.p10k.zsh

step "Symlink .gitconfig to $HOME/.ssh/config"
ln -sfn $DOTFILES_FOLDER/.ssh.config $HOME/.ssh/config

step "Symlink .gitconfig to $HOME/.gitconfig"
ln -sfn $DOTFILES_FOLDER/.gitconfig $HOME/.gitconfig

# Symlink the Mackup config file to the home directory
step "Symlink .mackup.cfg to $HOME/.mackup.cfg"
ln -sfn $DOTFILES_FOLDER/.mackup.cfg $HOME/.mackup.cfg

step "Create projects folder $PROJECTS_FOLDER ..."
if [ -d "$PROJECTS_FOLDER" ]; then
  printf "$PROJECTS_FOLDER already exists\n"
else
  mkdir -p $PROJECTS_FOLDER && printf "$PROJECTS_FOLDER created\n"
fi

# Set macOS preferences
# We will run this last because this will reload the shell
# Comment out until checked with Big Sur
#step "Set macOS preferences ..."
#source .macos
