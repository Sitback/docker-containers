# Nginx container that proxy forwards to port 3000 on a linked 'app' container.
# Use for Node.js applications, has support for Web Sockets.

FROM chinthakagodawita/proxy:nginx
MAINTAINER Chinthaka Godawita <chin.godawita@me.com>

# Remove default config.
RUN rm -v /etc/nginx/nginx.conf

# Add custom config.
ADD ./conf/nginx/nginx.conf /etc/nginx/nginx.conf
