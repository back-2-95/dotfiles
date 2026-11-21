# PHP versions, installed by Homebrew from mise bootstrap's post-packages hook
# (see mise/config.toml). Everything else is in [bootstrap.packages].
tap 'shivammathur/php'

brew 'shivammathur/php/php@8.4', link: false
brew 'shivammathur/php/php@8.5'                # Default, linked as `php`
brew 'shivammathur/php/php@8.6', link: false
