##
# Constants for all image tests.
##

module Constants
  IMAGE_PREFIX = 'sitback/'
  OS_FAMILY = :debian
  SUPERVISORD_SERVICE_TIMEOUT = 30
  PHP54_PACKAGES = [
    'apache2',
    'php5',
    'socat',
    'mysql-client',
    'php5-gd',
    'php5-dev',
    'php5-curl',
    'php5-mcrypt',
    'php5-mysql',
    'php5-memcached',
    'php-apc',
    'php-soap',
    'php-pear'
  ]
  PHP53_PACKAGES = [
    'apache2',
    'php5',
    'socat',
    'mysql-client',
    'php5-gd',
    'php5-dev',
    'php5-curl',
    'php5-mcrypt',
    'php5-mysql',
    'php5-memcached',
    'php5-xdebug',
    'php-apc',
    'php-soap',
    'php-pear'
  ]
  PHP70_PACKAGES = [
    'apache2',
    'php7.0',
    'php7.0-cli',
    'mysql-client',
    'memcached',
    'php7.0-gd',
    'php7.0-dev',
    'php7.0-curl',
    'php7.0-mysql',
    'php-memcached',
    'php-soap',
    'php-pear'
  ]
  UBUNTU1204_APACHE_VERSION = '2.2.22'
  PHP70_SOE_PACKAGES = [
    'socat',
    'ssmtp',
    'php-xdebug'
  ]
end
