## nginx-gunicorn-flask

This repository contains files necessary for building a Docker image of
Nginx + Gunicorn + Flask that runs on Alpine Linux.

Alpine Linux is a security-oriented, lightweight Linux distribution based on musl libc and busybox.
https://www.alpinelinux.org

### Base Docker Image

* [alpine:3.4](https://registry.hub.docker.com/_/alpine/)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Clone this repo

```bash
git clone https://github.com/Beanstream/nginx-gunicorn-flask.git
```

3.) Build a local docker image

```bash
cd nginx-gunicorn-flask
docker build -t beanstream/nginx-gunicorn-flask:1.0.0 .
```

### Usage

```bash
docker run -d -p 80:8080 beanstream/nginx-gunicorn-flask
```

After few seconds, open `http://<host>` to see the Flask app.
