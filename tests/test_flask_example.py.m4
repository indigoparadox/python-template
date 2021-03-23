
import os
import sys
import unittest
from unittest.mock import Mock

sys.path.append( os.path.dirname( __file__ ) )

from flask_testing import TestCase
from faker import Faker

import ghtmp_underscores

class TestExample( TestCase ):

changequote(`[', `]')dnl
ifelse(do_flask_sqlalchemy, [    SQLALCHEMY_DATABASE_URI = 'sqlite:///'], [dnl])
ifelse(do_flask_sqlalchemy, [    SQLALCHEMY_TRACK_MODIFICATIONS = False], [dnl])
changequote([`], ['])dnl
    TESTING = True
ifelse(do_flask_wtforms, `    WTF_CSRF_CHECK_DEFAULT = False', `dnl')
ifelse(do_flask_wtforms, `    WTF_CSRF_ENABLED = False', `dnl')
    SECRET_KEY = 'development'

    def setUp( self ):
        pass

    def tearDown( self ):
        pass

    def test_example( self ):
        pass

