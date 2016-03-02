#!/bin/bash

main() {

	case "$1" in
		celery)
			run_celery
			;;
		gunicorn)
			run_gunicorn
			;;
		beat)
			run_beat
			;;
		store)
			exit 0
			;;
		*)
	    	exec "$@"
	    	;;
	esac
}

run_gunicorn() {
	#cp /logrotate_chiminey.conf /etc/logrotate.d/chiminey
	# chmod 644 /etc/logrotate.d/chiminey
	# mkdir -p /logs
	# ln -sf /dev/stdout /logs/gunicorn.log
	exec /gunicorn_run.sh

}

run_celery() {
	#cp /logrotate_celery.conf /etc/logrotate.d/celery
	# chmod 644 /etc/logrotate.d/celery
	# mkdir -p /logs/celery
	# ln -sf /dev/stdout /logs/celery/celery.log
	exec /celery_run.sh
}

run_beat() {
	#cp /logrotate_beat.conf /etc/logrotate.d/beat
	# chmod 644 /etc/logrotate.d/beat
	# mkdir -p /logs/beat
	# ln -sf /dev/stdout /logs/beat/beat.log
	exec /celerybeat_run.sh
}

main "$@"
