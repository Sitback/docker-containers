# Base nodejs container.
FROM sitback/base:ubuntu-16.04


# Add node 6.x via nodesource.
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# Add PM2 for process management.
RUN npm install pm2 -g

# Setup application base directory.
RUN mkdir -p /server
WORKDIR /server
