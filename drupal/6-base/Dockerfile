FROM pojers/php:5.4-apache

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y  wget libpng12-dev libjpeg-dev libpq-dev libxslt-dev\
    	&& rm -rf /var/lib/apt/lists/* \
        && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
       	&& docker-php-ext-install gd mbstring pdo pdo_mysql mysql mysqli pdo_pgsql zip xsl

RUN  cd ~ ; wget http://ftp.drupal.org/files/projects/drush-7.x-5.9.tar.gz ; tar -zxf drush-7.x-5.9.tar.gz ; ln -s ~/drush/drush /usr/local/bin/drush

ADD .docker/docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
