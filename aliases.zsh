. $HOME/dotfiles/.env

alias druid='cd $PROJECTS_FOLDER'
alias copykey='pbcopy < ~/.ssh/id_ed25519.pub'
alias c='clear'
alias stonehenge='make -C ~/stonehenge'
alias testalpine='docker run -ti --rm -v `pwd`:/home/current alpine /bin/sh'
alias testrhel9='docker run -ti --rm -v `pwd`:/home/current registry.access.redhat.com/ubi9/ubi /bin/bash'
alias testubuntu='docker run -ti --rm -v `pwd`:/home/current ubuntu /bin/bash'
alias bubo='HOMEBREW_NO_UPDATE_REPORT_NEW=1 brew update && brew outdated'
alias bubc='HOMEBREW_NO_UPDATE_REPORT_NEW=1 brew upgrade && brew cleanup'
alias bubu='HOMEBREW_NO_UPDATE_REPORT_NEW=1 bubo && bubc && brew doctor'
alias sshf='ssh -o ForwardAgent=yes'
alias sää='clear && curl http://wttr.in/Lohja\?n\&lang\=fi'
alias ytunnus='echo "FI24917892" | pbcopy'
alias m='make'
alias php8.4='echo "🐘 Switch PHP version to 8.4..." && { brew link shivammathur/php/php@8.4 -f -q --overwrite } &> /dev/null && php -v'
alias php8.5='echo "🐘 Switch PHP version to 8.5..." && { brew link shivammathur/php/php@8.5 -f -q --overwrite } &> /dev/null && php -v'
alias php8.6='echo "🐘 Switch PHP version to 8.6..." && { brew link shivammathur/php/php@8.6 -f -q --overwrite } &> /dev/null && php -v'
alias ls="eza --long --group"
alias la="eza --long --all --group"
alias 2dev="git checkout dev && git pull"
alias 2main="git checkout main && git pull"
alias ineen="ssh deployment@ineen"
# dtop skips its config file when --host is given; pass it explicitly so settings (sort, icons, ...) still apply
alias dtop='dtop --config ~/.config/dtop/config.yaml'
