#!/usr/bin/env bash


# if [ -z "$FRA_MYSQL_HOST" ] || [ -z "$FRA_MYSQL_USER" ] || [ -z "$FRA_MYSQL_PASSWORD" ] || [ -z "$FRA_MYSQL_DATABASE" ] ; then
#     echo "You need to specify env FRA_MYSQL_HOST FRA_MYSQL_USER FRA_MYSQL_PASSWORD FRA_MYSQL_DATABASE"
#     exit 1
# fi
#
# if [ -z "$FRA_HTTP_HOST" ] ; then
#     echo "You need to specify env FRA_HTTP_HOST"
#     exit 1
# fi
#
# if [ -z "$FRA_SMTP_HOST" ] ; then
#     echo "You need to specify env FRA_SMTP_HOST"
#     exit 1
# fi
#
# cat <<EOF > /var/www/html/app/config/parameters.yml
# # This file is auto-generated during the composer install
# parameters:
#     database_host: $FRA_MYSQL_HOST
#     database_port: null
#     database_name: $FRA_MYSQL_DATABASE
#     database_user: $FRA_MYSQL_USER
#     database_password: $FRA_MYSQL_PASSWORD
#     mailer_host: $FRA_SMTP_HOST
#     mailer_user: null
#     mailer_password: null
#     mailer_port: 25
#     mailer_auth_mode: null
#     secret: SECRET
#     http_host: $FRA_HTTP_HOST
# EOF

# Ajouter ici les commandes nécessaires à votre solution

exec "$@"
