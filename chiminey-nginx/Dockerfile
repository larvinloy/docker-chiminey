FROM tutum/nginx

MAINTAINER  Ian Thomas <ianedwardthomas@gmail.com>

RUN rm /etc/nginx/sites-enabled/default
COPY sites-enabled/ /etc/nginx/sites-enabled

COPY logrotate.conf /etc/logrotate.d/chiminey
RUN chmod 644 /etc/logrotate.d/chiminey

RUN mkdir /opt/certs && chmod 744 /opt/certs
COPY certs/chiminey.key certs/chiminey.crt /opt/certs/
RUN chmod 700 /opt/certs/chiminey.key /opt/certs/chiminey.crt

RUN groupadd -r nginx && adduser --home /opt/chiminey --disabled-password --ingroup nginx --gecos '' chiminey

EXPOSE 443 80

VOLUME /var/log
VOLUME /logs
#VOLUME /opt/certs


