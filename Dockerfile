FROM centos:centos6
MAINTAINER Paul Hudson
RUN yum install wget -y
RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN wget http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
RUN rpm -Uvh epel-release-6*.rpm
RUN rpm -Uvh remi-release-6*.rpm
RUN rpm -Uvh nginx-release-centos-6-0.el6.ngx.noarch.rpm

ENV STI_SCRIPTS_URL sti

RUN yum clean all
RUN yum update -y

#RUN curl -sSL https://get.rvm.io | bash -s stable
#RUN source /etc/profile.d/rvm.sh
#RUN rvm install 1.9.3
#RUN rvm use 1.9.3 --default

RUN yum install gcc gcc-c++ autoconf automake gd telnet -y

RUN yum install pcre which htop nano tar git mod_ssl openssl httpd nginx php php-devel curl curl-devel php-common php-curl php-soap php-fpm monit mysql php-mysql php-mcrypt php-gd php-pear --enablerepo=remi,remi-php55 -y

RUN chkconfig httpd on

# Install xdebug
RUN pecl install Xdebug

# 
RUN echo -e "[xdebug] \n\
zend_extension=\"/usr/lib64/php/modules/xdebug.so\" \n\
xdebug.remote_enable = 1 \n\
xdebug.remote_autostart = 0 \n\
xdebug.remote_connect_back = 1 \n\
xdebug.remote_port = 9000 \n\
xdebug.max_nesting_level = 1000" >> $(php --ini | grep 'Scan for additional .ini files in:' | awk '{ print $7 }')/xdebug.ini

# Install drush
RUN pear channel-discover pear.drush.org 
RUN pear install drush/drush

# Generate private key
RUN openssl genrsa -out ca.key 2048

# Generate CSR
COPY openssl.conf openssl.conf
RUN openssl req -new -config openssl.conf -out ca.csr

# Generate Self Signed Key
RUN openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt

# Copy certs to Apache
RUN mkdir /etc/httpd/ssl
RUN cp ca.crt /etc/httpd/ssl/ca.crt
RUN cp ca.key /etc/httpd/ssl/ca.key
RUN cp ca.csr /etc/httpd/ssl/ca.csr

#RUN git clone https://github.com/paulhudson/puppet-drupalstack.git && ~/puppet-drupalstack/lib/deploy.sh

#VOLUME ["/Users/huders2000/Documents/sites/hudsondigital/html_site"]

#COPY site /var/www/vhosts/mysite.com/
COPY httpd.conf /etc/httpd/conf/httpd.conf
COPY vhost-mysite.com.conf /etc/httpd/conf.d/vhost-mysite.com.conf

# Monit config
COPY monit.conf /etc/monit/monit.conf
RUN chmod 700 /etc/monit/monit.conf
COPY monit-services.conf /etc/monit.d/monit-services.conf

# Perusio PHP-FPM
RUN mkdir /etc/php5
RUN mkdir /etc/php5/fpm
RUN git clone git://github.com/perusio/php-fpm-example-config php-fpm-example-config
RUN cp -pv ./php-fpm-example-config/fpm/php5-fpm.conf /etc/php5/fpm
RUN cp -rv ./php-fpm-example-config/fpm/pool.d /etc/php5/fpm
RUN service php-fpm restart
RUN chkconfig php-fpm on

EXPOSE 80
EXPOSE 443
EXPOSE 2812

# default command
CMD monit -d 10 -Ic /etc/monit/monit.conf
#CMD ["/usr/bin/monit", "-I"]

