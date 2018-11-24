danielphil.github.io
====================

This is my infrequently updated blog that I use GitHub pages to host. The site itself is built with Jekyll and it uses the very nice [So Simple Theme](https://github.com/mmistakes/so-simple-theme). It's mostly a collection of random computer related things. Visit the site at https://danielphil.github.io.

To make life easier (and to play with Docker), I've created a Dockerfile for the site that will provide a local Jekyll environment. This saves me from having to install Jekyll and dependencies locally. The Docker image is built automatically courtesy of Docker Hub.

To build the site locally, clone the repo, `cd` into the directory, then run:
```bash
    docker run --rm -p 4000:4000 --volume $PWD:/site/ danielphil/blog-jekyll-server
```
After that, the site should then be accessible at http://localhost:4000/