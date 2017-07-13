#!/bin/bash

# auth basic
cat <<EOF > /var/www/html/.htaccess
AuthType Basic
AuthName "Please authenticate"
AuthUserFile /var/www/html/.htpasswd
Require valid-user
EOF

echo $AUTH | tr ' ' '\n' > /var/www/html/.htpasswd


if [ -z "$MYSQL_HOST" ] ; then
    sed -i 's/localhost/mysql/g' /var/www/html/config.inc.php ;\
else
    sed -i "s/localhost/$MYSQL_HOST/g" /var/www/html/config.inc.php ;\
fi

if [ "$SSL" == "on" ] ; then
    sed -i "s/\?>/\$cfg['ForceSSL'] = true;\n\?>/g" /var/www/html/config.inc.php
fi


exec "$@"
