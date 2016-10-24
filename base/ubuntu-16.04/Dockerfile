# Base for most of the Docker containers here.
FROM chinthakagodawita/ubuntu:16.04
MAINTAINER Chinthaka Godawita <chin@sitback.com.au>

# Increment this to trigger a full rebuild.
ENV DC_BASE_VERSION 'ubuntu-16.04-1.0.0'

# Update repositories and make sure we're on the latest 16.04 release.
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade

# Set timezone to be AEST/AEDT.
RUN timedatectl set-timezone Australia/Sydney

# Supervisord (should be configured in any containers that inherit this base).
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor \
  python-setuptools \
  build-essential \
  autoconf \
  automake \
  telnet \
  rsync \
  wget \
  nano \
  vim \
  net-tools \
  git \
  unzip

# Cleanup apt installs.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# stdout helper for supervisord.
RUN easy_install supervisor-stdout

# Startup settings.
ADD ./conf/supervisor/base.conf /etc/supervisor/conf.d/base.conf
