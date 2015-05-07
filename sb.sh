#!/usr/bin/env bash

if ! [ -x "$(type -P boot2docker)" ]; then
  echo "ERROR: script requires boot2docker"
  echo "For Mac try 'brew install boot2docker'"
  exit 1
fi

run='false'
helpflag='false'

while getopts 'rh' flag; do
  case "${flag}" in
    r) run="true" ;;
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

  exit 0
fi

# Run project in docker
if [ $run == 'true' ]; then

	 docker run -d \
	   --net=host \
	   -v `pwd`:/var/www/vhosts/mysite.com \
	   -t docker/web

  # docker run -d \
  #   --add-host=localbox:$(ifconfig vboxnet0 | grep inet | awk '{ print $2 }') \
  #   -v `pwd`:/var/www/vhosts/mysite.com \
  #   -t docker/web

  #docker run -i --rm   --add-host=localbox:$(ifconfig vboxnet0 | grep inet | awk '{ print $2 }')   --net=host   -v /Users/huders2000/Documents/sites/sitback/woolies/dev:/var/www/vhosts/mysite.com   -t docker/web /bin/bash
fi