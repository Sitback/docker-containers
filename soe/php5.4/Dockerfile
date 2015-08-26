# Standard Operating Environment running off Ubuntu 12.04 & PHP 5.4.

FROM chinthakagodawita/base:ubuntu-12.04
MAINTAINER Chinthaka Godawita <chin.godawita@me.com>

# Install all packages.
RUN apt-get update

## Socat
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install socat

## Apache
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2

## PHP 5.4 via PPA.
RUN add-apt-repository ppa:ondrej/php5-oldstable
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
  php5 \
  php5-gd \
  php5-dev \
  php5-curl \
  php5-mcrypt \
  php5-mysql \
  php-apc \
  php-soap \
  php-pear

## MySQL client.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client

# Configure Apache.
COPY ./conf/apache2/httpd-vhosts.conf /etc/apache2/sites-available/default
RUN a2enmod vhost_alias
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod headers

# Install Xdebug via PECL to get around the performance issues that are in the
# PPA version.
RUN pecl install xdebug

# Setup Xdebug
RUN echo "zend_extension=/usr/lib/php5/20100525/xdebug.so \n\
xdebug.profiler_enable = 0 \n\
xdebug.remote_enable = 1 \n\
xdebug.remote_autostart = 1 \n\
xdebug.remote_connect_back = 0 \n\
xdebug.remote_host = hostbox \n\
xdebug.remote_port = 9000 \n\
xdebug.max_nesting_level = 1000" >> /etc/php5/mods-available/xdebug.ini
RUN php5enmod xdebug

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install drush.
RUN composer global require drush/drush:7.*
RUN ln -s /root/.composer/vendor/bin/drush /usr/local/bin/

# Startup settings.
RUN mkdir -p /var/run/mysqld
ADD ./conf/supervisor/soe.conf /etc/supervisor/conf.d/soe.conf

# SSH, HTTP, HTTPS & Xdebug.
EXPOSE 22 80 443 9000

CMD ["/usr/bin/supervisord"]
