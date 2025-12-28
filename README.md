danielphil.github.io
====================

This is my infrequently updated blog that I use GitHub pages to host. The site itself is built with Jekyll and it uses the very nice [So Simple Theme](https://github.com/mmistakes/so-simple-theme). It's mostly a collection of random computer related things. Visit the site at https://danielphil.github.io.

To make life easier (and to play with Docker), I've created a Dockerfile for the site that will provide a local Jekyll environment. This saves me from having to install Jekyll and dependencies locally. The Docker image is built automatically courtesy of Docker Hub.

To preview the site locally, clone the repo, `cd` into the directory, then run:
```bash
docker run --rm -p 4000:4000 --volume $PWD:/site/ danielphil/blog-jekyll-server
```
After that, the site should then be accessible at http://localhost:4000/

Building the Docker image
-------------------------

The Docker image was previously built on Docker Hub, but automated builds no longer work there so it now needs to be built manually.

To build:
```bash
docker build --platform=linux/amd64,linux/arm64 -t danielphil/blog-jekyll-server .
```

To test, use the `docker run` command above.

To push the new image to Docker Hub, log into Docker Desktop and then push with:
```bash
docker push danielphil/blog-jekyll-server
```

It might be necessary to delete `Gemfile.lock` if there are issues with dependencies when running the container.