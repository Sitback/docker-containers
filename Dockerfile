FROM centos:centos6
MAINTAINER Paul Hudson
RUN yum install wget -y
RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN wget http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
RUN rpm -Uvh epel-release-6*.rpm
RUN rpm -Uvh remi-release-6*.rpm
RUN rpm -Uvh nginx-release-centos-6-0.el6.ngx.noarch.rpm

RUN yum clean all
RUN yum update -y

#RUN curl -sSL https://get.rvm.io | bash -s stable
#RUN source /etc/profile.d/rvm.sh
#RUN rvm install 1.9.3
#RUN rvm use 1.9.3 --default

RUN yum install pcre which htop nano tar git mod_ssl openssl httpd nginx php php-devel php-fpm monit php-mysql -y

RUN chkconfig httpd on

# Generate private key
RUN openssl genrsa -out ca.key 2048

# Generate CSR
RUN openssl req -new -key ca.key -out ca.csr

# Generate Self Signed Key
RUN openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt

# Copy the files to the correct locations
RUN cp ca.crt /etc/pki/tls/certs
RUN cp ca.key /etc/pki/tls/private/ca.key
RUN cp ca.csr /etc/pki/tls/private/ca.csr

#RUN git clone https://github.com/paulhudson/puppet-drupalstack.git && ~/puppet-drupalstack/lib/deploy.sh

#VOLUME ["/Users/huders2000/Documents/sites/hudsondigital/html_site"]

#COPY site /var/www/vhosts/mysite.com/
#COPY httpd.conf /etc/httpd/conf/httpd.conf
#COPY vhost-mysite.com.conf /etc/httpd/conf.d/vhost-mysite.com.conf

# Monit config
COPY monit.conf /etc/monit/monit.conf
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
#CMD ["monit", "-d 10 -Ic /etc/monit.conf"]
CMD ["monit", "-I"]

