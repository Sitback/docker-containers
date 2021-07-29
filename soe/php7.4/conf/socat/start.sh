#!/usr/bin/env bash

mkdir -p /var/run/mysqld
rm /var/run/mysqld/mysqld.sock
exec /usr/bin/socat -ls UNIX-LISTEN:/var/run/mysqld/mysqld.sock,fork,mode=0777 TCP4:hostbox:3306
