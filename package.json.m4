dnl
divert(-1)
changequote(`[', `]')
define([jquery_deps], [      "jquery": "^3.4.1"dnl])
define([bootstrap_deps], [      "bootstrap": "^5.3.3"dnl
])
changequote([`], ['])
define(`is_defined', `ifelse($1()$1, `$1()$1', ``'', ``enabled'')')
divert(0)
dnl
{
   "name": "ghtmp_underscores",
   "version": "0.0.0",
   "description": "ghtmp_desc",
   "dependencies": {
ifelse(do_jquery, `enabled', `jquery_deps', `dnl')
ifelse(is_defined(`do_jquery')is_defined(`do_bootstrap'), `enabledenabled', `,', `dnl')
ifelse(do_bootstrap, `enabled', `bootstrap_deps', `')
   },
   "devDependencies": {
      "grunt": "^0.4.5",
      "grunt-contrib-uglify": "^0.11.0",
      "grunt-contrib-cssmin": "^0.14.0",
      "grunt-contrib-concat": "^0.5.1",
      "grunt-contrib-copy": "^1.0.0"
   }
}
