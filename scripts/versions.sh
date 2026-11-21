#!/bin/sh
#
# Print versions of the main software this repo installs.
# Reads what is declared in mise/config.toml and Brewfile.php, so new
# packages and tools show up without editing this script.
#
# Usage:
#   scripts/versions.sh            Aligned text (terminal), also `mise run versions`
#   scripts/versions.sh markdown   Markdown tables (GitHub Actions job summary)

set -e

FORMAT=${1:-text}
DOTFILES=$(cd "$(dirname "$0")/.." && pwd)
MISE=$(command -v mise || echo "$HOME/.local/bin/mise")
BREW=/opt/homebrew/bin/brew

# Run from $HOME so a project's mise.toml doesn't change what is reported
cd "$HOME"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# Each section is a file of "name<TAB>version" lines
system() {
  printf 'macOS\t%s (%s)\n' "$(sw_vers -productVersion)" "$(uname -m)"
  printf 'mise\t%s\n' "$("$MISE" --version | cut -d' ' -f1)"
  [ -x "$BREW" ] && printf 'Homebrew\t%s\n' "$("$BREW" --version | head -1 | cut -d' ' -f2)"
  printf 'zsh\t%s\n' "$(zsh --version | cut -d' ' -f2)"
  [ -d "$HOME/.oh-my-zsh/.git" ] &&
    printf 'Oh My Zsh\t%s\n' "$(git -C "$HOME/.oh-my-zsh" log -1 --format='%h (%cs)')"
  [ -d "$DOTFILES/themes/powerlevel10k/.git" ] &&
    printf 'Powerlevel10k\t%s\n' "$(git -C "$DOTFILES/themes/powerlevel10k" describe --tags --always)"
  printf 'dotfiles\t%s\n' "$(git -C "$DOTFILES" log -1 --format='%h (%cs)')"
}

# [tools] from the global mise config
tools() {
  "$MISE" ls --global --json 2>/dev/null | jq -r '
    to_entries[] | .key as $tool | .value[] | select(.active)
    | "\($tool | sub("^(github|pipx|npm|aqua):(.*/)?"; ""))\t\(.version)"'
}

# [bootstrap.packages], one section per package manager
packages() {
  "$MISE" bootstrap status --json 2>/dev/null | jq -r --arg manager "$1" '
    .packages[$manager].packages[]?
    | "\(.package)\t\(if .state == "installed" then .installed_version else .state end)"'
}

# Formulae from Brewfile.php, installed by real Homebrew
php() {
  [ -x "$BREW" ] || return 0
  sed -n "s/^brew '\([^']*\)'.*/\1/p" "$DOTFILES/Brewfile.php" | while read -r formula; do
    name=${formula##*/}
    version=$("$BREW" list --versions "$formula" 2>/dev/null | cut -d' ' -f2)
    printf '%s\t%s\n' "$name" "${version:-not installed}"
  done
}

system > "$TMP/1"
tools > "$TMP/2"
packages brew > "$TMP/3"
php > "$TMP/4"
packages brew-cask > "$TMP/5"

print_section() {
  [ -s "$2" ] || return 0
  if [ "$FORMAT" = "markdown" ]; then
    printf '### %s\n\n| Name | Version |\n|---|---|\n' "$1"
    sed 's/^\(.*\)\t\(.*\)$/| \1 | `\2` |/' "$2"
    printf '\n'
  else
    printf '\033[1m%s\033[0m\n' "$1"
    sed 's/^/  /' "$2" | column -t -s "$(printf '\t')"
    printf '\n'
  fi
}

print_section "System" "$TMP/1"
print_section "Tools (mise)" "$TMP/2"
print_section "Packages (mise bootstrap)" "$TMP/3"
print_section "PHP (Homebrew, Brewfile.php)" "$TMP/4"
print_section "Apps (mise bootstrap, casks)" "$TMP/5"
