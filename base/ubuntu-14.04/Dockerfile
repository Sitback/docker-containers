# Base for most of the Docker containers here.
FROM chinthakagodawita/ubuntu:14.04
MAINTAINER Chinthaka Godawita <chin@sitback.com.au>

# Increment this to trigger a full rebuild.
ENV DC_BASE_VERSION 'ubuntu-14.04-3.0.8'

# Update repositories and make sure we're on the latest 14.04 release.
RUN apt-get -y --fix-missing update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade

# Set timezone to be AEST/AEDT.
RUN echo "Australia/Sydney" > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Supervisord (should be configured in any containers that inherit this base).
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor \
  software-properties-common \
  python-setuptools \
  build-essential \
  autoconf \
  automake \
  curl \
  telnet \
  rsync \
  wget \
  nano \
  vim \
  net-tools \
  git \
  unzip \
  cron

# Cleanup apt installs.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# stdout helper for supervisord.
RUN easy_install supervisor-stdout

# Startup settings.
ADD ./conf/supervisor/base.conf /etc/supervisor/conf.d/base.conf
