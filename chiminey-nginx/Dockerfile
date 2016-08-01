FROM nginx:latest

COPY sites-enabled/chiminey /etc/nginx/conf.d/chiminey.conf

COPY kibana.htpasswd /etc/nginx/conf.d/kibana.htpasswd

RUN mkdir /opt/certs && chmod 744 /opt/certs

#RUN groupadd -r nginx && adduser --home /opt/chiminey --disabled-password --ingroup nginx --gecos '' chiminey

#EXPOSE 443 80

# forward request and error logs to docker log collector
# https://serverfault.com/questions/599103/make-a-docker-application-write-to-stdout
RUN mkdir /logs 
RUN ln -sf /dev/stdout /logs/nginx_access.log
RUN ln -sf /dev/stderr /logs/nginx_error.log


VOLUME /var/log
#VOLUME /logs
VOLUME /opt/certs
