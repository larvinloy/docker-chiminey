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
	exec /gunicorn_run.sh
}

run_celery() {
	exec /celery_run.sh
}

run_beat() {
	exec /celerybeat_run.sh
}

main "$@"
