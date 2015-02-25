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

####Remove images
docker rmi ID  (you probalby want to keep base images like CentOS)

####Build
docker build -t web .

- '-t' = tag/title
- '.' = dir/url of Dockerfile

#### Run

docker run -p 80:80 paulh/web

#### Run in docker
docker run -i -t paulh/web /bin/bash

#### Connect to Container
Determine IP
boot2docker ip

#### @todo
- variablize:
  - {{-DOMAIN-}} (openssl.conf)
  - ServerAdmin, ServerName (httpd.conf)
  - VOLUME (Dockerfile)