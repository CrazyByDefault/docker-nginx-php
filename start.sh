#!/bin/bash

# stop existing services
/usr/sbin/service php5-fpm stop
/usr/sbin/service nginx stop

/bin/ps -ef | grep nginx

/bin/ps -ef | grep php5-fpm

/usr/local/bin/supervisord -n -c /etc/supervisor.conf
