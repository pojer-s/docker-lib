FROM php:5.6-apache

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libapache2-mod-rpaf \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod rpaf
RUN sed -i -e "s#127.0.0.1 ::1#127.0.0.1 ::1 172.18.0.1 172.19.0.1 172.20.0.1 172.21.0.1 172.22.0.1 172.23.0.1 172.24.0.1 172.25.0.1 172.26.0.1 172.27.0.1 172.28.0.1 172.29.0.1 172.30.0.1 172.31.0.1#g" /etc/apache2/mods-enabled/rpaf.conf

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["apache2-foreground"]
