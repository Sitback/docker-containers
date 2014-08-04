docker-web
==========

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