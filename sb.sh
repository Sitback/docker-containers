#!/usr/bin/env bash

##
# Comapability checks
##
if ! [ -x "$(type -P boot2docker)" ]; then
  echo "ERROR: script requires boot2docker"
  echo "For Mac try 'brew install boot2docker'"
  exit 1
fi

##
# Conatiner to target
##
C_NAME=$1

##
# Options
##
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

##
# Functions
##
start() {

  if exists ; then

    echo "ERROR: $C_NAME already exits"
    echo "       - try 'sb $C_NAME (restart|stop) instead"

  else
    # Run image and mount current dir as doc root
     ID=$(docker run -d \
       --net=host \
       -v `pwd`:/var/www/vhosts/mysite.com \
       --name="$C_NAME" \
       -t docker/web) 
       
    if [[ -n $ID ]]; then

      #echo 'container ID:'
      echo "$C_NAME running in container $ID"

      # Add correct localbox host record for MySQL
      IP=$(ifconfig vboxnet0 | grep inet | awk '{ print $2 }')

      docker exec -d $ID sh -c "echo '$IP localbox' >> /etc/hosts"

    fi
  fi

}

stop() {

  if exists ; then

    docker kill $C_NAME
    docker rm $C_NAME

    echo Stopped: $C_NAME

  fi

}

execcommand() {
  docker exec -d $C_NAME $execom

  echo "Executed: $ $3 in $C_NAME"
}

exists() {
  
  if ! [[ -n $(docker inspect $C_NAME) ]]; then
    echo "ERROR: Docker project doesn't exist"
    return 1
  fi

  return 0
}

# Run project in docker
#if [ $run == 'true' ]; then
if [ $2 == 'start' ]; then

  start
  
fi

# Stop current project
if [ $2 == 'stop' ]; then

 stop
  
fi

if [ $2 == 'restart' ]; then

  stop
  start
  
fi

# Exec in current project
if [ $2 == 'exec' ]; then

  execcommand
  
fi



