FROM        phusion/baseimage:0.9.16

MAINTAINER  Ian Thomas <ianedwardthomas@gmail.com>

# Install prerequisites
RUN apt-get -y update && apt-get -y install  git gunicorn nginx pwgen

RUN apt-get -y update && apt-get -y install python-pip git libxml2-dev libxslt1-dev python-dev zlib1g-dev python-wand python-virtualenv virtualenvwrapper python-psycopg2 python-yaml ipython python-anyjson python-bs4 python-billiard python-feedparser python-html5lib python-httplib2 python-pystache python-crypto python-flexmock python-dateutil supervisor gunicorn nginx pwgen



# Get chiminey source
RUN groupadd -r nginx && adduser --home /home/chiminey --disabled-password --ingroup nginx --gecos '' chiminey

USER chiminey

ENV CHIMINEY_URL https://github.com/chiminey/chiminey.git
ENV CHIMINEY_BRANCH docker

RUN cd /opt/chiminey &&  git clone -b ${CHIMINEY_BRANCH} ${CHIMINEY_URL} current

USER root

ADD settings.py /opt/chiminey/current/chiminey/settings.py
RUN chown -R chiminey.nginx /opt/chiminey/current/chiminey/settings.py

RUN mkdir -p /chiminey_settings
ADD chiminey_settings/ /chiminey_settings
RUN chown -R chiminey.nginx /chiminey_settings

ADD requirements.txt /opt/chiminey/current/requirements.txt

ADD chiminey.py /opt/chiminey/current/chiminey.py
RUN chown -R chiminey.nginx /opt/chiminey/current/chiminey.py
RUN chmod u+x /opt/chiminey/current/chiminey.py

ADD wsgi.py /opt/chiminey/current/wsgi.py
RUN chown -R chiminey.nginx /opt/chiminey/current/wsgi.py

RUN mkdir -p /var/chiminey/remotesys
RUN chown -R chiminey.nginx /var/chiminey/remotesys

RUN chown -R chiminey.nginx /opt/chiminey/current


WORKDIR /opt/chiminey/current

RUN /usr/bin/pip install -U pip
RUN pip install -r requirements.txt

RUN mkdir -p /logs
RUN chown -R chiminey:nginx /logs


RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER root

RUN mkdir -p /var/run/gunicorn/chiminey
RUN chown chiminey.nginx /var/run/gunicorn/chiminey

WORKDIR /opt/chiminey/current

# setup gunicorn
COPY gunicorn_conf.py /opt/chiminey/current/gunicorn_conf.py

EXPOSE 8000

RUN mkdir -p /logs
RUN chown -R chiminey:nginx /logs

VOLUME /logs
VOLUME /chiminey_settings
VOLUME /var/chiminey/remotesys
VOLUME /opt/chiminey/current/static

RUN mkdir /etc/service/01gunicorn
ADD gunicorn_run.sh /etc/service/01gunicorn/run
RUN chmod +x /etc/service/01gunicorn/run
CMD ["/sbin/my_init"]


