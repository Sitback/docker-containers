FROM centos:7

# Increment this to trigger a full rebuild.
ENV DC_BASE_VERSION 'CentOS-7-1.0.5'

RUN yum -y --setopt=tsflags=nodocs update 

# Install delta RPM first to allow delta downloads.
RUN yum -y install deltarpm

# Install required packages.

RUN yum -y install epel-release \
 gcc \
 gcc-c++ \
 make \
 openssl-devel \
 kernel-devel \
 autoconf \
 automake \
 telnet \
 rsync \
 wget \
 nano \
 net-tools \
 git \
 vim \
 file \
 unzip 
 
# These need dependencies from above and can't run as part of the same command
# for some reason.
RUN yum -y install python-pip python-setuptools && yum clean all

# Set Local Time (AEST)
RUN unlink /etc/localtime && ln -s /usr/share/zoneinfo/Australia/Sydney /etc/localtime

# Supervisord installation
RUN mkdir -p /var/log/supervisor/
RUN easy_install \
		'supervisor == 3.3.2' \
		'supervisor-stdout == 0.1.1' 

# Startup settings.
COPY ./conf/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./conf/supervisor/base.conf /etc/supervisor/conf.d/base.conf
