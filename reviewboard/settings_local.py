# Site-specific configuration settings for Review Board
# Definitions of these settings can be found at
# http://docs.djangoproject.com/en/dev/ref/settings/

# Database configuration
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': 'srv/reviews.local/data/reviewboard',
    },
}

# Unique secret key. Don't share this with anybody.
SECRET_KEY = '$&99rus_i3st+w^0dfp12pr8%+o-nm8gt#c)t7wxm8*1ljdg*f'

# Cache backend settings.
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': 'None',
    },
}

# Extra site information.
SITE_ID = 1
SITE_ROOT = '/'
FORCE_SCRIPT_NAME = ''
DEBUG = True
