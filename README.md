docker-web
==========

##### Install Docker
rpm -iUvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

yum install docker-io

service docker start

chkconfig docker on

####Remove containers

docker stop $(docker ps -q)
docker rm $(docker ps -aq)

*remove unused images*
docker rmi $(docker images --filter dangling=true --quiet)

####Remove images
docker rmi ID  (you probalby want to keep base images like CentOS)

####Build
docker build -t web .

- '-t' = tag/title
- '.' = dir/url of Dockerfile

#### Run

docker run -d -p 8080:80 paulh/web

#### Run in docker
docker run -i -t paulh/web /bin/bash

#### Connect to Container (boot2docker)
Determine boot2docker IP to point your domain to:

$ boot2docker ip

You could do something like:
echo "$(boot2docker ip) mysite.com" >> /etc/hosts


#### @todo
- variablize:
  - {{-DOMAIN-}} (openssl.conf)
  - ServerAdmin, ServerName (httpd.conf)
  - VOLUME (Dockerfile)