##
# Makefile for development environments
##

latest: Dockerfile nginx/nginx.conf
	@docker build -t crazybydefault/nginx-php:devel .

run:
	@docker run -d -p 8080:80 \
		-v $(shell pwd)/app:/app:rw \
		--name test-nginx-php \
		crazybydefault/nginx-php:devel

login:
	@docker exec -it test-nginx-php sh

logs:
	@docker logs test-nginx-php

kill:
	@docker rm -f test-nginx-php
