# PHP 5.4 on Centos container.
FROM sitback/base:centos-7
MAINTAINER Tarun Bhargav<tarun.bhargav@sitback.com.au>

# Install all packages.
RUN yum -y --setopt=tsflags=nodocs update  && yum clean all

## Apache.
RUN yum -y install httpd  && yum clean all

## Memcached.
RUN yum -y install memcached  && yum clean all

## MySQL client.
RUN yum -y install mariadb  && yum clean all

## mod SSL & openssl
RUN yum -y install mod_ssl openssl && yum clean all

# Configure Apache.
COPY ./conf/httpd/httpd-vhosts.conf /etc/httpd/conf.d/vhosts.conf

# Install & configure PHP.
RUN yum -y --setopt=tsflags=nodocs update
RUN yum -y install \
  php \
  php-gd \
  php-devel \
  php-mcrypt \
  php-mysql \
  php-memcached \
  php-apc \
  php-soap \
  php-pear

# Configure PHP.
COPY ./conf/php/30-overrides.ini /etc/php.d/30-overrides.ini
COPY ./conf/php/10-php.conf /etc/httpd/conf.modules.d/10-php.conf

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
COPY ./conf/supervisor/php.conf /etc/supervisor/conf.d/php.conf
COPY ./conf/supervisor/supervisord.conf /etc/supervisor/supervisord.conf

# HTTP.
EXPOSE 80

WORKDIR /var/www

CMD ["/usr/bin/supervisord", "-n"]
