# PHP 5.5 container, optimised for Continuous Integration.

FROM chinthakagodawita/soe:php5.5
MAINTAINER Chinthaka Godawita <chin.godawita@me.com>

# Install all packages.
RUN apt-get update

## MySQL.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

# Configure MySQL (installed with user:root and no password).
RUN mysql_install_db
ADD ./conf/mysql/ci_overrides.cnf /etc/mysql/conf.d/ci_overrides.cnf

# Log to stdout/stderr.
RUN ln -sfv /dev/stdout /var/log/mysql/mysql.log
RUN ln -sfv /dev/stderr /var/log/mysql/error.log

# PHPCS & Coder.
RUN drush pm-download coder-7.x-2.5 --destination=$HOME/.drush
RUN composer global require squizlabs/PHP_CodeSniffer:\<2
RUN drush cache-clear drush

# Startup settings.
ADD ./conf/supervisor/ci.conf /etc/supervisor/conf.d/ci.conf

# Prevent socat from taking over the MySQL socket.
RUN perl -pi -e 'BEGIN{undef $/;} s/(\[program:socat.*autostart=)true/$1false/sgm' /etc/supervisor/conf.d/soe.conf
