FROM ubuntu:14.04

MAINTAINER Sanyam Kapoor "1sanyamkapoor@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update &&\
  apt-get install -y software-properties-common &&\
  add-apt-repository ppa:nginx/stable &&\
  PACKAGES="python python-pip nginx php5-fpm php5-cli php5-mcrypt php5-curl php5-mysql php5-sqlite" &&\
  apt-get -y update &&\
  apt-get install -y $PACKAGES &&\
  pip install supervisor &&\
  apt-get remove --purge -y software-properties-common &&\
  apt-get autoremove -y &&\
  apt-get clean &&\
  apt-get autoclean &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf /usr/share/man/*

ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./example.conf /etc/nginx/sites-available/example.conf
ADD ./supervisor.conf /etc/supervisor.conf
ADD ./example.php /app/index.php
ADD ./start.sh /start.sh

RUN php5enmod mcrypt &&\
  rm -rf /etc/nginx/conf.d/* &&\
  rm -f /etc/nginx/sites-available/default &&\
  chmod 755 /etc/nginx/sites-available/example.conf &&\
  ln -s /etc/nginx/sites-available/example.conf /etc/nginx/sites-enabled/example.conf &&\
  update-rc.d -f nginx remove &&\
  update-rc.d -f php5-fpm remove &&\
  service nginx stop &&\
  service php5-fpm stop &&\
  mkdir -p /etc/nginx/ssl &&\
  mkdir -p /app &&\
  chmod -R 755 /app &&\
  apt-get remove -y --purge python-pip

VOLUME ["/etc/nginx/ssl", "/app"]

EXPOSE 80
EXPOSE 443

CMD ["/bin/bash", "start.sh"]
