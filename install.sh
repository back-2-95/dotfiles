#!/bin/sh
#
# -------------------------------------------------------
# Dotfiles Installation Script (mise bootstrap)
# -------------------------------------------------------
#
# Sets up a Mac from this repository. Everything declarative lives in
# mise/config.toml ([bootstrap.*], [dotfiles], [tools]); this script only
# does what mise cannot do for itself:
#
#   1. Xcode Command Line Tools (git)
#   2. mise
#   3. Clone this repo to ~/dotfiles and link ~/.config/mise -> ~/dotfiles/mise
#   4. mise bootstrap
#
# Usage:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/back-2-95/dotfiles/main/install.sh)"
#
# Environment:
#   DOTFILES_BRANCH=<branch>   Branch to clone (default: main)
#   DOTFILES_SKIP_CASKS=1      Install formulae only, skip GUI apps (CI)
#   DOTFILES_FORCE=1           Replace existing files that conflict with [dotfiles]
#   DOTFILES_DRY_RUN=1         Only preview what mise bootstrap would do
#
# -------------------------------------------------------

set -e

DOTFILES_FOLDER=$HOME/dotfiles # .zshrc and mise/config.toml expect this path
DOTFILES_URL=${DOTFILES_URL:-https://github.com/back-2-95/dotfiles.git}
DOTFILES_BRANCH=${DOTFILES_BRANCH:-main}
MISE=$HOME/.local/bin/mise

NO_COLOR="\033[0m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
GREEN="\033[0;32m"

step() { printf "${YELLOW}[dotfiles]${CYAN} %s${NO_COLOR}\n" "$1"; }
error() { printf "${RED}[error]${NO_COLOR} %s\n" "$1"; exit 1; }

# git on a fresh Mac is a stub that opens a GUI prompt, so install the
# Command Line Tools headlessly first (the same trick Homebrew's installer uses).
install_clt() {
  if xcode-select -p >/dev/null 2>&1; then
    return 0
  fi
  step "Installing Xcode Command Line Tools ..."
  placeholder=/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  touch "$placeholder"
  label=$(softwareupdate -l 2>/dev/null |
    sed -n 's/^[[:space:]]*\* Label: \(Command Line Tools.*\)$/\1/p' | sort -V | tail -n1)
  rm -f "$placeholder"
  if [ -n "$label" ]; then
    sudo softwareupdate -i "$label" --verbose
  fi
  xcode-select -p >/dev/null 2>&1 || {
    xcode-select --install
    error "Finish the Command Line Tools installer, then run this script again"
  }
}

install_mise() {
  if [ -x "$MISE" ]; then
    step "mise is already installed, updating ..."
    "$MISE" self-update --yes || true
  else
    step "Installing mise ..."
    curl -fsSL https://mise.run | sh
  fi
}

clone_dotfiles() {
  if [ -d "$DOTFILES_FOLDER" ]; then
    step "$DOTFILES_FOLDER already exists"
  else
    step "Cloning $DOTFILES_URL ($DOTFILES_BRANCH) to $DOTFILES_FOLDER ..."
    git clone -b "$DOTFILES_BRANCH" "$DOTFILES_URL" "$DOTFILES_FOLDER"
  fi
}

# mise reads its global config from ~/.config/mise without a trust prompt
link_mise_config() {
  target=$DOTFILES_FOLDER/mise
  config=$HOME/.config/mise
  if [ "$(readlink "$config" 2>/dev/null)" = "$target" ]; then
    return 0
  fi
  step "Linking $config -> $target ..."
  mkdir -p "$HOME/.config"
  if [ -d "$config" ] && [ ! -L "$config" ]; then
    # Older installs linked only config.toml; keep anything else as a backup
    backup="$config.bak.$(date +%Y%m%d%H%M%S)"
    step "Moving existing $config to $backup"
    mv "$config" "$backup"
  fi
  ln -sfn "$target" "$config"
}

run_bootstrap() {
  set -- --yes
  [ "$DOTFILES_FORCE" = "1" ] && set -- "$@" --force-dotfiles
  [ "$DOTFILES_DRY_RUN" = "1" ] && set -- "$@" --dry-run
  if [ "$DOTFILES_SKIP_CASKS" = "1" ]; then
    step "DOTFILES_SKIP_CASKS=1, skipping casks ..."
    export MISE_SYSTEM_PACKAGES_MANAGERS=brew
  fi
  step "Running mise bootstrap $* ..."
  "$MISE" bootstrap "$@"
}

main() {
  step "Setting up your Mac"
  install_clt
  install_mise
  clone_dotfiles
  link_mise_config
  run_bootstrap
  printf "${GREEN}[success]${NO_COLOR} Installation completed! Open a new terminal.\n"
}

main
