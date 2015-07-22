FROM tutum/nginx

MAINTAINER  Ian Thomas <ianedwardthomas@gmail.com>

RUN rm /etc/nginx/sites-enabled/default
COPY sites-enabled/ /etc/nginx/sites-enabled

COPY logrotate.conf /etc/logrotate.d/chiminey
RUN chmod 644 /etc/logrotate.d/chiminey

RUN groupadd -r nginx && adduser --home /opt/chiminey --disabled-password --ingroup nginx --gecos '' chiminey

VOLUME /var/log
VOLUME /logs
VOLUME /opt/certs


