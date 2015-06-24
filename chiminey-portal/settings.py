from chiminey.settings_changeme import *

import sys
sys.path.append('/chiminey_settings')

try:
    from docker_settings import *
except:
    print 'no Docker specific chiminey settings available'
    raise
