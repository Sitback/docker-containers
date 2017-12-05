# web-containers
[![Build Status](https://img.shields.io/circleci/project/dockerdepot/web-containers/master.svg)](https://circleci.com/gh/dockerdepot/web-containers)

This is a set of Dockerfiles used to build all containers on [our container registry](https://registry.hub.docker.com/u/dockerdepot/).

## Current containers

* [base](https://hub.docker.com/r/dockerdepot/base/)
    * Ubuntu 14.04
    * Ubuntu 16.04
* [php](https://hub.docker.com/r/dockerdepot/php/)
    * 5.5 (from base:ubuntu-14.04)
    * 5.6 (from base:ubuntu-14.04)
    * 7.0 (from base:ubuntu-16.04)
    * 7.1 (from base:ubuntu-16.04)
    * 7.2 (from base:ubuntu-16.04)
* [soe](https://hub.docker.com/r/dockerdepot/soe/)
    * PHP 5.5 (from php:5.5)
    * PHP 5.6 (from php:5.6)
    * PHP 7.0 (from php:7.0)
    * PHP 7.1 (from php:7.1)
    * PHP 7.2 (from php:7.2)
* [ci](https://hub.docker.com/r/dockerdepot/ci/)
    * PHP 5.5 (from soe:5.5)
    * PHP 5.6 (from soe:5.6)
    * PHP 7.0 (from soe:7.0)
    * PHP 7.1 (from soe:7.1)
    * PHP 7.2 (from soe:7.2)
* [proxy](https://hub.docker.com/r/dockerdepot/proxy/)
    * HAProxy (for Node.JS) (from base:ubuntu-16.04)
    * nginx (from base:ubuntu-16.04)
    * nginx (for Node.JS) (from proxy:nginx)
* [solr](https://hub.docker.com/r/dockerdepot/solr/)
    * 5.3.x (from base:ubuntu-16.04)
* [node](https://hub.docker.com/r/dockerdepot/node/)
    * base (6.x) (from base:ubuntu-16.04)
    * ember (for testing) (from node:base)
* [elasticsearch](https://hub.docker.com/r/dockerdepot/elasticsearch/)
    * 2.4.x (from elasticsearch:2.4, **for local development use only, do not use for production deployments!**)

## Build prerequisites
* Docker (tested on 1.7+)

## Build instructions
Make sure your Docker host is running.

Clone this project and `cd` into the image you wish to build (e.g. 'base/ubuntu-14.04').

Run:

```bash
docker build -t dockerdepot/base:ubuntu-14.04 .
```

To push to the Docker registry, run:

```bash
docker push dockerdepot/base:ubuntu-14.04
```
