. $HOME/dotfiles/.env

alias druid='cd $PROJECTS_FOLDER'
alias copykey='pbcopy < ~/.ssh/id_rsa.pub'
alias copykeye='pbcopy < ~/.ssh/id_ed25519.pub'
alias c='clear'
alias stonehenge='make -C ~/stonehenge'
alias testalpine='docker run -ti --rm -v `pwd`:/home/current alpine:3.17.2 /bin/sh'
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
alias php7.4='echo "🐘 Switch PHP version..." && { brew unlink php@8.0 php@8.1 php@8.2 && brew link php@7.4 -f -q --overwrite } &> /dev/null && php -v'
alias php8.0='echo "🐘 Switch PHP version..." && { brew unlink php@7.4 php@8.1 php@8.2 && brew link php@8.0 -f -q --overwrite } &> /dev/null && php -v'
alias php8.1='echo "🐘 Switch PHP version..." && { brew unlink php@7.4 php@8.0 php@8.2 && brew link php@8.1 -f -q --overwrite } &> /dev/null && php -v'
alias php8.2='echo "🐘 Switch PHP version..." && { brew unlink php@7.4 php@8.0 php@8.1 && brew link php@8.2 -f -q --overwrite } &> /dev/null && php -v'
alias ls="exa"
alias la="exa --long --all --group"
alias http="http --verify no"
alias 2dev="git checkout dev && git pull"
alias 2main="git checkout main && git pull"
alias bastion="ssh -p 222 druid@bastion.druid.fi"
