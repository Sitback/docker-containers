#!/usr/bin/env bash

mkdir ~/.docker
echo "{\"auths\": {\"https://index.docker.io/v1/\": {\"auth\": \"$DOCKER_HUB_TOKEN\", \"email\": \"chin.godawita@me.com\"} } }" > ~/.docker/config.json
