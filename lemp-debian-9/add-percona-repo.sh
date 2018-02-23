#!/bin/bash
# To add this repository please do:

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi
${SUDO} wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
${SUDO} dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb
${SUDO} aptitude update