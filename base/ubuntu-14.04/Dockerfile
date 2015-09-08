# Base for most of the Docker containers here.

FROM ubuntu:14.04
MAINTAINER Chinthaka Godawita <chin.godawita@me.com>

# Update repositories and make sure we're on the latest 14.04 release.
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade

# Supervisord (should be configured in any containers that inherit this base).
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor

# APT management tools.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python-software-properties

# Python easy_install.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python-setuptools

# Essential build tools, required for some software.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
  build-essential \
  autoconf \
  automake

# OpenSSH.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server

# Curl.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install curl

# Nano & telnet (just in case).
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install nano telnet

# Netstat et al.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install net-tools

# stdout helper for supervisord.
RUN easy_install supervisor-stdout

# *.dev certificates
RUN mkdir /root/certs
COPY ./conf/certs/dev-self-signed-ssl.crt /root/certs/dev-self-signed-ssl.crt
COPY ./conf/certs/dev-self-signed-ssl.key /root/certs/dev-self-signed-ssl.key

# Startup settings.
ADD ./conf/supervisor/base.conf /etc/supervisor/conf.d/base.conf
