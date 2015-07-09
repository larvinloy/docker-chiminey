
.PHONY: certs

certs:
	@if [ ! -d certs  ]; then \
		mkdir certs; \
	fi
	cd certs && openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout 118.138.241.38.key -out 118.138.241.38.crt; \
