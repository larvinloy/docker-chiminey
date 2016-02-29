#!/bin/sh


if [ -f /opt/certs/chiminey.crt  ]; then \
    echo this script will not overwrite existing certificates.  Remove the existing certs by hand and rerun this command.
    exit 0
fi

openssl req -x509 -nodes -newkey rsa:2048 -keyout /opt/certs/chiminey.key -out /opt/certs/chiminey.crt
