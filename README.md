# docker-nginx-php

| [![Build Status](https://travis-ci.org/activatedgeek/docker-nginx-php.svg?branch=master)](https://travis-ci.org/activatedgeek/docker-nginx-php) | [![](https://imagelayers.io/badge/activatedgeek/nginx-php:latest.svg)](https://imagelayers.io/?images=activatedgeek/nginx-php:latest 'Get your own badge on imagelayers.io') |
|:-:|:-:|

This is an Alpine-based image to run PHP applications via the
PHP-FPM parser and served via Nginx.

The container contains the following packages:
* `Nginx` (1.8+)
* `PHP` (5.6+) with modules from,
* `Composer` (1.1+)

## Images

* `latest`, `0.2`, `0.2.0` ([Dockerfile](./Dockerfile))
* `0.1`, `0.1.6`

## Usage
Pull the docker image from Docker hub as:
```
> docker pull activatedgeek/nginx-php
```
By default, this will pull the latest image.

Let us create a sample PHP application below, name it
`index.php`.
```php
<?php
  echo phpinfo();
?>
```

Create a folder named `app` on the host and put in
the `index.php`.

To run a test container,
```shell
> docker run -d \
  # expose internal port 80 to host 8080
  -p 8080:80 \
  # mount the application to "/app" folder in container
  -v /path/to/my/app:/app:rw \
  --name test-nginx-php \
  activatedgeek/nginx-php:latest
```

Now point your browser to,
```
http://localhost:8080
```
to see the output.

**NOTE**: `docker-machine` users will need to point to
the correct docker host instead of `localhost`.

Standard configurations have been maintained for Nginx.
By the default configuration, all applications are
served from the `/app` folder. The default configs
are available inside `nginx` folder of repository.

## Using as base image
Here is sample `Dockerfile` to get started,
```Dockerfile
FROM activatedgeek/nginx-php:latest

ADD ./new-nginx-app.conf /etc/nginx/sites-available/default

VOLUME /app

EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord"]
```

## Build
To build the latest image from source, run
```
> make latest
```
