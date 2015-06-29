import djcelery
from datetime import timedelta
import os

DATABASES = {
    'default': {
        'ENGINE':'django.db.backends.postgresql_psycopg2',
        'NAME': 'postgres',
        'USER': 'postgres',
        'PASSWORD': os.environ.get('DB_ENV_POSTGRES_PASSWORD', ''),
        'HOST': 'db',
        'PORT': '5432',
    },
}


CELERY_RESULT_BACKEND = 'amqp'

STAGING_PATH = "/staging"
DEFAULT_STORAGE_BASE_DIR = "/store"


BROKER_URL ='amqp://{user}:{password}@{hostname}/{vhost}/'.format(
        user='admin',
        password=os.environ.get('RABBITMQ_ENV_RABBITMQ_PASS', 'mypass'),
        hostname='rabbitmq:5672',
        vhost='')



OUR_APPS = ('chiminey.smartconnectorscheduler',
    'chiminey.simpleui')

INSTALLED_APPS = (
    'django_extensions',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.messages',
    'django.contrib.admin',
    'django.contrib.admindocs',
    #'django.contrib.markup',
    'django.contrib.staticfiles',
    'django.contrib.humanize',
    'storages',
    'djcelery',
    #'djkombu',
    'tastypie',
    'widget_tweaks',
    'httpretty',
    'mock',
    'south',
    'django_nose',
) + OUR_APPS

APIHOST = "http://172.16.231.130"
#APIHOST = "http://nginx"


BROKER_URL = 'redis://redis:6379/0'
CELERY_RESULT_BACKEND = 'redis://redis:6379/0'

djcelery.setup_loader()
