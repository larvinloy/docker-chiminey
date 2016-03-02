#!/bin/bash

cd /opt/chiminey/current

if grep --quiet SECRET_KEY /chiminey_settings/docker_settings.py; then
    echo Secret key exists
else
    echo Generating new secret key
    python -c "import os; from random import choice; key_line = '%sSECRET_KEY=\"%s\"  # generated from build.sh\n' % ('from chiminey.settings_changeme import * \n\n' if not os.path.isfile('chiminey/settings.py') else '', ''.join([choice('abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)') for i in range(50)])); f=open('/chiminey_settings/docker_settings.py', 'a+'); f.write(key_line); f.close()"
fi

# need to sleep to make sure that db is ready before celery runs
# there must be a better way of doing this...
echo sleeping...
sleep 20


soft_time_limit=${CELERY_SOFT_TIME_LIMIT:155200}
time_limit=${CELERY_TIME_LIMIT:115400}
log_level=${CELERY_LOG_LEVEL:WARN}
host_name=`hostname`

function clean_up {

    echo cleaning up...
#    rm -vf /logs/celery/celery.log
    rm -vf /var/run/celery/w1_w1\@$host_name.pid
    rm -vf /var/run/celery/w2_w2\@$host_name.pid
    rm -vf /var/run/celery/w3_w3\@$host_name.pid
    rm -vf /var/run/celery/w4_w4\@$host_name.pid

}


trap clean_up SIGTERM

echo starting...
#su -m chiminey -c "python chiminey.py celery worker --logfile=/logs/celery.log --loglevel=DEBUG"
#su chiminey -c "python chiminey.py celeryd_multin w1 w2 w3 w4 -l $log_level --noft-time-limit=155200 --time-limit=115400 -E -Q:w1 hightasks -Q:w2,w3,w4 default --pidfile=/var/run/celery/%n.pid --logfile=/logs/celery/%n.log  >> /logs/celery/celery.log 2>&1"
# su chiminey -c "python chiminey.py celeryd_multi restart w1 w2 w3 w4 -l $log_level --verbose --soft-time-limit=155200 --time-limit=115400 -E -Q:w1 hightasks -Q:w2,w3,w4 default --pidfile=/var/run/celery/%n_%h.pid --logfile=/logs/celery/%n_%h.log  >> /logs/celery/celery.log 2>&1"
gosu chiminey -c "python chiminey.py celeryd_multi restart w1 w2 w3 w4 -l $log_level --verbose --soft-time-limit=155200 --time-limit=115400 -E -Q:w1 hightasks -Q:w2,w3,w4 default --pidfile=/var/run/celery/%n_%h.pid --logfile=/dev/stdout 2>&1"

echo "running..."
#touch /logs/celery/celery.log
tail -f /dev/null
#tail -c +0 -f /logs/celery/celery.log

echo "celery is done..."
exit 0
