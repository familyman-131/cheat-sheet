#!/bin/bash
# To add this repository please do:

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

${SUDO} wget -O /etc/apt/trusted.gpg.d/nginx_signing.key http://nginx.org/keys/nginx_signing.key
${SUDO} apt-key add /etc/apt/trusted.gpg.d/nginx_signing.key
${SUDO} sh -c 'echo "deb http://nginx.org/packages/debian/  $(lsb_release -sc) nginx" > /etc/apt/sources.list.d/nginx.list'
${SUDO} sh -c 'echo "deb-src http://nginx.org/packages/debian/  $(lsb_release -sc) nginx" >> /etc/apt/sources.list.d/nginx.list'
${SUDO} aptitude update