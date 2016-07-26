# nginx-gunicorn-flask

FROM alpine:3.4
MAINTAINER Sven M. Resch <sven.resch@beanstream.com>

# Install platform dependencies --> removed python-dev build-base
RUN apk add --update \
    python py-pip \
    nginx supervisor \
    openssl ca-certificates \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*

RUN pip install gunicorn

# Setup flask application
RUN mkdir -p /deploy/app
COPY app /deploy/app
RUN pip install -r /deploy/app/requirements.txt

# Setup nginx
RUN mkdir -p /run/nginx
RUN mkdir -p /etc/nginx/sites-available
RUN mkdir /etc/nginx/sites-enabled
RUN rm -f /etc/nginx/sites-enabled/default
COPY flask.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/flask.conf /etc/nginx/sites-enabled/flask.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Setup supervisord
RUN mkdir -p /var/log/supervisor/conf.d
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY gunicorn.conf /etc/supervisor/conf.d/gunicorn.conf

# Start processes
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
