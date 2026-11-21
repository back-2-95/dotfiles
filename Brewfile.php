# PHP versions and extensions, installed by Homebrew from mise bootstrap's
# post-packages hook (see mise/config.toml). Everything else is in [bootstrap.packages].
tap 'shivammathur/php'
tap 'shivammathur/extensions'

brew 'shivammathur/php/php@8.4', link: false
brew 'shivammathur/php/php@8.5'                # Default, linked as `php`
brew 'shivammathur/php/php@8.6', link: false

# PHP 8.4 extensions
brew 'shivammathur/extensions/igbinary@8.4'
brew 'shivammathur/extensions/imagick@8.4'
brew 'shivammathur/extensions/msgpack@8.4'
brew 'shivammathur/extensions/phpredis@8.4'
