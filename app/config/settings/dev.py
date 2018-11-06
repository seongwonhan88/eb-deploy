from .base import *

secrets = json.load(open(os.path.join(SECRETS_DIR, 'dev.json')))
DEBUG = True
WSGI_APPLICATION = 'config.wsgi.dev.application'
DATABASES = secrets['DATABASES']
DEFAULT_FILE_STORAGE = 'config.storages.MediaStorage'
# STATICFILES_STORAGE = 'config.storages.StaticStorage'

AWS_ACCESS_KEY_ID = secrets['AWS_ACCESS_KEY_ID']
AWS_SECRET_ACCESS_KEY = secrets['AWS_SECRET_ACCESS_KEY']
AWS_STORAGE_BUCKET_NAME= secrets['AWS_STORAGE_BUCKET_NAME']
