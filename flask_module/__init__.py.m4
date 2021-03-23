
import os
import logging
from flask import Flask, render_template, request
ifelse(do_flask_sqlalchemy, `enabled', `from flask_sqlalchemy import SQLAlchemy', `dnl')
ifelse(do_flask_wtforms, `enabled', `from flask_wtf import CSRFProtect', `dnl')
changequote(`[', `]')dnl
ifelse(do_flask_sqlalchemy, [enabled], [], [dnl])
ifelse(do_flask_sqlalchemy, [enabled], [# Setup the database stuff.], [dnl])
ifelse(do_flask_sqlalchemy, [enabled], [db = SQLAlchemy()], [dnl])
ifelse(do_flask_wtforms, [enabled], [dnl])
ifelse(do_flask_wtforms, [enabled], [csrf = CSRFProtect()], [dnl])
changequote([`], ['])dnl

def create_app( config=None ):

    ''' App factory function. Call this from the runner/WSGI. '''

    logging.basicConfig( level=logging.INFO )
    log_werkzeug = logging.getLogger( 'werkzeug' )
    log_werkzeug.setLevel( logging.ERROR )

    app = Flask( __name__, instance_relative_config=False,
        static_folder='static', template_folder='templates' )

changequote(`{', `}')dnl
ifelse(do_flask_sqlalchemy, {enabled}, {    app.config['SQLALCHEMY_QUERY_DEBUG'] = \}, {dnl})
ifelse(do_flask_sqlalchemy, {enabled}, {        os.getenv( 'SQLALCHEMY_QUERY_DEBUG' ) if \}, {dnl})
ifelse(do_flask_sqlalchemy, {enabled}, {        os.getenv( 'SQLALCHEMY_QUERY_DEBUG' ) else 'false'}, {dnl})
ifelse(do_flask_sqlalchemy, {enabled}, {    app.config['SQLALCHEMY_DATABASE_URI'] = \}, {dnl})
ifelse(do_flask_sqlalchemy, {enabled}, {        os.getenv( 'SQLALCHEMY_DATABASE_URI' ) if \}, {dnl})
ifelse(do_flask_sqlalchemy, {enabled}, {        os.getenv( 'SQLALCHEMY_DATABASE_URI' ) else 'sqlite:///:memory:'}, {dnl})
changequote({`}, {'})dnl
    app.config['SECRET_KEY'] = \
        os.getenv( 'SECRET_KEY' ) if \
        os.getenv( 'SECRET_KEY' ) else 'development'

    if config:
        app.config.from_object( config )
ifelse(do_flask_sqlalchemy, `enabled', `', `dnl')
ifelse(do_flask_sqlalchemy, `enabled', `    db.init_app( app )', `dnl')
ifelse(do_flask_wtforms, `enabled', `', `dnl')
ifelse(do_flask_wtforms, `enabled', `    csrf.init_app( app )', `dnl')

    with app.app_context():
        from . import routes

        app.register_blueprint( routes.main_section )

        return app

