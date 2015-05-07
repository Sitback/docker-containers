docker-web
==========

##### Usage

Before you start, add a host record on your Mac for the MySQL host:

$ echo "$(ifconfig vboxnet0 | grep inet | awk '{ print $2 }') localbox" >> /etc/hosts


The sb.sh is the start of a CLI wrapper for common tasks when running a web project in docker.

Current functionality:
 - Run a prodject in a container:
 	-- cd /myproduct/dir
 	-- sb.sh -r (will run a container and mount your site doc-root)
 	-- project should be avalible at mysite.com


##### Networking

You're vbox only needs the default vboxnet0 network and the setting should look like this:

![alt tag](https://raw.github.com/paulhudson/docker-web/dev/Docs/img/vbox-network-settings.png)

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

docker run -d -p 8080:80 docker/web

#### Run in docker
docker run -i -t docker/web /bin/bash

#### Connect to Container (boot2docker)
Determine boot2docker IP to point your domain to:

$ boot2docker ip

You could do something like:
echo "$(boot2docker ip) mysite.com" >> /etc/hosts

#### Using Xdebug
Port forward:
VBoxManage controlvm boot2docker-vm natpf1 "xdebug,tcp,127.0.0.1,9000,,9000"

#### MySQL

Symlink you mysql data dir:

$ ln -s /usr/local/var/mysql /Users/huders2000/mysql


Create a data only container, mounting your simlink

$ docker create --name mysql_data -v /Users/huders2000/mysql mysql
$ docker create --name mysql_data -v /usr/local/var/mysql/ mysql:5.5


Pull and run the MySQL container mounting the volume fromt the mysql_data container

$ docker run --name mysql --volumes-from mysql_data -v /var/lib/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=goldcat99 -d -p 3306:3306 mysql:5.5


Run web container, linking it to the MySQL container

Run docker with:

$ docker run -i --link mysql:mysql -p 8080:80 -v /Users/huders2000/Documents/sites/sitback/woolies/dev:/var/www/vhosts/mysite.com -t docker/web /bin/bash



#### @todo
- variablize:
  - {{-DOMAIN-}} (openssl.conf)
  - ServerAdmin, ServerName (httpd.conf)


#### boot2docket stuff


Port forward:

$ VBoxManage controlvm boot2docker-vm natpf1 "mysql,tcp,127.0.0.1,3306,,3306"


Remove Port Foward:
 
$ VBoxManage modifyvm "boot2docker-vm" --natpf1 delete "mysql"
 
 
 
 - 