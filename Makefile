
.PHONY: certs

certs:
	@if [ ! -d chiminey-nginx/certs  ]; then \
		mkdir chiminey-nginx/certs; \
	fi
	cd chiminey-nginx/certs && openssl req -x509 -nodes -newkey rsa:2048 -keyout chiminey.key -out chiminey.crt; \
