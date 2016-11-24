#!/bin/bash

cd /opt/chiminey/current

if grep --quiet SECRET_KEY /opt/chiminey/current/chiminey/settings.py; then
    echo Secret key exists
else
    echo Generating new secret key
    python -c "import os; from random import choice; key_line = '%sSECRET_KEY=\"%s\"  # generated from build.sh\n' % ('from chiminey.settings_changeme import * \n\n' if not os.path.isfile('chiminey/settings.py') else '', ''.join([choice('abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)') for i in range(50)])); f=open('/opt/chiminey/current/chiminey/settings.py', 'a+'); f.write(key_line); f.close()"
fi


# need to sleep to make sure that db is ready before syndb runs
# there must be a better way of doing this...
echo sleeping...
sleep 40


log_level=${CELERY_LOG_LEVEL:WARN}


function clean_up {

    echo cleaning up...
    rm -vf /var/run/beat/beat.pid

}

clean_up

trap clean_up SIGTERM

echo beating...
# run Celery worker for our project myproject with Celery configuration stored in Celeryconf
#su -m chiminey -c "python chiminey.py celerybeat --logfile=/logs/beat.log"
# su -m chiminey -c "python chiminey.py celerybeat --logfile=/logs/beat/beat.log --pidfile=/var/run/beat/beat.pid --schedule=/logs/beat/celerybeat-schedule >> /logs/beat/beat.log 2>&1"
su -m chiminey -c "python chiminey.py celerybeat --pidfile=/var/run/beat/beat.pid --schedule=/logs/beat/celerybeat-schedule -l $log_level 2>&1"

echo beat is done...
exit 0
