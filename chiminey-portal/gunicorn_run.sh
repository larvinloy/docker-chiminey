#!/bin/bash
cd /opt/chiminey/current


if grep --quiet SECRET_KEY /chiminey_settings/docker_settings.py; then
    echo Secret key exists
else
    echo Generating new secret key
    python -c "import os; from random import choice; key_line = '%sSECRET_KEY=\"%s\"  # generated from build.sh\n' % ('from chiminey.settings_changeme import * \n\n' if not os.path.isfile('chiminey/settings.py') else '', ''.join([choice('abcdefghijklmnopqrstuvwxyz0123456789\\!@#$%^&*(-_=+)') for i in range(50)])); f=open('/chiminey_settings/docker_settings.py', 'a+'); f.write(key_line); f.close()"
fi

# need to sleep to make sure that db is ready before syndb runs
# there must be a better way of doing this...
sleep 10

# for empty databases, sync all and fake migrate, otherwise run a real migration
# python mychiminey.py syncdb --all --noinput
# python mytardis.py migrate --fake
# python mytardis.py createcachetable default_cache
# python mytardis.py createcachetable celery_lock_cache
# python mytardis.py collectstatic --noinput


export PYTHON_EGG_CACHE=/opt/chiminey/shared/egg-cache

su chiminey -c "python chiminey.py syncdb --noinput --migrate"
su chiminey -c "python chiminey.py collectstatic --noinput"
chmod +r -R /opt/chiminey/current/static


logfile=${LOG_FILE:gunicorn}


/usr/bin/gunicorn --log-level DEBUG --log-file /logs/gunicorn.log -c /opt/chiminey/current/gunicorn_conf.py -u chiminey -g nginx -b :8000 wsgi:application >> /logs/$logfile.log 2>&1

