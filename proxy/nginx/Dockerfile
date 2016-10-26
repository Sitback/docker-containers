# Basic nginx container that port forwards to port 80 on a linked 'app'
# container.
FROM sitback/base:ubuntu-16.04
MAINTAINER Chinthaka Godawita <chin@sitback.com.au>

# Install all packages.
RUN apt-get update

## nginx.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx

# Forward access and error logs to the Docker log collector
RUN ln -sfv /dev/stdout /var/log/nginx/access.log
RUN ln -sfv /dev/stderr /var/log/nginx/error.log

# Remove default config.
RUN rm -v /etc/nginx/nginx.conf

# Add custom nginx config.
ADD ./conf/nginx/nginx.conf /etc/nginx/nginx.conf

# Startup settings.
ADD ./conf/supervisor/nginx.conf /etc/supervisor/conf.d/nginx.conf

# HTTP only.
EXPOSE 80

CMD ["/usr/bin/supervisord", "-n"]
