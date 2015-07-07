FROM tutum/nginx

MAINTAINER  Ian Thomas <ianedwardthomas@gmail.com>

RUN rm /etc/nginx/sites-enabled/default
COPY sites-enabled/ /etc/nginx/sites-enabled

RUN groupadd -r nginx && adduser --home /opt/chiminey --disabled-password --ingroup nginx --gecos '' chiminey

VOLUME /var/log


