#!/bin/bash


main() {
    cd /opt/chiminey/current


    if grep --quiet SECRET_KEY /opt/chiminey/current/chiminey/settings.py; then
        echo Secret key exists
    else
        echo Generating new secret key
        python -c "import os; from random import choice; key_line = '%sSECRET_KEY=\"%s\"  # generated from build.sh\n' % ('from chiminey.settings_changeme import * \n\n' if not os.path.isfile('chiminey/settings.py') else '', ''.join([choice('abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)') for i in range(50)])); f=open('/opt/chiminey/current/chiminey/settings.py', 'a+'); f.write(key_line); f.close()"
    fi


    # need to sleep to make sure that db is ready before celery runs
    # there must be a better way of doing this...
    echo sleeping...
    sleep 20

    log_level=${CELERY_LOG_LEVEL:WARN}
    queue=${CELERY_QUEUE}
    host_name=`hostname`

    function clean_up {

        echo cleaning up...
        # rm -vf /var/run/celery/w1_w1\@$host_name.pid
        # rm -vf /var/run/celery/w2_w2\@$host_name.pid
        # rm -vf /var/run/celery/w3_w3\@$host_name.pid
        # rm -vf /var/run/celery/w4_w4\@$host_name.pid
        rm -vf /var/run/celery/*.pid
        

    }


    clean_up

    echo starting...

    # cannot redirect to /dev/stdout because of this bug
    # http://unix.stackexchange.com/questions/38538/bash-dev-stderr-permission-denied
    # http://www.slideshare.net/raychaser/comprehensive-monitoring-for-docker

    trap clean_up SIGTERM

    #su -m chiminey -c "python chiminey.py celery worker --logfile=/logs/celery.log --loglevel=DEBUG"
    #su chiminey -c "python chiminey.py celeryd_multin w1 w2 w3 w4 -l $log_level --noft-time-limit=155200 --time-limit=115400 -E -Q:w1 hightasks -Q:w2,w3,w4 default --pidfile=/var/run/celery/%n.pid --logfile=/logs/celery/%n.log  >> /logs/celery/celery.log 2>&1"
    #su chiminey -c "python chiminey.py celeryd_multi restart w1 w2 w3 w4 -l $log_level --verbose --soft-time-limit=155200 --time-limit=115400 -E -Q:w1 hightasks -Q:w2,w3,w4 default --pidfile=/var/run/celery/%n_%h.pid --logfile=/logs/celery/celery.log  >> /logs/celery/celery.log 2>&1"
    #su chiminey -c "python chiminey.py celeryd_multi restart w1 w2 w3 w4 -l $log_level --verbose --soft-time -limit=155200 --time-limit=115400 -E -Q:w1 hightasks -Q:w2,w3,w4 default --pidfile=/var/run/celery/%n_%h.pid --logfile=/logs/celery/%n_%h.log >> /logs/celery/celery.log 2>&1"
    su chiminey -c "python chiminey.py celery worker -n w1.%h -l $log_level --soft-time-limit=155200 --time-limit=115400 -Q $queue --pidfile=/var/run/celery/%h.pid 2>&1"

    echo "waiting..."
    tail -f /dev/null

    clean_up

    echo "celery is done..."
}


main "$@"
