Dockerized Chiminey
===================

This is a dockerized build of the docker branch of the Chiminey system: http://chiminey.net

Usage
-----

1. Install docker and docker-compose (http://docs.docker.com/compose)

2. Clone the dockerized chiminey repository

3. Change your working directory

```
    git clone git@bitbucket.org:fnargle/docker-chiminey.git
```

3. Change your working directory

```
    cd docker-chiminey
```

4. Review the passwords in the enviornment sections in the docker-compose.yml

5.  Start the system

```
    make
    docker-compose up -d 
```


After a while, the location http://127.0.0.1 will point at the Chiminey portal.
To watch the celery workers go to: http://127.0.0.1:8080

6. To perform initial setup:

```
    docker exec -ti dockerchiminey_chiminey_1 python chiminey.py createsuperuser --user=root
    docker exec -ti dockerchiminey_chiminey_1 python chiminey.py initial
    docker exec -ti dockerchiminey_chiminey_1 python chiminey.py createuser

```

To setup the examples from the tutorials at http://chiminey.readthedocs.org

```

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



```

This project is working reasonably well as a demo, but IS NOT FOR PRODUCTION USE