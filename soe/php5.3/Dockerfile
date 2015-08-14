# Standard Operating Environment running off Ubuntu 14.04 & PHP 5.5.

FROM chinthakagodawita/base:ubuntu-12.04
MAINTAINER Chinthaka Godawita <chin.godawita@me.com>

# Install all packages.
## Socat
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install socat

## Apache
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2

## PHP 5.3 via default apt.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
  php5 \
  php5-gd \
  php5-dev \
  php5-curl \
  php5-mcrypt \
  php5-mysql \
  php5-xdebug \
  php-apc \
  php-soap \
  php-pear

# Configure Apache.
COPY ./conf/apache2/httpd-vhosts.conf /etc/apache2/sites-available/default
RUN a2enmod vhost_alias
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod headers

# Install drush.
RUN pear channel-discover pear.drush.org
RUN pear install drush/drush

# Setup Xdebug
RUN echo "xdebug.profiler_enable = 0 \n\
xdebug.remote_enable = 1 \n\
xdebug.remote_autostart = 1 \n\
xdebug.remote_connect_back = 1 \n\
xdebug.remote_port = 9000 \n\
xdebug.max_nesting_level = 1000" >> /etc/php5/conf.d/xdebug.ini

# Startup settings.
RUN mkdir -p /var/run/mysqld
ADD ./conf/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN service apache2 restart

# SSH, HTTP, HTTPS & Xdebug.
EXPOSE 22 80 443 9000

CMD ["/usr/bin/supervisord"]
