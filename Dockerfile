FROM crazybydefault/php:latest

MAINTAINER Shashank Varanasi "sasi8998vv@gmail.com"

RUN apk update &&\
  apk add --update nginx supervisor &&\
  rm -rf /var/cache/apk/*

ADD ./nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./nginx/example.conf /etc/nginx/conf.d/example.conf
ADD ./conf/supervisord.conf /etc/supervisord.conf

RUN mkdir -p /app && chmod -R 755 /app /etc/nginx/conf.d

EXPOSE 80 443

ENTRYPOINT ["/usr/bin/supervisord"]
