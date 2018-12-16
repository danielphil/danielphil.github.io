---
title:  "Docker Cheat Sheet"
categories: Coding
---

I've been playing with Docker recently, but not enough that I always remember the commands. Here's my cheat sheet for future Docker use.

# Cleaning up

* Remove everything not in use with `docker system prune -a`

# Images
* Pull an image with `docker pull`. For example: `docker pull alpine`
* Remove all images not used by containers with `docker image prune -a`
* `cd` into a directory containing a Dockerfile and build a container with `docker build -t imagename .`

# Containers

* Start a container from an image with `docker run imagename`. Docker will pull the specified image from Docker Hub if you don't have it locally.
* `docker run -it imagename /bin/sh` or `docker run -it imagename /bin/bash` to get an interactive shell into the container.
* Some images specify entrypoints. In this case, override with `docker run -it --entrypoint /bin/sh imagename`
* Usually, you want to use `--rm` when calling `docker run` to have the container automatically deleted when it exits. **Remember that anything you store in the container filesystem will be deleted when the container is stopped!**
* Map a port from the container to your host with `-p 80:4000`. In this example, container port 4000 is mapped to port 80 on the host. *Host first!*
* Create a bind mount with `--volume $PWD:/site/`. In this example, the current host working directory is mapped to `/site/` in the container.