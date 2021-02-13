#!/bin/bash
sed -i "s/short_open_tag=Off/short_open_tag=On/" /etc/php/5.6/apache2/php.ini
sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
echo 'xdebug.remote_enable=On' >> /etc/php/5.6/apache2/php.ini
echo 'xdebug.remote_autostart=On' >> /etc/php/5.6/apache2/php.ini
echo 'xdebug.remote_host=host.docker.internal' >> /etc/php/5.6/apache2/php.ini

service mysql start

Q1="GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '1234';"
Q2="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}"

mysql -uroot -p1234 -e "$SQL"

#TODO: Add create table scripts with some essential data
#TODO: Add script for update offers expiration

apt-get update
apt-get -y install php5.6-xml
apt-get -y install php5.6-xdebug

/usr/sbin/apachectl -DFOREGROUND -k start -e debug
