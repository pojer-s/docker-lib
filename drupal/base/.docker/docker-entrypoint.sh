#!/usr/bin/env bash

if [ -z "$MYSQL_HOST" ] || [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ] ; then
    echo"You need to specify env MYSQL_HOST MYSQL_USER MYSQL_PASSWORD MYSQL_DATABASE"
    exit 1
fi

cat <<EOF > /var/www/html/sites/default/settings.php
<?php
\$databases = array (
  'default' =>
  array (
    'default' =>
    array (
      'database' => '$MYSQL_DATABASE',
      'username' => '$MYSQL_USER',
      'password' => '$MYSQL_PASSWORD',
      'host' => '$MYSQL_HOST',
      'port' => '3306',
      'driver' => 'mysql',
      'prefix' => '',
    ),
  ),
);
\$update_free_access = FALSE;
\$drupal_hash_salt = 'g5DcdxqCD8KS0621xBJkF1hjXn5Xd_Cu7y4Do6eo_yQ';
ini_set('session.gc_probability', 1);
ini_set('session.gc_divisor', 100);
ini_set('session.gc_maxlifetime', 200000);
ini_set('session.cookie_lifetime', 0);
\$conf['404_fast_paths_exclude'] = '/\/(?:styles)|(?:system\/files)\//';
\$conf['404_fast_paths'] = '/\.(?:txt|png|gif|jpe?g|css|js|ico|swf|flv|cgi|bat|pl|dll|exe|asp)\$/i';
\$conf['404_fast_html'] = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML+RDFa 1.0//EN" "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><title>404 Not Found</title></head><body><h1>Not Found</h1><p>The requested URL "@path" was not found on this server.</p></body></html>';
EOF

exec "$@"
