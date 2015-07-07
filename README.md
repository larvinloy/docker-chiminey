
docker exec -ti dockerchiminey_chiminey_1 python chiminey.py createsuperuser
docker exec -ti dockerchiminey_chiminey_1 python chiminey.py initial
docker exec -ti dockerchiminey_chiminey_1 python chiminey.py createuser

docker exec -ti dockerchiminey_chiminey_1 python chiminey.py randnumunix



docker exec -ti dockerchiminey_chiminey_1 mkdir -p /var/chiminey/remotesys/my_payloads
docker exec -ti dockerchiminey_chiminey_1 cp -r  /opt/chiminey/current/chiminey/examples/randnumcloud/payload_randnum /var/chiminey/remotesys/my_payloads/
docker exec -ti dockerchiminey_chiminey_1 python chiminey.py randnumcloud


docker exec -ti dockerchiminey_chiminey_1  mkdir -p /var/chiminey/remotesys/my_payloads
docker exec -ti dockerchiminey_chiminey_1  cp -r  /opt/chiminey/current/chiminey/examples/randnuminternalsweep/payload_randnum /var/chiminey/remotesys/my_payloads/
docker exec -ti dockerchiminey_chiminey_1 python chiminey.py randnuminternalsweep

docker exec -ti dockerchiminey_chiminey_1  mkdir -p /var/chiminey/remotesys/my_payloads
docker exec -ti dockerchiminey_chiminey_1  cp -r  /opt/chiminey/current/chiminey/examples/randnummytardis/payload_randnum /var/chiminey/remotesys/my_payloads/
docker exec -ti dockerchiminey_chiminey_1  python chiminey.py randnummytardis

docker exec -ti dockerchiminey_chiminey_1 mkdir -p /var/chiminey/remotesys/my_payloads
docker exec -ti dockerchiminey_chiminey_1 cp -r  /opt/chiminey/current/chiminey/examples/hrmc2/payload_hrmc /var/chiminey/remotesys/my_payloads/
	docker exec -ti dockerchiminey_chiminey_1   python chiminey.py hrmc
# add input_hrmc to input directory


