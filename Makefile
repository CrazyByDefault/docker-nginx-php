devel: Dockerfile nginx.conf
	@docker build -t activatedgeek/nginx-php:latest .

run:
	@docker run -d -p 8080:80 --name test-nginx-php activatedgeek/nginx-php:latest

kill:
	@docker rm -f test-nginx-php
