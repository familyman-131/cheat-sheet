#!/bin/bash
# To add this repository please do:

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

${SUDO}  apt-get install software-properties-common dirmngr python-pip
${SUDO}  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
${SUDO}  aptitude update
#${SUDO}  pip install ansible

