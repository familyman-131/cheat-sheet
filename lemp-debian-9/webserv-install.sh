#!/bin/bash
####
if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi
####
PHP_MODULES="php7.1-fpm  php7.1-common  php7.1-mbstring php7.1-mcrypt php7.1-xml  php7.1-gd php7.1-imagick  php7.1-curl php7.1-mysql php7.1-pdo php7.1-soap  php7.1-zip  php7.1-bz2 "
SOFT="nginx git sudo nload mariadb-server exim4 curl unzip htop"
####
${SUDO} aptitude update
${SUDO} aptitude upgrade
${SUDO} aptitude install -y ${SOFT} ${PHP_MODULES}
####
#
# adduser deploy
# mkdir sites-enabled
# mkdir sites-available
# mkdir /var/www/%sites%/www|logs/
# nginx and php configs
# chown -R deploy:deploy /var/www
#
# /etc/sudoers
# deploy ALL=NOPASSWD: ALL
