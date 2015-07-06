# FROM gig745/web:v6
FROM ubuntu:14.04
MAINTAINER Chinthaka Godawita <chin.godawita@me.com>

# update repositories
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade

# Update /usr/sbin/policy-rc.d
COPY ./root/policy-rc.d /usr/sbin/policy-rc.d

# install packages
ADD ./root/packages.sh /packages.sh
RUN chmod 755 /packages.sh
RUN /packages.sh
RUN rm -f /packages.sh

# DNSMASQ
RUN echo -e "user=root \n\
listen-address=127.0.0.1 \n\
address=/.dev/127.0.0.1 \n\
" >> /etc/dnsmasq.conf
COPY ./root/etc/resolv.conf /etc/resolv.conf
#RUN /etc/init.d/dnsmasq restart

# Install drush
RUN pear channel-discover pear.drush.org
RUN pear install drush/drush

# Setup Xdebug
RUN echo "xdebug.profiler_enable = 0 \n\
xdebug.remote_enable = 1 \n\
xdebug.remote_autostart = 1 \n\
xdebug.remote_connect_back = 1 \n\
xdebug.remote_port = 9000 \n\
xdebug.max_nesting_level = 1000" >> /etc/php5/mods-available/xdebug.ini

# middleware settings
ADD ./root/etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# *.dev certificates
RUN mkdir /root/certs
COPY ./root/certs/dev-self-signed-ssl.crt /root/certs/dev-self-signed-ssl.crt
COPY ./root/certs/dev-self-signed-ssl.key /root/certs/dev-self-signed-ssl.key

# VHost supporting VirtualDocumentRoot /var/www/%-2/htdocs
COPY ./root/etc/apache2/httpd-vhosts.conf /etc/apache2/sites-available/000-default.conf

# Apache
RUN a2enmod vhost_alias
RUN a2enmod rewrite
RUN a2enmod ssl

RUN service apache2 restart

EXPOSE 22 80 3306 9000

CMD ["/usr/bin/supervisord"]
