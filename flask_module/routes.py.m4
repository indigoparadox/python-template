
import logging

from werkzeug.utils import safe_join
from flask import \
   Blueprint, \
   render_template, \
   request, \
   current_app, \
   send_from_directory, \
   flash, \
   abort, \
   redirect, \
   url_for, \
   jsonify
ifelse(do_flask_sqlalchemy, `enabled', `', `dnl')
ifelse(do_flask_sqlalchemy, `enabled', `from . import db', `dnl')
ifelse(do_flask_sqlalchemy, `enabled', `', `dnl')
define(`roota', `$1_root')
main_section = Blueprint( 'main', __name__ )

@main_section.route( '/' )
def roota(ghtmp_underscores)():
    return render_template( 'root.html.j2' )

