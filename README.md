docker-reviewboard
==================

Dockerfile project for building a container with reviewboard + ssh access.

## About

This repository contains all needed resources to build a docker image with following features:
* sshd with passwordless login;
* reviewboard with sqlite3 backend, memcached and apache2;
* services configured and runnign via supervisor.

For convenience there is a *./build.sh* command for building image and *./manage.sh* for starting (with proper port mappings), stopping and connecting via ssh, opening web browser.

### Database

This image uses external database using local mount for persistence from [git repo](https://github.com/viliusl/docker-reviewboard/tree/master/data). You can copy it over to proper location, update database location in *manage.sh* script and have fun.

## Usage

You can download [this image](https://index.docker.io/u/viliusl/ubuntu-reviewboard/) from public [Docker Registry](https://index.docker.io/).

And use [manage.sh](https://github.com/viliusl/docker-reviewboard/blob/master/manage.sh) for managing this container or figuring out run, ssh commands.

Happy cooking.
