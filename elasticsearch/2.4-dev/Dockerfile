FROM elasticsearch:2.4
MAINTAINER Chinthaka Godawita <chin@sitback.com.au>

# Install GUI for development.
RUN bin/plugin install mobz/elasticsearch-head

# Change entrypoint to allow running as root for macOS.
ENTRYPOINT elasticsearch -Des.insecure.allow.root=true
