FROM wordpress:4.7.1-apache
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y         libmcrypt-dev         libjpeg-dev         libapache2-mod-rpaf         libpng12-dev         ffmpeg         libmagickwand-dev     && rm -rf /var/lib/apt/lists/*     && docker-php-ext-install mcrypt pdo_mysql mysqli

RUN a2enmod rpaf
RUN sed -i -e "s#127.0.0.1 ::1#127.0.0.1 ::1 172.18.0.1 172.19.0.1 172.20.0.1 172.21.0.1 172.22.0.1 172.23.0.1 172.24.0.1 172.25.0.1 172.26.0.1 172.27.0.1 172.28.0.1 172.29.0.1 172.30.0.1 172.31.0.1#g" /etc/apache2/mods-enabled/rpaf.conf

RUN pecl install imagick && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x /usr/local/bin/wp
