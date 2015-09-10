# Base nodejs container.

FROM chinthakagodawita/base:ubuntu-14.04
MAINTAINER Chinthaka Godawita <chin.godawita@me.com>

# Add node 0.12 via nodesource.
RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
