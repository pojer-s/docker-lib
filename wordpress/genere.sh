#!/usr/bin/env bash

cd `dirname $0`

for i in 4.5.3-apache 4.7.2-apache 4.7.3-apache 4.7.1-apache 4.7.0-apache 4.6.1-apache ; do
    mkdir -p "$i-wp"
    cd "$i-wp"
    cat <<EOF > Dockerfile
FROM wordpress:$i

RUN apt-get update && apt-get install -y libmcrypt-dev libjpeg-dev libpng12-dev libmagickwand-dev && docker-php-ext-install mcrypt pdo_mysql mysqli
RUN pecl install imagick && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x /usr/local/bin/wp
EOF
    cat <<EOF > Makefile
NAME = pojers/wordpress
VERSION = $i-wp

.PHONY: all build tag_latest release

all: build

build:
	docker build -t \$(NAME):\$(VERSION) .

release:
	@if ! docker images \$(NAME) | awk '{ print \$\$2 }' | grep -q -F \$(VERSION); then echo "\$(NAME) version \$(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push \$(NAME)

clean:
	docker rmi \$(NAME):\$(VERSION)
EOF
    make
    make release
    make clean
    cd ..
done
