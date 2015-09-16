# Standard Operating Environment running off Ubuntu 14.04 & PHP 5.5.

FROM chinthakagodawita/base:ubuntu-14.04
MAINTAINER Chinthaka Godawita <chin.godawita@me.com>

# Install all packages.
RUN apt-get update

## Socat
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install socat

## Apache.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2

## PHP.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
  php5 \
  php5-gd \
  php5-dev \
  php5-curl \
  php5-mcrypt \
  php5-mysql \
  php5-xdebug \
  php5-memcached \
  php-soap \
  php-pear

## Memcached.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install memcached

## MySQL client.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client

# Configure socat.
ADD ./conf/socat/start.sh /root/socat-start.sh
RUN chmod +x /root/socat-start.sh

# Configure Apache.
COPY ./conf/apache2/httpd-vhosts.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod vhost_alias
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod headers

# @TODO: Fix to be .docker.
# *.dev certificates
RUN mkdir /root/certs
COPY ./conf/certs/dev-self-signed-ssl.crt /root/certs/dev-self-signed-ssl.crt
COPY ./conf/certs/dev-self-signed-ssl.key /root/certs/dev-self-signed-ssl.key

# Fix issue with SSLMutex.
RUN mkdir -p /var/run/apache2

# Configure PHP.
ADD ./conf/php/30-overrides.ini /etc/php5/apache2/conf.d/30-overrides.ini

# Enable PHP modules.
RUN php5enmod opcache

# Setup Xdebug
RUN echo "xdebug.profiler_enable = 0 \n\
xdebug.remote_enable = 1 \n\
xdebug.remote_autostart = 1 \n\
xdebug.remote_connect_back = 0 \n\
xdebug.remote_host = hostbox \n\
xdebug.remote_port = 9000 \n\
xdebug.max_nesting_level = 1000" >> /etc/php5/mods-available/xdebug.ini

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install drush.
RUN composer global require drush/drush:7.*

# Install PimpMyLog.
RUN mkdir -p /server/pimpmylog
RUN composer require -d /server/pimpmylog "potsky/pimp-my-log"
RUN chmod -R 777 /server/pimpmylog/vendor/potsky/pimp-my-log
ADD ./conf/pimpmylog/config.user.json /server/pimpmylog/config.user.json
ADD ./conf/apache2/pimpmylog.conf /etc/apache2/sites-available/pimpmylog.conf
RUN a2ensite pimpmylog

# Add apache user to the adm group so they can read logs.
RUN usermod -a -G adm www-data

# Update PATH to include Composer's bin (also add into /etc/profile so that our
# tests pick it up too).
ENV COMPOSER_BIN /root/.composer/vendor/bin
ENV PATH "$COMPOSER_BIN:$PATH"
RUN echo "" >> /etc/profile
RUN echo "PATH=$COMPOSER_BIN:\$PATH" >> /etc/profile

# Startup settings.
ADD ./conf/supervisor/soe.conf /etc/supervisor/conf.d/soe.conf

WORKDIR /var/www

# HTTP, HTTPS, PimpMyLog & Xdebug.
EXPOSE 80 443 8000 9000

CMD ["/usr/bin/supervisord", "-n"]
