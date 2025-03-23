#!/bin/bash

PROJECT_DIR="$(dirname $0)"
PROJECT_OPTS=""
LICENSE_PATH="$PROJECT_DIR/LICENSE"
DO_FLASK=0
DO_BOOTSTRAP=0
DO_JQUERY=0
DO_NPM=0
DO_CLEAN=0
DO_WTFORMS=0
DO_DOCKER=0
DO_SQLALCHEMY=0
DO_CONSOLE=0
while (( "$#" )); do
   case "$1" in
      "flask")
         DO_FLASK=1
         ;;

      "console")
         DO_CONSOLE=1
         ;;

      "sqlalchemy")
         DO_SQLALCHEMY=1
         ;;

      "bootstrap")
         DO_BOOTSTRAP=1
         ;;

      "jquery")
         DO_JQUERY=1
         ;;

      "wtforms")
         DO_WTFORMS=1
         ;;

      "docker")
         DO_DOCKER=1
         ;;

      "gpl3")
         PROJECT_LICENSE="gpl3"
         ;;

      "lgpl3")
         PROJECT_LICENSE="lgpl3"
         ;;

      "clean")
         DO_CLEAN=1
         ;;

      *)
         #if [ -z "$PROJECT_NAME" ]; then
         #   PROJECT_NAME="$1"
         #elif [ -z "$PROJECT_DESC" ]; then
         #   PROJECT_DESC="$1"
         #else
         echo "Unsupported options: $1"
         exit 16
         #fi
         ;;
   esac
   shift
done

if [ $DO_BOOTSTRAP = 1 ]; then
   PROJECT_OPTS="$PROJECT_OPTS -D do_bootstrap=enabled"
   DO_FLASK=1
   DO_NPM=1
fi

if [ $DO_JQUERY = 1 ]; then
   PROJECT_OPTS="$PROJECT_OPTS -D do_jquery=enabled"
   DO_FLASK=1
   DO_NPM=1
fi

if [ $DO_CONSOLE = 1 ]; then
   PROJECT_OPTS="$PROJECT_OPTS -D do_console=enabled"
fi

if [ $DO_FLASK = 1 ]; then
   PROJECT_OPTS="$PROJECT_OPTS -D do_flask=enabled"
fi

if [ $DO_FLASK = 1 ] && [ $DO_WTFORMS = 1 ]; then
   PROJECT_OPTS="$PROJECT_OPTS -D do_flask_wtforms=enabled"
fi

if [ $DO_NPM = 1 ]; then
   PROJECT_OPTS="$PROJECT_OPTS -D do_npm=enabled"
fi

if [ $DO_FLASK = 1 ] && [ $DO_SQLALCHEMY = 1 ]; then
   2>&1 echo "flask and console are mutually exclusive!"
   exit 1
fi

if [ $DO_FLASK = 1 ] && [ $DO_SQLALCHEMY = 1 ]; then
   PROJECT_OPTS="$PROJECT_OPTS -D do_flask_sqlalchemy=enabled"
elif [ $DO_FLASK = 0 ] && [ $DO_SQLALCHEMY = 1 ]; then
   PROJECT_OPTS="$PROJECT_OPTS -D do_sqlalchemy=enabled"
fi

if [ $DO_DOCKER = 1 ]; then
   PROJECT_OPTS="$PROJECT_OPTS -D do_docker=enabled"
fi

if [ -z "$PROJECT_NAME" ]; then
   echo "Project name? (Spaces are OK.)"
   read PROJECT_NAME
   if [ -z "$PROJECT_NAME" ]; then
      exit 2
   fi

fi

if [ -z "$PROJECT_DESC" ]; then
   echo "Project description?"
   read PROJECT_DESC
   if [ -z "$PROJECT_DESC" ]; then
      exit 4
   fi
fi

if [ -z "$PROJECT_LICENSE" ]; then
   echo "License? (gpl3/lgpl3)"
   read PROJECT_LICENSE
   if [ -z "$PROJECT_LICENSE" ]; then
      exit 32
   fi
fi

