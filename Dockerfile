FROM centos
MAINTAINER Paul Hudson
RUN yum update -y
RUN yum install wget which htop nano tar git -y
RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN wget http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
RUN rpm -Uvh remi-release-6*.rpm
RUN rpm -Uvh epel-release-6*.rpm
RUN rpm -Uvh nginx-release-centos-6-0.el6.ngx.noarch.rpm
RUN yum clean all

#RUN curl -sSL https://get.rvm.io | bash -s stable
#RUN source /etc/profile.d/rvm.sh
#RUN rvm install 1.9.3
#RUN rvm use 1.9.3 --default

RUN yum install httpd php php-devel nginx php-fpm -y


#RUN git clone https://github.com/paulhudson/puppet-drupalstack.git && ~/puppet-drupalstack/lib/deploy.sh

#VOLUME ["/Users/huders2000/Documents/sites/hudsondigital/html_site"]

COPY site /var/www/vhosts/mysite.com/
COPY httpd.conf /etc/httpd/httpd.conf

# Perusio Nginx
RUN git clone https://github.com/paulhudson/drupal-with-nginx.git drupal-with-nginx
RUN cp -prv ./drupal-with-nginx/* /etc/nginx/

RUN cp /etc/nginx/sites-available/example.com.conf /etc/nginx/sites-available/mysite.com.conf

# Perusio PHP-FPM
RUN mkdir /etc/php5
RUN mkdir /etc/php5/fpm
RUN git clone git://github.com/perusio/php-fpm-example-config php-fpm-example-config
RUN cp -pv ./php-fpm-example-config/fpm/php5-fpm.conf /etc/php5/fpm
RUN cp -rv ./php-fpm-example-config/fpm/pool.d /etc/php5/fpm
RUN service php-fpm restart

RUN git clone https://github.com/perusio/nginx_ensite.git nginx_ensite
RUN cp ./nginx_ensite/nginx_* /usr/sbin
#RUN ls -la ./nginx_ensite
#RUN ls -la ./nginx_ensite/bash_completion.d
#RUN cd ./nginx_ensite/bash_completion.d && source nginx-ensite
#RUN ./nginx_ensite/bash_completion.d/nginx_ensite mysite.com

CMD nginx_ensite mysite.com

RUN nginx -t
RUN service nginx restart

EXPOSE 80
EXPOSE 443
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082
