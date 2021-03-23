
from flask import current_app
import logging
ifelse(do_flask_sqlalchemy, `enabled', `from . import db', `dnl')
ifelse(do_flask_sqlalchemy, `enabled', `', `dnl')
define(`roota', `$1_root')

main_section = Blueprint( 'main', __name__ )

@main_section.route( '/' )
def roota(ghtmptmp)():
    return render_template( 'root.html' )
