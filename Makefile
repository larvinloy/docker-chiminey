
.PHONY: certs

certs:
	@if [ ! -d certs  ]; then \
		mkdir certs; \
	fi
	cd certs && openssl req -x509 -nodes -newkey rsa:2048 -keyout chiminey.key -out chiminey.crt; \
