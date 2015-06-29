#!/bin/sh

cd /opt/chiminey/current

if grep --quiet SECRET_KEY /chiminey_settings/docker_settings.py; then
    echo Secret key exists
else
    echo Generating new secret key
    python -c "import os; from random import choice; key_line = '%sSECRET_KEY=\"%s\"  # generated from build.sh\n' % ('from chiminey.settings_changeme import * \n\n' if not os.path.isfile('chiminey/settings.py') else '', ''.join([choice('abcdefghijklmnopqrstuvwxyz0123456789\\!@#$%^&*(-_=+)') for i in range(50)])); f=open('/chiminey_settings/docker_settings.py', 'a+'); f.write(key_line); f.close()"
fi


# need to sleep to make sure that db is ready before syndb runs
# there must be a better way of doing this...
sleep 30

# run Celery worker for our project myproject with Celery configuration stored in Celeryconf
su -m chiminey -c "python chiminey.py celerybeat --logfile=/logs/beat.log"
