FROM php:5.6-apache

# install the PHP extensions we need
RUN set -ex; \
    apt-get update; \
    apt-get install -y \
        libjpeg-dev \
        libpng12-dev \
        libicu-dev \
        libcurl4-gnutls-dev \
        libldap2-dev \
        libxml2-dev \
        openssl \
        git \
        unzip \
        wget \
    ; \
    rm -rf /var/lib/apt/lists/* ; \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ ; \
    docker-php-ext-install ldap gettext xml zip

RUN { \
    echo 'date.timezone = Europe/Paris'; \
    echo 'memory_limit = 256M'; \
    } > /usr/local/etc/php/conf.d/php.ini

RUN a2enmod rewrite headers

RUN cd /tmp ; \
    wget -O ldap-account-manager-6.0.tar.bz2 "https://downloads.sourceforge.net/project/lam/LAM/6.0/ldap-account-manager-6.0.tar.bz2?r=&ts=1499958117&use_mirror=netix"  ; \
    tar xjvf ldap-account-manager-6.0.tar.bz2 ; \
    mv ldap-account-manager-6.0/* /var/www/html ; \
    cp /var/www/html/config/config.cfg.sample  /var/www/html/config/config.cfg ; \
    chown -R www-data: /var/www/html ; \
    rm -rf ldap-account-manager-6.0 ldap-account-manager-6.0.tar.bz2

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
