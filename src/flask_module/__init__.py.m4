
import logging
ifelse(do_sqlalchemy, `enabled', `from flask_sqlalchemy import SQLAlchemy', `dnl')
from flask import Flask, render_template, request
uwsgi_present = False
try:
    import uwsgi
    uwsgi_present = True
except ImportError:

    logger = logging.getLogger( 'init.uwsgi' )
    uwsgi_present = False
    logger.warning( 'uwsgi not present; connection locking unavailable.' )
changequote(`[', `]')dnl
ifelse(do_sqlalchemy, [enabled], [], [dnl])
ifelse(do_sqlalchemy, [enabled], [# Setup the database stuff.], [dnl])
ifelse(do_sqlalchemy, [enabled], [db = SQLAlchemy()], [dnl])
ifelse(do_sqlalchemy, [enabled], [uwsgiimport], [dnl])
changequote([`], ['])dnl

def create_app():

    ''' App factory function. Call this from the runner/WSGI. '''

    app = Flask( __name__, instance_relative_config=False,
        static_folder='../static', template_folder='../templates' )

    # Load our hybrid YAML config.
    with app.open_instance_resource( 'config.yml', 'r' ) as config_f:
        cfg = Config( config_f )
        app.config.from_object( cfg )

    with app.app_context():
        from . import routes

        return app

