from .base import *

# Static
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(ROOT_DIR, '.static')
MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(ROOT_DIR, '.media')

# Database
# https://docs.djangoproject.com/en/2.0/ref/settings/#databases

# DB
secrets = json.load(open(os.path.join(SECRET_KEY_ROOT, 'dev.json')))
DATABASES = secrets['DATABASES']

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# uWSGI
WSGI_APPLICATION = 'config.wsgi.application'

