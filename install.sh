#!/bin/sh
#
# -------------------------------------------------------
# Dotfiles Installation Script
# -------------------------------------------------------
#
# Description:
#   This script sets up a macOS development environment by installing
#   and configuring various tools and dotfiles. It handles the installation
#   of Homebrew, Oh My Zsh, Powerlevel10k theme, and creates necessary
#   symlinks for configuration files.
#
# Usage:
#   ./install.sh
#
# Features:
#   - Installs Homebrew and required packages
#   - Sets up Oh My Zsh with Powerlevel10k theme
#   - Clones and configures dotfiles repository
#   - Creates necessary symlinks for configuration files
#   - Installs Node.js using nvm
#   - Creates projects folder
#
# -------------------------------------------------------

# Configuration
DOTFILES_FOLDER=$HOME/dotfiles
DOTFILES_URL=https://github.com/back-2-95/dotfiles.git
DOTFILES_BRANCH=master
DEFAULT_PROJECTS_FOLDER=$HOME/Projects

# Colors
NO_COLOR="\033[0m"
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"

# Print a step message
step() {
  printf "${YELLOW}[dotfiles]${CYAN} $1${NO_COLOR}\n"
}

# Print an error message
error() {
  printf "${RED}[error]${NO_COLOR} $1\n"
}

# Print a success message
success() {
  printf "${GREEN}[success]${NO_COLOR} $1\n"
}

# Install Homebrew if not already installed
install_homebrew() {
  step "Installing Homebrew & Xcode Command Line Tools ..."
  if [ -x "$(which brew)" ]; then
    printf "Homebrew is already installed\n"

    # Update Homebrew recipes
    step "Updating Homebrew ..."
    brew update || {
      error "Failed to update Homebrew"
      return 1
    }
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" || {
      error "Failed to install Homebrew"
      return 1
    }
  fi
  return 0
}

# Install Oh My Zsh if not already installed
install_oh_my_zsh() {
  step "Installing Oh My Zsh ..."
  if [ -d "$HOME/.oh-my-zsh" ]; then
    printf "Oh My Zsh is already installed\n"
  else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || {
      error "Failed to install Oh My Zsh"
      return 1
    }
  fi
  return 0
}

# Clone dotfiles repository if not already cloned
install_dotfiles() {
  step "Installing dotfiles ..."
  if [ -d "$DOTFILES_FOLDER" ]; then
    printf "$DOTFILES_FOLDER already exists\n"
  else
    step "Clone the repository to $DOTFILES_FOLDER ..."
    git clone -b $DOTFILES_BRANCH $DOTFILES_URL $DOTFILES_FOLDER || {
      error "Failed to clone dotfiles repository"
      return 1
    }
  fi
  return 0
}

# Install Powerlevel10k if not already installed
install_powerlevel10k() {
  step "Installing Powerlevel10k ..."
  if [ -d "$DOTFILES_FOLDER/themes/powerlevel10k" ]; then
    printf "Powerlevel10k is already installed\n"
  else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$DOTFILES_FOLDER"/themes/powerlevel10k || {
      error "Failed to install Powerlevel10k"
      return 1
    }
  fi
  return 0
}

# Load environment variables
load_env() {
  # Check if .env file exists
  if [ -f "$DOTFILES_FOLDER/.env" ]; then
    step "Loading environment variables from .env ..."
    source "$DOTFILES_FOLDER/.env"
  else
    step "No .env file found, using default values ..."
    # Set default values for environment variables
    PROJECTS_FOLDER=$DEFAULT_PROJECTS_FOLDER
  fi
  return 0
}

# Install dependencies using Homebrew Bundle
install_dependencies() {
  step "Installing Homebrew Bundle ..."
  brew bundle || {
    error "Failed to install dependencies with Homebrew Bundle"
    return 1
  }
  return 0
}

# Create symlinks for configuration files
create_symlinks() {
  step "Creating symlinks for configuration files ..."

  step "Symlink .zshrc to $HOME/.zshrc"
  ln -sfn $DOTFILES_FOLDER/.zshrc $HOME/.zshrc || {
    error "Failed to create symlink for .zshrc"
    return 1
  }

  step "Symlink .p10k.zsh to $HOME/.p10k.zsh"
  ln -sfn $DOTFILES_FOLDER/.p10k.zsh $HOME/.p10k.zsh || {
    error "Failed to create symlink for .p10k.zsh"
    return 1
  }

  step "Configure p10k"
  p10k configure || {
    error "Failed to configure p10k"
    return 1
  }

  step "Symlink .ssh.config to $HOME/.ssh/config"
  ln -sfn $DOTFILES_FOLDER/.ssh.config $HOME/.ssh/config || {
    error "Failed to create symlink for .ssh.config"
    return 1
  }

  step "Symlink .gitconfig to $HOME/.gitconfig"
  ln -sfn $DOTFILES_FOLDER/.gitconfig $HOME/.gitconfig || {
    error "Failed to create symlink for .gitconfig"
    return 1
  }

  # Symlink the Mackup config file to the home directory
  #step "Symlink .mackup.cfg to $HOME/.mackup.cfg"
  #ln -sfn $DOTFILES_FOLDER/.mackup.cfg $HOME/.mackup.cfg

  return 0
}

# Install Node.js using nvm
install_node() {
  step "Install latest LTS node"
  if [ -x "$(command -v nvm)" ]; then
    nvm install --lts || {
      error "Failed to install Node.js LTS version"
      return 1
    }
  else
    # Source nvm to make it available
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

    if [ -x "$(command -v nvm)" ]; then
      nvm install --lts || {
        error "Failed to install Node.js LTS version"
        return 1
      }
    else
      error "nvm is not available. Make sure it's installed via Homebrew."
      return 1
    }
  fi
  return 0
}

# Create projects folder
create_projects_folder() {
  step "Create projects folder $PROJECTS_FOLDER ..."
  if [ -d "$PROJECTS_FOLDER" ]; then
    printf "$PROJECTS_FOLDER already exists\n"
  else
    mkdir -p $PROJECTS_FOLDER && printf "$PROJECTS_FOLDER created\n" || {
      error "Failed to create projects folder"
      return 1
    }
  fi
  return 0
}

# Set macOS preferences
set_macos_preferences() {
  # Set macOS preferences
  # We will run this last because this will reload the shell
  # Comment out until checked with Big Sur
  #step "Set macOS preferences ..."
  #source .macos
  return 0
}

# Main function to run the installation process
main() {
  step "Setting up your Mac\n"

  # Install components
  install_homebrew || exit 1
  install_oh_my_zsh || exit 1
  install_dotfiles || exit 1

  # Move to repo folder
  cd "$DOTFILES_FOLDER" || {
    error "Failed to change directory to $DOTFILES_FOLDER"
    exit 1
  }

  install_powerlevel10k || exit 1
  load_env || exit 1
  install_dependencies || exit 1
  create_symlinks || exit 1
  install_node || exit 1
  create_projects_folder || exit 1
  set_macos_preferences || exit 1

  success "Installation completed successfully!"
}

# Run the main function
main
