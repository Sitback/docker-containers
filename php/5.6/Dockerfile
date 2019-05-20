# PHP 5.6 container.
FROM sitback/base:ubuntu-14.04

# Install all packages.
RUN apt-get update

## Apache.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2

## Memcached.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install memcached

## MySQL client.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client

# Configure Apache.
COPY ./conf/apache2/httpd-vhosts.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod vhost_alias && a2enmod rewrite && a2enmod ssl && a2enmod headers

## Fix issue with SSLMutex.
RUN mkdir -p /var/run/apache2

# Install & configure PHP.
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
  php5.6 \
  php5.6-gd \
  php5.6-dev \
  php5.6-curl \
  php5.6-mcrypt \
  php5.6-mysql \
  php5.6-memcached \
  php5.6-soap \
  php5.6-xml \
  php-pear

# Installing php-pear causes php7.0-common to be installed which then clobbers
# the php binary used for CLI. This symlink unclobbers it.
RUN update-alternatives --set php /usr/bin/php5.6

# Configure PHP.
ADD ./conf/php/30-overrides.ini /etc/php/5.6/apache2/conf.d/30-overrides.ini
ADD ./conf/php/30-overrides.ini /etc/php/5.6/cli/conf.d/30-overrides.ini

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install drush.
RUN composer global require drush/drush:8.*

# Update PATH to include Composer's bin (also add into /etc/profile so that our
# tests pick it up too).
ENV COMPOSER_BIN /root/.composer/vendor/bin
ENV PATH "$COMPOSER_BIN:$PATH"
RUN echo "" >> /etc/profile
RUN echo "PATH=$COMPOSER_BIN:\$PATH" >> /etc/profile

# Registry rebuild for Drush.
RUN drush @none dl registry_rebuild-7.x

# Startup settings.
ADD ./conf/supervisor/php.conf /etc/supervisor/conf.d/php.conf

# HTTP.
EXPOSE 80

WORKDIR /var/www

CMD ["/usr/bin/supervisord", "-n"]
