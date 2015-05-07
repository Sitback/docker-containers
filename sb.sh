#!/usr/bin/env bash

sb init NAME
sb NAME run
sb NAME stop
sb NAME logs

if ! [ -x "$(type -P boot2docker)" ]; then
  echo "ERROR: script requires boot2docker"
  echo "For Mac try 'brew install boot2docker'"
  exit 1
fi

helpflag='false'
run='false'
stop='false'
execom=''

while getopts 'rhse:' flag; do
  case "${flag}" in
    r) run="true" ;;
    s) stop="true" ;;
    e) execom="" ;;
    h) helpflag='true' ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

if [ $helpflag == 'true' ]; then
  echo " "
  echo "SB Docker Tool"
  echo " "
  echo "options:"
  echo "-h, --help                show this help"
  echo "-r                        Run project in docker"
  echo "-s                        Stop the project's docker container"
  echo "-e [command]              execute a command in the project container"

  exit 0
fi

# Run project in docker
if [ $run == 'true' ]; then

  # Run image and mount current dir as doc root
	 ID=$(docker run -d \
	   --net=host \
	   -v `pwd`:/var/www/vhosts/mysite.com \
	   -t docker/web)

  export PROJECT=$ID

  echo 'container ID:'
  echo $PROJECT

  # Add correct localbox host record for MySQL
  IP=$(ifconfig vboxnet0 | grep inet | awk '{ print $2 }')

  docker exec -d $PROJECT sh -c "echo '$IP localbox' >> /etc/hosts"
  
fi

# Stop current project
if [ $stop == 'true' ]; then

  docker kill $PROJECT
  docker rm $PROJECT

  echo Stopped: $PROJECT
  
fi

# Exec in current project
if [ $execom ]; then

  docker exec -d $PROJECT $execom

  echo "Executed: $ execom in $PROJECT"
  
fi
