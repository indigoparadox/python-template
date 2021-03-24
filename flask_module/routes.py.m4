
from flask import \
   Blueprint, \
   render_template, \
   request, \ 
   current_app, \
   flash, \
   abort, \
   redirect, \
   url_for, \
   jsonify
import logging
ifelse(do_flask_sqlalchemy, `enabled', `from . import db', `dnl')
ifelse(do_flask_sqlalchemy, `enabled', `', `dnl')
define(`roota', `$1_root')

main_section = Blueprint( 'main', __name__ )

@main_section.route( '/' )
def roota(ghtmp_underscores)():
    return render_template( 'root.html' )
