##
# Makefile for development environments
##

latest: Dockerfile nginx/nginx.conf
	@docker build -t activatedgeek/nginx-php:latest .

run:
	@docker run -d -p 8080:80 \
		-v $(shell pwd)/app:/app:rw \
		--name test-nginx-php \
		--dns=8.8.8.8 \
		activatedgeek/nginx-php:latest

login:
	@docker exec -it test-nginx-php bash

logs:
	@docker logs test-nginx-php

kill:
	@docker rm -f test-nginx-php
