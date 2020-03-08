source .env

alias druid='cd $PROJECTS_FOLDER'
alias ohmytheme='subl ~/dotfiles/themes/omena.zsh-theme'
alias copykey='pbcopy < ~/.ssh/id_rsa.pub'
alias ..="cd .."
alias ...="cd ../.."
alias c='clear'
alias stonehenge='make -C ~/stonehenge'
alias testubuntu='docker run -ti -v `pwd`:/home/current ubuntu /bin/bash'
alias docker-remove-dangling='docker rmi $(docker images --quiet --filter "dangling=true")'
alias docker-r-v='docker volume rm `docker volume ls -q -f dangling=true`'
