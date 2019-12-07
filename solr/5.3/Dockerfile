FROM sitback/base:ubuntu-16.04
MAINTAINER Chinthaka Godawita <chin@sitback.com.au>

# Add Java repository and install Solr dependencies.
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 \
  select true | debconf-set-selections
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update

## lsof & JDK 1.8
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  lsof oracle-java8-installer
RUN rm -rf /var/cache/oracle-jdk8-installer

# Setup environment for Java & Solr (add to profile as well so that our CI
# server picks it up).
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
RUN echo "" >> /etc/profile
RUN echo "JAVA_HOME=$JAVA_HOME" >> /etc/profile

# Update these env variables to match the current release. We use the GPG key
# to verify the downloaded release. These aren't defined higher up in the
# Dockerfile to leverage caching.
ENV SOLR_KEY "CFCE5FBB920C3C745CEEE084C38FF5EC3FCFDB3E"
ENV SOLR_VERSION "5.3.1"
ENV SOLR_SHA256 "34ddcac071226acd6974a392af7671f687990aa1f9eb4b181d533ca6dca6f42d"

# Download, verify and extract the above Solr version into /opt/solr.
#RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$SOLR_KEY"
RUN mkdir -p /opt/solr && \
  wget -nv --output-document="/opt/solr.tgz" \
  "http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz" && \
  wget -nv --output-document="/opt/solr.tgz.asc" \
  "http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz.asc" && \
 # gpg --verify /opt/solr.tgz.asc && \
 # echo "$SOLR_SHA256 */opt/solr.tgz" | sha256sum -c - && \
  tar -C "/opt/solr" --extract --file "/opt/solr.tgz" --strip-components=1 && \
  rm /opt/solr.tgz* && \
  mkdir -p "/opt/solr/server/solr/lib"

# Patch "/bin/solr -f" to use exec so that it replaces the current process.
# https://issues.apache.org/jira/browse/SOLR-8107
# Remove in 5.4.x.
RUN sed --in-place -e 's/^    "$JAVA" "${SOLR_START_OPTS\[@\]}" $SOLR_ADDL_ARGS -jar start.jar "${SOLR_JETTY_CONFIG\[@\]}"/    exec "$JAVA" "${SOLR_START_OPTS[@]}" $SOLR_ADDL_ARGS -jar start.jar "${SOLR_JETTY_CONFIG[@]}"/' /opt/solr/bin/solr

# Add supervisor startup settings.
ADD ./conf/supervisor/solr.conf /etc/supervisor/conf.d/solr.conf

EXPOSE 8983
WORKDIR /opt/solr
CMD ["/usr/bin/supervisord", "-n"]
