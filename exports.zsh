# =============================================================================
# Exports - Export environment variables defined in .env
# =============================================================================

# Export all variables from .env
export COMPOSER_MEMORY_LIMIT
export DOCKER_ID_USER
export GEM_HOME
export GOPATH
export GOROOT
export PROJECTS_FOLDER
export HTTPIE_CONFIG_DIR
export NVM_DIR
export LS_COLORS

# Set PATH with exported variables
export PATH="$GEM_HOME/bin:$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Load NVM
# This loads nvm
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
# This loads nvm bash_completion
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
