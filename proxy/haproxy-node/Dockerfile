# Basic haproxy container that port forwards to port 80 on a linked 'app'
# container.
FROM sitback/base:ubuntu-16.04
MAINTAINER Chinthaka Godawita <chin@sitback.com.au>

# Install all packages.
RUN apt-get update

## haproxy.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y haproxy

# Forward access and error logs to the Docker log collector
#RUN ln -sfv /dev/stdout /var/log/haproxy/access.log
#RUN ln -sfv /dev/stderr /var/log/haproxy/error.log

# Remove default config.
RUN rm -v /etc/haproxy/haproxy.cfg

# Add custom haproxy config.
ADD ./conf/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg

# Startup settings.
ADD ./conf/supervisor/haproxy.conf /etc/supervisor/conf.d/haproxy.conf

# HTTP only.
EXPOSE 80

CMD ["/usr/bin/supervisord", "-n"]
