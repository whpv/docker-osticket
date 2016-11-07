#!/bin/bash

install /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
echo "${TIMEZONE}" > /etc/timezone

echo "Install osticket v${OSTICKET_VERSION}"
if [ ! -d "/var/www/localhost/htdocs" ]; then
  mkdir -pv /var/www/localhost/htdocs
fi
wget -nv -O /osTicket.zip http://osticket.com/sites/default/files/download/osTicket-v${OSTICKET_VERSION}.zip
unzip /osTicket.zip -d /var/www/localhost/htdocs

echo "Download languages packs"
wget -nv -O /var/www/localhost/htdocs/upload/include/i18n/fr.phar http://osticket.com/sites/default/files/download/lang/fr.phar
wget -nv -O /var/www/localhost/htdocs/upload/include/i18n/ar.phar http://osticket.com/sites/default/files/download/lang/ar.phar
wget -nv -O /var/www/localhost/htdocs/upload/include/i18n/pt_BR.phar http://osticket.com/sites/default/files/download/lang/pt_BR.phar
wget -nv -O /var/www/localhost/htdocs/upload/include/i18n/it.phar http://osticket.com/sites/default/files/download/lang/it.phar
wget -nv -O /var/www/localhost/htdocs/upload/include/i18n/es_ES.phar http://osticket.com/sites/default/files/download/lang/es_ES.phar
wget -nv -O /var/www/localhost/htdocs/upload/include/i18n/de.phar http://osticket.com/sites/default/files/download/lang/de.phar



echo "Configure php"
sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php5/php.ini
sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php5/php.ini
sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php5/php.ini
sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php5/php.ini
sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php5/php.ini
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php5/php.ini

echo "Clean..."
mv /var/www/localhost/htdocs/upload/* /var/www/localhost/htdocs/
rm /var/www/localhost/htdocs/upload
rm /var/www/localhost/htdocs/index.html
rm -v /osTicket.zip
chmod -R 755 /var/www/localhost/htdocs/*

echo "Starting daemon... ($@)"
if [ ! -d "/run/apache2" ]; then
  mkdir -pv /run/apache2
fi

echo "Configure osticket"
if [ ! -f "/var/www/localhost/htdocs/include/ost-config.php" ]; then
  mv -v /var/www/localhost/htdocs/include/ost-sampleconfig.php /var/www/localhost/htdocs/include/ost-config.php
  chmod 0666 /var/www/localhost/htdocs/include/ost-config.php
else
  echo "ost-config.php already exist"
fi
touch /var/log/apache2/access.log /var/log/apache2/error.log
tail -f /var/log/apache2/*.log &
exec "$@"
