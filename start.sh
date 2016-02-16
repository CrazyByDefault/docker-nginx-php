#!/bin/bash

# stop existing services
/usr/sbin/service php5-fpm stop
/usr/sbin/service nginx stop

# use supervisor to start processes
/usr/local/bin/supervisord -n -c /etc/supervisor.conf
