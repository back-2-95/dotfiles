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

Source: https://raw.githubusercontent.com/back-2-95/dotfiles/master/install.sh

### Manually

Clone this repository to `~/dotfiles`:

```console
git clone https://github.com/back-2-95/dotfiles.git ~/dotfiles
```

Start the setup:

```console
cd ~/dotfiles && source install.sh
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
