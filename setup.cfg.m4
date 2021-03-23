[metadata]
name = ghtmptmp-indigoparadox
version = v0.0.0.1
description = ghtmptmp_desc
long_description = file: README.md
long_description_content_type = text/markdown
url = https://github.com/indigoparadox/ghtmptmp
protect_urls =
   Bug Tracker = https://github.com/indigoparadox/ghtmptmp/issues
classifiers =
   Programming Language :: Python :: 3
   Development Status :: 4 - Beta
   License :: OSI Approved :: GNU General Public License v3 (GPLv3)
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
ifelse(do_flask_sqlalchemy, `enabled', `   Flask-SQLAlchemy', `dnl')
ifelse(do_flask_wtforms, `enabled', `   Flask-WTF', `dnl')
ifelse(do_flask_wtforms, `enabled', `   WTForms', `dnl')

[options.entry_points]
console_scripts =
   ghtmptmp = ghtmptmp.__main__:main
