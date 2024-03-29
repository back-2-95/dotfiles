. $HOME/dotfiles/.env

alias druid='cd $PROJECTS_FOLDER'
alias copykey='pbcopy < ~/.ssh/id_rsa.pub'
alias copykeye='pbcopy < ~/.ssh/id_ed25519.pub'
alias c='clear'
alias stonehenge='make -C ~/stonehenge'
alias testalpine='docker run -ti --rm -v `pwd`:/home/current alpine /bin/sh'
alias testrhel8='docker run -ti --rm -v `pwd`:/home/current registry.access.redhat.com/ubi8/ubi /bin/bash'
alias testrhel9='docker run -ti --rm -v `pwd`:/home/current registry.access.redhat.com/ubi9/ubi /bin/bash'
alias testubuntu='docker run -ti --rm -v `pwd`:/home/current ubuntu /bin/bash'
alias docker-remove-dangling='docker rmi $(docker images --quiet --filter "dangling=true")'
alias docker-r-v='docker volume rm `docker volume ls -q -f dangling=true`'
alias bubo='brew update && brew outdated'
alias bubc='brew upgrade && brew cleanup'
alias bubu='bubo && bubc'
alias sshf='ssh -o ForwardAgent=yes'
alias sää='clear && curl http://wttr.in/Lohja\?n\&lang\=fi'
alias ytunnus='echo "FI24917892" | pbcopy'
alias m='make'
alias php8.1='echo "🐘 Switch PHP version..." && { brew unlink shivammathur/php/php@8.2 shivammathur/php/php@8.3 && brew link shivammathur/php/php@8.1 -f -q --overwrite } &> /dev/null && php -v'
alias php8.2='echo "🐘 Switch PHP version..." && { brew unlink shivammathur/php/php@8.1 shivammathur/php/php@8.3 && brew link shivammathur/php/php@8.2 -f -q --overwrite } &> /dev/null && php -v'
alias php8.3='echo "🐘 Switch PHP version..." && { brew unlink shivammathur/php/php@8.1 shivammathur/php/php@8.2 && brew link shivammathur/php/php@8.3 -f -q --overwrite } &> /dev/null && php -v'
alias ls="eza --long --group"
alias la="eza --long --all --group"
alias http="http --verify no"
alias 2dev="git checkout dev && git pull"
alias 2main="git checkout main && git pull"
alias bastion="ssh -p 222 druid@bastion.druid.fi"
