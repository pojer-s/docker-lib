# Create image from Debian Jessie
FROM php:5.6-apache

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y  wget libpng12-dev libjpeg-dev libpq-dev libxslt-dev libapache2-mod-rpaf\
    	&& rm -rf /var/lib/apt/lists/* \
        && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
       	&& docker-php-ext-install gd mbstring pdo pdo_mysql mysql mysqli pdo_pgsql zip xsl

RUN a2enmod rpaf
RUN sed -i -e "s#127.0.0.1 ::1#127.0.0.1 ::1 172.18.0.1 172.19.0.1 172.20.0.1 172.21.0.1 172.22.0.1 172.23.0.1 172.24.0.1 172.25.0.1 172.26.0.1 172.27.0.1 172.28.0.1 172.29.0.1 172.30.0.1 172.31.0.1#g" /etc/apache2/mods-enabled/rpaf.conf

RUN  cd ~ ; wget http://ftp.drupal.org/files/projects/drush-7.x-5.9.tar.gz ; tar -zxf drush-7.x-5.9.tar.gz ; ln -s ~/drush/drush /usr/local/bin/drush

ADD .docker/docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
