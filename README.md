# Docker Web Containers

This is a set of Dockerfiles used to build containers base/SOE containers on [my container registry](https://registry.hub.docker.com/u/chinthakagodawita/).

**Don't use this project directly, see [chinthakagodawita/docker-hat](https://github.com/chinthakagodawita/docker-hat) instead.**

## Current containers

* base
    * Ubuntu 12.04
    * Ubuntu 14.04
* soe
    * PHP 5.3 (uses base:ubuntu-12.04)
    * PHP 5.4 (uses base:ubuntu-12.04)
    * PHP 5.5 (uses base:ubuntu-14.04)

## Build prerequisites
* Docker (tested on 1.7+)

## Build instructions
_Update this once `dh build` (chinthakagodawita/docker-hat#3) has been implemented._

Make sure your Docker host is running.

Clone this project and `cd` into the image you wish to build (e.g. 'base/ubuntu-14.04').

Run:

```bash
docker build -t chinthakagodawita/base:ubuntu-14.04 .
```

To push to the Docker registry, run:

```bash
docker push chinthakagodawita/base:ubuntu-14.04
```
