FROM php:5.6-apache

# install the PHP extensions we need
RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y \
        libjpeg-dev \
        libpng12-dev \
        libxml2-dev \
        libbz2-dev \
        libcurl4-gnutls-dev \
        unzip \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    \
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
    docker-php-ext-install gd mysqli opcache session mbstring xml bz2 zip curl json

# TODO consider removing the *-dev deps and only keeping the necessary lib* packages

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

    RUN { \
            echo 'upload_max_filesize=64M'; \
            echo 'post_max_size=64M'; \
        } > /usr/local/etc/php/conf.d/phpmyadmin.ini

RUN a2enmod rewrite expires

WORKDIR /var/www/html

ENV PHPMYADMIN_VERSION 4.0.10.20

RUN set -ex; \
    curl -o phpmyadmin.zip -fSL "https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.zip"; \
    unzip phpmyadmin.zip -d /var/www/html; \
    mv /var/www/html/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages/* /var/www/html/ ;\
    rmdir /var/www/html/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages ;\
    rm phpmyadmin.zip; \
    cp /var/www/html/config.sample.inc.php /var/www/html/config.inc.php ;\
    sed -i 's/a8b7c6d/tesh2da4naicohL0eig1oogh5zith4aij0Oos0Chee/g' /var/www/html/config.inc.php ;\
    chown -R www-data:www-data /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
