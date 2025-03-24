[metadata]
name = ghtmp_dashes-indigoparadox
version = v0.0.0.1
description = ghtmp_desc
long_description = file: README.md
long_description_content_type = text/markdown
url = ghtmp_profile/ghtmp_dashes
protect_urls =
   Bug Tracker = ghtmp_profile/ghtmp_dashes/issues
classifiers =
   Programming Language :: Python :: 3
   Development Status :: 4 - Beta
ifelse(ghtmp_license, `gpl3', `   License :: OSI Approved :: GNU General Public License v3 (GPLv3)', `dnl')
ifelse(ghtmp_license, `lgpl3', `   License :: OSI Approved :: GNU Lesser General Public License v3 (LGPLv3)', `dnl')
   Operating System :: OS Independent

[options]
packages = find:
python_requires = >= 3.6
include_package_data = True
zip_safe = False
install_requires =
   Faker
   ldap3
   six
   paho-mqtt
ifelse(do_flask, `enabled', `   MarkupSafe', `dnl')
ifelse(do_flask, `enabled', `   Jinja2', `dnl')
ifelse(do_flask, `enabled', `   itsdangerous', `dnl')
ifelse(do_flask, `enabled', `   Werkzeug', `dnl')
ifelse(do_flask, `enabled', `   Flask', `dnl')
ifelse(do_flask, `enabled', `   Flask-Testing', `dnl')
ifelse(do_sqlalchemy, `enabled', `   sqlalchemy', `dnl')
ifelse(do_sqlalchemy, `enabled', `   pymysql', `dnl')
ifelse(do_sqlalchemy, `enabled', `   psycopg2-binary', `dnl')
ifelse(do_flask_sqlalchemy, `enabled', `   Flask-SQLAlchemy', `dnl')
ifelse(do_flask_sqlalchemy, `enabled', `   pymysql', `dnl')
ifelse(do_flask_sqlalchemy, `enabled', `   psycopg2-binary', `dnl')
ifelse(do_flask_wtforms, `enabled', `   Flask-WTF', `dnl')
ifelse(do_flask_wtforms, `enabled', `   WTForms', `dnl')
dnl If flask is not enabled, a console app is assumed.
ifelse(do_flask, `enabled', `dnl', `')
ifelse(do_flask, `enabled', `dnl', `[options.entry_points]')
ifelse(do_flask, `enabled', `dnl', `[options.console_scripts =')
ifelse(do_flask, `enabled', `dnl', `[options.   ghtmp_underscores = ghtmp_underscores.__main__:main')
