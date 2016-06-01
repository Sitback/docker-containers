# Container for running/testing EmberJS applications.
FROM sitback/base:ubuntu-14.04
MAINTAINER Chinthaka Godawita <chin@sitback.com.au>

# Google's stable Chrome repos.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# Add node 5.x repos via nodesource.
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -

# Node 5.x & Chrome + XVFB for headless browser support.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs xvfb google-chrome-stable

# Ember global requirements.
RUN npm install -g bower ember-cli

# Setup application base directory.
RUN mkdir -p /server
WORKDIR /server
