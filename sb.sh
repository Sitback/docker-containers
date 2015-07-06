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

while getopts 'h' flag; do
  case "${flag}" in
    h) helpflag='true' ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

if [ $helpflag == 'true' ] || [ $# == 0 ]; then
  echo " "
  echo "SB Docker Tool"
  echo " "
  echo "options:"
  echo "-h, --help                    show this help"
  echo "sb [name] run                 run project in docker"
  echo "sb [name] stop                stop the project's docker container"
  echo "sb [name] restart             restart the project's docker container"
  echo "sb [name] exec [command]      execute a command in the project container tty"
  echo " "

  exit 0
fi

##
# Functions
##
start() {

  if exists ; then

    echo "ERROR: $C_NAME already exists"
    echo "       - try 'sb $C_NAME (restart|stop) instead"

  else
    # Run image and mount current dir as doc root
     ID=$(docker run -d \
       --net=host \
       -v `pwd`:/var/www \
       --name="$C_NAME" \
       -t sitback/web)

    if [[ -n $ID ]]; then

      echo "$C_NAME running in container $ID"

      # Add correct localbox host record for MySQL
      IP=$(ifconfig $(VBoxManage showvminfo boot2docker-vm --machinereadable | grep hostonlyadapter | cut -d '"' -f 2) | grep inet | cut -d ' ' -f 2)

      docker exec -d $ID sh -c "echo '$IP localbox' >> /etc/hosts"

      # Add site hostname to apache and hosts file
      docker exec -d $ID sh -c "sed -i -r s/---HOSTNAME---/$C_NAME/ /etc/apache2/sites-enabled/000-default.conf"
      docker exec -d $ID sh -c "sudo apachectl restart"

    else
      echo "ERROR: Failed to start $C_NAME"
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
  docker exec -it $C_NAME $1

  echo "Executed: $1 in $C_NAME"
}

exists() {
  if ! [[ "/$C_NAME" == $(docker inspect --format="{{ .Name }}" $C_NAME) ]]; then
    # Exists
    return 1
  fi

  # Default, Not exits
  return 0
}

# Run project in docker
#if [ $run == 'true' ]; then
if [ "$2" == 'start' ]; then
  start
fi

# Stop current project
if [ "$2" == 'stop' ]; then
 stop
fi

if [ "$2" == 'restart' ]; then
  stop
  start
fi

# Exec in current project
if [ "$2" == 'exec' ]; then
  execcommand $3
fi
