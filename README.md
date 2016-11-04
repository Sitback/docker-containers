# docker-containers
[![Build Status](https://img.shields.io/circleci/project/Sitback/docker-containers/master.svg)](https://circleci.com/gh/Sitback/docker-containers)

This is a set of Dockerfiles used to build all containers on [our container registry](https://registry.hub.docker.com/u/sitback/).

## Current containers

* [base](https://hub.docker.com/r/sitback/base/)
    * Ubuntu 12.04
    * Ubuntu 14.04
    * Ubuntu 16.04
* [php](https://hub.docker.com/r/sitback/php/)
    * 5.5 (from base:ubuntu-14.04)
    * 5.6 (from base:ubuntu-14.04)
    * 7.0 (from base:ubuntu-16.04)
* [soe](https://hub.docker.com/r/sitback/soe/)
    * PHP 5.3 (from base:ubuntu-12.04)
    * PHP 5.4 (from base:ubuntu-12.04)
    * PHP 5.5 (from php:5.5)
    * PHP 5.6 (from php:5.6)
    * PHP 7.0 (from php:7.0)
* [ci](https://hub.docker.com/r/sitback/ci/)
    * PHP 5.4 (from soe:php5.4)
    * PHP 5.5 (from soe:5.5)
    * PHP 5.6 (from soe:5.6)
    * PHP 7.0 (from soe:7.0)
* [proxy](https://hub.docker.com/r/sitback/proxy/)
    * HAProxy (for Node.JS) (from base:ubuntu-16.04)
    * nginx (from base:ubuntu-16.04)
    * nginx (for Node.JS) (from proxy:nginx)
* [solr](https://hub.docker.com/r/sitback/solr/)
    * 5.3.x (from base:ubuntu-16.04)
* [node](https://hub.docker.com/r/sitback/node/)
    * base (6.x) (from base:ubuntu-16.04)
    * ember (for testing) (from base:ubuntu-14.04)
* [elasticsearch](https://hub.docker.com/r/sitback/elasticsearch/)
    * 2.4.x (from elasticsearch:2.4, **for local development use only, do not use for production deployments!**)

## Build prerequisites
* Docker (tested on 1.7+)

## Build instructions
Make sure your Docker host is running.

Clone this project and `cd` into the image you wish to build (e.g. 'base/ubuntu-14.04').

Run:

```bash
docker build -t sitback/base:ubuntu-14.04 .
```

To push to the Docker registry, run:

```bash
docker push sitback/base:ubuntu-14.04
```
