#!/usr/bin/env python3

ifelse(do_flask, `enabled', `from ghtmp_underscores import app', `dnl')
ifelse(do_flask, `enabled', `', `dnl')
def main():
    ifelse(do_flask, `enabled', `', `dnl')
    ifelse(do_flask, `enabled', `app.run()', `dnl')

if '__main__' == __name__:
    main()
