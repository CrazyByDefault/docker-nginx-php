FROM ubuntu:14.04

MAINTAINER Sanyam Kapoor "1sanyamkapoor@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update &&\
  apt-get install -y software-properties-common &&\
  add-apt-repository ppa:nginx/stable &&\
  PACKAGES="nginx php5-fpm php5-cli php5-mcrypt php5-curl php5-mysql php5-sqlite" &&\
  apt-get -y update &&\
  apt-get install -y $PACKAGES &&\
  php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php &&\
  php composer-setup.php --install-dir=/bin --filename=composer &&\
  php -r "unlink('composer-setup.php');" &&\
  chmod +x /bin/composer &&\
  apt-get remove --purge -y software-properties-common &&\
  apt-get autoremove -y &&\
  apt-get clean &&\
  apt-get autoclean &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf /usr/share/man/*

ADD ./nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./nginx/example.conf /etc/nginx/sites-available/default
ADD ./scripts/start.sh /start.sh

RUN php5enmod mcrypt &&\
  rm -rf /etc/nginx/conf.d/* &&\
  mkdir -p /etc/nginx/ssl &&\
  mkdir -p /app &&\
  chmod -R 755 /app &&\
  chmod 755 /etc/nginx/sites-available/default &&\
  ln -s -f /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

VOLUME /etc/nginx/ssl
VOLUME /app

EXPOSE 80
EXPOSE 443

CMD ["/bin/bash", "start.sh"]
