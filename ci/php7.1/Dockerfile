# PHP 7.1 container, optimised for Continuous Integration.
FROM sitback/soe:php7.1
MAINTAINER Sitback <technical@sitback.com.au>

# Install all required packages.
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y php7.1-mbstring \
        && rm -rf /var/lib/apt/lists/*

## MariaDB.
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
  add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.2/ubuntu xenial main' && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get remove -y mysql-client && \
  DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server

# Configure MariaDB (installed with user:root and no password).
RUN mysql_install_db
ADD ./conf/mysql/ci_overrides.cnf /etc/mysql/conf.d/ci_overrides.cnf

# Log to stdout/stderr.
RUN ln -sfv /dev/stdout /var/log/mysql/mysql.log
RUN ln -sfv /dev/stderr /var/log/mysql/error.log

# Disable xdebug (on CLI) for performance reasons.
RUN phpdismod -s cli xdebug

# PHPCS & Coder.
RUN composer global require drupal/coder
RUN phpcs --config-set installed_paths \
  ~/.composer/vendor/drupal/coder/coder_sniffer

# Startup settings.
ADD ./conf/supervisor/ci.conf /etc/supervisor/conf.d/ci.conf

# Prevent socat from taking over the MySQL socket.
RUN perl -pi -e 'BEGIN{undef $/;} s/(\[program:socat.*?autostart=)true/$1false/sgm' /etc/supervisor/conf.d/soe.conf
