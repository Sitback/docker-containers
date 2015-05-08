#/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor \
openssh-server \
apache2 \
php5 \
libapache2-mod-php5 \
php5-mysql \
dnsmasq \
php-pear \
php5-dev \
libcurl3-openssl-dev
