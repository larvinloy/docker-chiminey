FROM        phusion/baseimage:0.9.16

MAINTAINER  Ian Thomas <ianedwardthomas@gmail.com>

# Install prerequisites
RUN apt-get -y update \
    && apt-get -y install python-pip git libxml2-dev \
libxslt1-dev \
python-dev \
zlib1g-dev \
python-wand \
python-virtualenv \
virtualenvwrapper \
python-psycopg2 \
python-yaml \
ipython \
python-anyjson \
python-bs4 \
python-billiard \
python-feedparser \
python-html5lib \
python-httplib2 \
python-pystache \
python-crypto \
python-flexmock \
python-dateutil \
supervisor \
gunicorn \
nginx \
pwgen \
 	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo new cache
# make chiminey user
RUN groupadd -r nginx && adduser --home /opt/chiminey --disabled-password --ingroup nginx --gecos '' chiminey

# install python prereqs
COPY requirements.txt /opt/chiminey/requirements.txt
RUN /usr/bin/pip install -U pip && pip install -r /opt/chiminey/requirements.txt

# setup blank known_hosts for ssh connectors
RUN mkdir /opt/chiminey/.ssh
RUN touch /opt/chiminey/.ssh/known_hosts
# create remotesys
RUN mkdir -p /var/chiminey/remotesys

# install chiminey
ENV CHIMINEY_URL https://github.com/chiminey/chiminey.git
ENV CHIMINEY_BRANCH docker
RUN cd /opt/chiminey &&  git clone -b ${CHIMINEY_BRANCH} ${CHIMINEY_URL} current

WORKDIR /opt/chiminey/current

COPY settings.py /opt/chiminey/current/chiminey/settings.py
RUN mkdir -p /opt/chiminey/current/static
RUN mkdir -p /opt/chiminey/current/chiminey/smartconnectorscheduler/fixtures
RUN mkdir -p /chiminey_settings
COPY chiminey_settings/ /chiminey_settings
COPY chiminey.py /opt/chiminey/current/chiminey.py
RUN chmod u+x /opt/chiminey/current/chiminey.py

#COPY initial_data.json /opt/chiminey/current/chiminey/smartconnectorscheduler/fixtures/initial_data.json
#RUN chmod u+x /opt/chiminey/current/chiminey/smartconnectorscheduler/fixtures/initial_data.json

COPY wsgi.py /opt/chiminey/current/wsgi.py
COPY gunicorn_conf.py /opt/chiminey/current/gunicorn_conf.py
COPY logrotate.conf /etc/logrotate.d/chiminey

RUN mkdir -p /var/run/celery
RUN mkdir -p /var/run/beat


RUN mkdir -p /logs /logs/beat /logs/celery

# fix all ownership
RUN chown -R chiminey.nginx /opt/chiminey/current /chiminey_settings /var/chiminey/remotesys /logs /var/run/celery /var/run/beat

#RUN mkdir -p /var/run/gunicorn/chiminey && chown chiminey.nginx /var/run/gunicorn/chiminey

EXPOSE 8000

VOLUME /logs
VOLUME /var/chiminey/remotesys
VOLUME /opt/chiminey/current/static
VOLUME /var/run/celery
VOLUME /var/run/beat


ENV CELERY_SOFT_TIME_LIMIT 155200
ENV CELERY_TIME_LIMIT 115400
ENV CELERY_LOG_LEVEL WARN
ENV GUNICORN_PORT 8000
ENV GUNICORN_LOG_LEVEL DEBUG
ENV CHIMINEY_LOG_FILE chiminey.log

COPY run/gunicorn_run.sh /
RUN chmod u+x /gunicorn_run.sh
COPY run/celery_run.sh /
RUN chmod u+x /celery_run.sh
COPY run/celerybeat_run.sh /
RUN chmod u+x /celerybeat_run.sh

COPY celery_conf.py /opt/chiminey/current/chiminey/celery_conf.py

COPY start.sh /
RUN chmod u+x /start.sh

ENTRYPOINT ["/start.sh"]
CMD ["gunicorn"]

