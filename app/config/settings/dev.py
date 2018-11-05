from .base import *

secrets = json.load(open(os.path.join(SECRETS_DIR, 'dev.json')))
DEBUG = True
WSGI_APPLICATION = 'config.wsgi.application'
DATABASES = secrets['DATABASES']
