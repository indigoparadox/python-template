ifelse(do_flask, `enabled', `include ghtmp_underscores/templates/*', `dnl')
ifelse(do_flask, `enabled', `include ghtmp_underscores/static/*', `dnl')
