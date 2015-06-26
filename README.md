docker-web
==========

##### Host Setup and Install

Clone this project, cd into the project dir and then:

###### 1. Add a host record on your Mac for the MySQL host:

$ echo "$(ifconfig vboxnet0 | grep inet | awk '{ print $2 }') localbox" >> /etc/hosts

###### 2. Add alias for the sb.sh wrapper tools

$ echo 'alias sb="`pwd`/sb.sh"' >> ~/.bash_profile

###### 3. Build Docker Image

$ docker build -t sitback/web .

###### 4. Expose local MySQL Host

Change your DB hosting in settings.php (or equvilant) from 127.0.0.1|localhost to localbox


##### Usage

####### SB Wrapper

The sb.sh is very simple CLI wrapper for common docker tasks. 

It is not an orchastration tool, other projects do that. sb.sh should only be:

- a 'time saver'
- intutive set of limited commands
- easy to use for non 'backend' or fullstack devs
- optional... docker cli is good anyway right :-)

Current functionality:

 - Run a prodject in a container:

 	$ cd my-product/doc-root

 	$ sb [name] start (will run a container and mount your site doc-root)

 	$ sb [name] stop

 	$ sb [name] restart (stops, kills an old container and start a new one)

 	$ sb [name] exec [command] (exec a commain interactively in the container)


##### Networking

You're vbox only needs the default vboxnet0 network and the setting should look like this:

![alt tag](https://raw.github.com/paulhudson/docker-web/master/Docs/img/vbox-network-settings.png)

##### Credits

Man love goes to:

- Sitback.com.au


##### Install Docker on adult versions of linux
rpm -iUvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

yum install docker-io

service docker start

chkconfig docker on


##### Install Docker on Windows

I think you're mad... if you want some love speak to @PierreJoye 


####Remove containers

docker stop $(docker ps -q)

docker rm $(docker ps -aq)

*remove unused images*

docker rmi $(docker images --filter dangling=true --quiet)


### Advanced
###### Rambling notes, wishfully hoping I might help future incarnations of me

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