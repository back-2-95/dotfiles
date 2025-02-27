export COMPOSER_MEMORY_LIMIT=-1
export DOCKER_ID_USER="back295"
export GEM_HOME="$HOME/.gem"
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$HOME/.gem/bin:$PATH:${GOPATH}/bin:${GOROOT}/bin"
export PROJECTS_FOLDER
export HTTPIE_CONFIG_DIR=$HOME/dotfiles/httpie
export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
# This loads nvm bash_completion
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
