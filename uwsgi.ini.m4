[uwsgi]
if-env = VIRTUAL_ENV
virtualenv = %(_)
endif =
module = ghtmp_underscores:app
uid = www-data
gid = www-data
master = true
processes = 5
socket = /tmp/uwsgi.socket
chmod-socket = 660
vacuum = true
die-on-term = true
plugins = python3
