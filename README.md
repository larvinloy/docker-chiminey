
docker exec -ti dockerchiminey_chiminey_1 python chiminey.py createsuperuser
docker exec -ti dockerchiminey_chiminey_1 python chiminey.py initial
docker exec -ti dockerchiminey_chiminey_1 python chiminey.py createuser

docker exec -ti dockerchiminey_chiminey_1 python chiminey.py randnumunix