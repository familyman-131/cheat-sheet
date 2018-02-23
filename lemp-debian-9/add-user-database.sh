#!/bin/bash
####
if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi
####
NAME="plastics"
#############################
RAND="head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12"
PASS=$(eval $RAND)
#PASS="***********"
DB_ADM=`grep -m 1 user  /etc/mysql/debian.cnf | awk '{ print $3}'`
DB_PASS=`grep -m 1 password  /etc/mysql/debian.cnf | awk '{ print $3}'`
####
${SUDO} mysql -u${DB_ADM} -p${DB_PASS}  <<MYSQL_SCRIPT
CREATE DATABASE ${NAME};
CREATE USER '${NAME}'@'%' IDENTIFIED BY '${PASS}';
GRANT ALL PRIVILEGES ON ${NAME}.* TO '${NAME}'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "MySQL user created."
echo "Username:   ${NAME}"
echo "Password:   ${PASS}"

#${SUDO} mysql -u${DB_ADM} -p${DB_PASS}  <<MYSQL_SCRIPT
#use mysql;
#UPDATE mysql.user SET Password=PASSWORD('**********') WHERE USER='NAME';
#FLUSH PRIVILEGES;
#MYSQL_SCRIPT

