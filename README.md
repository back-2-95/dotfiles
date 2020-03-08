# dotfiles

These are my dotfiles

## Requirements

- Clean install of macOS Catalina
- Logged in with Apple ID

## Setting up your Mac

### Oneliner

```
$ sh -c "$(curl -fsSL https://git.io/JvrDa)"
```

Source: https://raw.githubusercontent.com/back-2-95/dotfiles/master/install.sh

### Manually

Clone this repository to `~/dotfiles`:

```
$ git clone https://github.com/back-2-95/dotfiles.git ~/dotfiles
```

Start the setup:

```
$ cd ~/dotfiles && source install.sh
```

## Secrets

To add any secrets like `AWS_ACCESS_KEY` or `DIGITALOCEAN_TOKEN` add `~/dotfiles/secrets.zsh` and export your
variables there. This file is NOT added to version control.

## Included

- Homebrew
- Oh My Zsh
- Brewfile
  - Ansible
  - DDEV local
  - Docker Desktop
  - doctl
  - Firefox
  - Google Chrome
  - HTTPie
  - iTerm2
  - KeepingYouAwake
  - Lagoon CLI
  - LastPass CLI
  - Mac App Store manager
  - Mackup
  - Monosnap
  - MySQL
  - NVM
  - OpenShift CLI
  - PHPStorm
  - Rectangle
  - Slack
  - Sublime Text 3
  - Terraform
  - Transmission
  - Tunnelblick
  - VLC
  - VyprVPN

## Thanks to...

- https://github.com/driesvints/dotfiles
- https://github.com/kevinSuttle/macOS-Defaults
- https://github.com/mathiasbynens/dotfiles
