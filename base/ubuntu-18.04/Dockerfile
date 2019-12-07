# Base for most of the Docker containers here.
FROM ubuntu:18.04

# Increment this to trigger a full rebuild.
ENV DC_BASE_VERSION 'ubuntu-18.04-1.0.0'

# Update repositories and make sure we're on the latest 16.04 release.
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade

# Set timezone to be AEST/AEDT.
# @see https://bugs.launchpad.net/ubuntu/+source/tzdata/+bug/1554806
#RUN ln -fs /usr/share/zoneinfo/Australia/Sydney /etc/localtime && \
#  dpkg-reconfigure -f noninteractive tzdata

# https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive
RUN ln -fs /usr/share/zoneinfo/Australia/Sydney /etc/localtime && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get install -y tzdata && \
  dpkg-reconfigure --frontend noninteractive tzdata

# Supervisord (should be configured in any containers that inherit this base).
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor \
  python-setuptools \
  python-pip \
  build-essential \
  autoconf \
  automake \
  telnet \
  rsync \
  wget \
  curl \
  nano \
  vim \
  net-tools \
  git \
  unzip

# Cleanup apt installs.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# stdout helper for supervisord.
#RUN easy_install supervisor-stdout
RUN pip install supervisor-stdout

# Startup settings.
ADD ./conf/supervisor/base.conf /etc/supervisor/conf.d/base.conf
