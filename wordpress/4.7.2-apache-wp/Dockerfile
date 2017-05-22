FROM wordpress:4.7.2-apache

RUN apt-get update && apt-get install -y libmcrypt-dev libjpeg-dev libpng12-dev libmagickwand-dev && docker-php-ext-install mcrypt pdo_mysql mysqli
RUN pecl install imagick && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x /usr/local/bin/wp
