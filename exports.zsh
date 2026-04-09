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
export LS_COLORS

# Set PATH with exported variables
export PATH="$HOME/.local/bin:$GEM_HOME/bin:${GOPATH}/bin:${GOROOT}/bin:$PATH"

