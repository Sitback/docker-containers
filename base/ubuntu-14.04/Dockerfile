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

# OpenSSH.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server

# Nano & telnet (just in case).
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install nano telnet

# *.dev certificates
RUN mkdir /root/certs
COPY ./conf/certs/dev-self-signed-ssl.crt /root/certs/dev-self-signed-ssl.crt
COPY ./conf/certs/dev-self-signed-ssl.key /root/certs/dev-self-signed-ssl.key