PROJECT_UPPER=`echo "$PROJECT_NAME" | tr '[a-z]' '[A-Z]'`
PROJECT_DASHES=`echo "$PROJECT_NAME" | tr '[A-Z]' '[a-z]' | tr ' ' '-'`
PROJECT_UNDERSCORES=`echo "$PROJECT_NAME" | tr '[A-Z]' '[a-z]' | tr ' ' '_'`

TEMPLATE_FILES="
   $PROJECT_UNDERSCORES/__main__.py
   .vscode/launch.json
   setup.cfg
   MANIFEST.in
   README.md
   "

if [ $DO_FLASK = 0 ]; then
   TEMPLATE_FILES="
      $TEMPLATE_FILES
      tests/test_example.py"
fi

if [ $DO_FLASK = 1 ]; then
   TEMPLATE_FILES="
      $TEMPLATE_FILES
      $PROJECT_UNDERSCORES/__init__.py
      $PROJECT_UNDERSCORES/routes.py
      $PROJECT_UNDERSCORES/templates/.keep
      $PROJECT_UNDERSCORES/static/.keep
      $PROJECT_UNDERSCORES/templates/base.html.j2
      $PROJECT_UNDERSCORES/templates/root.html.j2
      tests/test_flask_example.py
      instance/.keep
      uwsgi.ini
      "
fi

if [ $DO_DOCKER = 1 ]; then
   TEMPLATE_FILES="
      $TEMPLATE_FILES
      Dockerfile
      .dockerignore
      "
fi

if [ $DO_SQLALCHEMY = 1 ]; then
   TEMPLATE_FILES="
      $TEMPLATE_FILES
      $PROJECT_UNDERSCORES/models.py
      "
fi

if [ $DO_NPM = 1 ]; then
   TEMPLATE_FILES="$TEMPLATE_FILES Gruntfile.js package.json"
fi

if [ "$PROJECT_LICENSE" = "gpl3" ]; then
   wget "https://www.gnu.org/licenses/gpl-3.0.txt" -O "$LICENSE_PATH"
elif [ "$PROJECT_LICENSE" = "lgpl3" ]; then
   wget "https://www.gnu.org/licenses/lgpl-3.0.txt" -O "$LICENSE_PATH"
fi

# Loop through the files list and replace occurences of "ghtmptmp" with the
# project name in the file names and contents.
if [ -n "$PROJECT_UNDERSCORES" ]; then
   rm -rvf "$PROJECT_UNDERSCORES"
   rm README.md
   cp -vR "flask_module" "$PROJECT_UNDERSCORES"
   for TEMPL_ITER in $TEMPLATE_FILES; do
      TEMPL_OUT="`sed "s/ghtmptmp/$PROJECT_UNDERSCORES/g" \
         <<< "$PROJECT_DIR/$TEMPL_ITER"`"
      m4 \
         -D ghtmptmp="$PROJECT_NAME" \
         -D GHTMPTMP="$PROJECT_UPPER" \
         -D ghtmp_dashes="$PROJECT_DASHES" \
         -D ghtmp_underscores="$PROJECT_UNDERSCORES" \
         -D ghtmp_desc="$PROJECT_DESC" \
         -D ghtmp_license="$PROJECT_LICENSE" \
         $PROJECT_OPTS \
         "$PROJECT_DIR/$TEMPL_ITER.m4" > "$PROJECT_DIR/$TEMPL_OUT"
   done
   rm -rvf "tests/"*.m4
   rm -rvf "$PROJECT_UNDERSCORES/"*.m4
   rm -rvf "$PROJECT_UNDERSCORES/templates"*.m4
   rm -rvf "flask_module"
fi

if [ $DO_CLEAN = 1 ]; then
   #rm -rf "$PROJECT_DIR/.git"
   find "$PROJECT_DIR" -name "*.m4" -exec rm {} \;
   git init "$PROJECT_DIR"
   git add $TEMPLATE_FILES .gitignore LICENSE pyproject.toml setup.py requirements.txt .vscode/settings.json
   git remote add origin "https://github.com/${GIT_USER}/${PROJECT_DASHES}"
   git commit -a -m "Initial revision based on template."
   rm "$0"
fi

if [ $DO_NPM = 1 ]; then
   echo "Use npm install and grunt to prepare local static files."
fi

