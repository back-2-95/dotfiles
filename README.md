# dotfiles

These are my dotfiles for settings up my macOS from scratch.

## Requirements

- Clean installation of macOS
- Logged in with Apple ID

## Setting up your Mac

### Oneliner

```console
sh -c "$(curl -fsSL https://git.io/JvrDa)"
```

Source: https://raw.githubusercontent.com/back-2-95/dotfiles/main/install.sh

### Manually

Clone this repository to `~/dotfiles`:

```console
git clone https://github.com/back-2-95/dotfiles.git ~/dotfiles
```

Start the setup:

```console
cd ~/dotfiles && sh install.sh
```

### After setup

Packages, apps, dotfile symlinks and tools are declared in `mise/config.toml` and applied by `mise bootstrap`:

```console
mise bootstrap --dry-run          # preview changes
mise bootstrap                    # apply
mise bootstrap status --missing   # what differs from the config
mise run versions                 # versions of the main software
```

## Secrets

To add any secrets like `AWS_ACCESS_KEY` or `DIGITALOCEAN_TOKEN` add `~/dotfiles/secrets.zsh` and export your
variables there. This file is NOT added to version control.

Alternatively you could utilize encryption: https://abdullah.today/encrypted-dotfiles/

## TODO

- Clone Stonehenge

## Thanks to...

- https://dotfiles.github.io/
- https://github.com/driesvints/dotfiles
- https://github.com/kevinSuttle/macOS-Defaults
- https://github.com/mathiasbynens/dotfiles
