dnl
divert(-1)
changequote(`^', `$')
define(^files_jquery$, ^'node_modules/jquery/dist/jquery.min.js',$)
define(^files_bootstrap$, ^'node_modules/bootstrap/dist/js/bootstrap.min.js',
                  'node_modules/bootstrap/dist/css/bootstrap.min.css',$)
changequote(^`$, ^'$)
divert(0)
dnl
module.exports = function( grunt ) {

   var env = grunt.option( 'env' ) || 'std';
   var static_dir = 'ghtmp_underscores/static/';

   if( 'docker' == env ) {
      static_dir = 'app/static/';
   }

   grunt.initConfig( {
      copy: {
         main: {
            files: [
               {expand: true, src: [
                  ifelse(do_jquery, `enabled', `files_jquery', `dnl')
                  ifelse(do_bootstrap, `enabled', `files_bootstrap', `dnl')
               ],
               dest: static_dir, flatten: true},
            ]
         }
      }
   } )

   grunt.loadNpmTasks( 'grunt-contrib-copy' );

   grunt.registerTask( 'default', ['copy'] );
};

