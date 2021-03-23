ifelse(do_flask, `enabled', `include ghtmptmp/templates/*', `dnl')
ifelse(do_flask, `enabled', `include ghtmptmp/static/*', `dnl')
