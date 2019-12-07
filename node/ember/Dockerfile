# Container for running/testing EmberJS applications.
FROM sitback/node:base


# Google's stable Chrome repos.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# Chrome + XVFB for headless browser support.
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y xvfb dbus-x11 google-chrome-stable

# Ember global requirements.
RUN npm install -g bower ember-cli
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

# Setup XVFB daemon.
# ENV DISPLAY :99

# Add custom Chrome run script.
COPY ./conf/bin/google-chrome /usr/local/bin/google-chrome
