# PHP 7.4 container.
FROM php:7.4-apache-buster

# Increment this to trigger a full rebuild.
ENV DC_PHP_VERSION 'php-7.4-0.0.0'

# Get latest updates and install required libraries
RUN DEBIAN_FRONTEND=noninteractive apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
      autoconf \
      automake \
      build-essential \
      curl \
      default-mysql-client \
      git \
      htop \
      libcurl4-openssl-dev \
      libfreetype6-dev \
      libonig-dev \
      libjpeg-dev \
      libmagickwand-dev \
      libmemcached-dev \
      libpng-dev \
      libxml2-dev \
      memcached \
      nano \
      net-tools \
      python3-setuptools \
      python3-pip \
      rsync \
      software-properties-common \
      supervisor \
      telnet \
      unzip \
      vim \
      wget \
      zip \
      zlib1g-dev

# PHP extensions - always configure before install
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install \
    bcmath \
    curl \
    gd \
    mbstring \
    opcache \
    pdo_mysql \
    xml

# Pear packages
RUN pecl install imagick \
    && pecl install memcached \
    && docker-php-ext-enable imagick memcached

# Configure Apache.
COPY ./conf/apache2/httpd-vhosts.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod vhost_alias rewrite ssl headers

## Fix issue with SSLMutex.
RUN mkdir -p /var/run/apache2

# Configure PHP.
RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini
ADD ./conf/php/30-overrides.ini $PHP_INI_DIR/conf.d/30-overrides.ini

# Drush alias
RUN echo 'alias drush=/var/www/app/vendor/bin/drush' >> ~/.bashrc

# Composer
COPY install_composer.sh /install_composer.sh
RUN /install_composer.sh && rm /install_composer.sh

# Startup settings.
ADD ./conf/supervisor/php.conf /etc/supervisor/conf.d/php.conf

# HTTP.
EXPOSE 80

# HTTPS
EXPOSE 443

WORKDIR /var/www

CMD ["/usr/bin/supervisord", "-n"]
