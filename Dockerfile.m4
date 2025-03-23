
FROM python:3.11-alpine

WORKDIR /code

# Include build deps in case requirements.txt needs them.
RUN apk add --no-cache --virtual .build-deps \
	gcc \
	libc-dev \
	linux-headers \
	python3-dev \
ifelse(do_sqlalchemy, `enabled', `	mariadb-dev \', `dnl')
ifelse(do_sqlalchemy, `enabled', `	postgresql-dev \', `dnl')
ifelse(do_flask_sqlalchemy, `enabled', `	mariadb-dev \', `dnl')
ifelse(do_flask_sqlalchemy, `enabled', `	postgresql-dev \', `dnl')
;
RUN apk add --no-cache --virtual .rt-deps \
   curl \
   python3 \
ifelse(do_npm, `enabled', `	nodejs \', `dnl')
ifelse(do_npm, `enabled', `	nodejs \', `dnl')
ifelse(do_npm, `enabled', `	npm \', `dnl')
ifelse(do_sqlalchemy, `enabled', `	mariadb-connector-c \', `dnl')
ifelse(do_sqlalchemy, `enabled', `	libpq \', `dnl')
ifelse(do_flask_sqlalchemy, `enabled', `	mariadb-connector-c \', `dnl')
ifelse(do_flask_sqlalchemy, `enabled', `	libpq \', `dnl')
;

# Copy app files.
COPY ./ghtmp_underscores /code/ghtmp_underscores
COPY ./setup.cfg /code
COPY ./setup.py /code
COPY ./README.md /code
COPY ./MANIFEST.in /code
COPY ./pyproject.toml /code
COPY ./requirements.txt /code
ifelse(do_npm, `enabled', `COPY ./package.json /code', `dnl')
ifelse(do_npm, `enabled', `COPY ./package-lock.json /code', `dnl')
ifelse(do_npm, `enabled', `COPY ./Gruntfile.js /code', `dnl')

# Setup Python dependencies.
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
ifelse(do_flask, `enabled', `RUN pip install --no-cache-dir --upgrade gunicorn', `dnl')

ifelse(do_npm, `enabled', `RUN npm install --global grunt'', `dnl')
ifelse(do_npm, `enabled', `RURUN npm install', `dnl')
ifelse(do_npm, `enabled', `RURUN grunt', `dnl')
ifelse(do_npm, `enabled', `', `dnl')
# Cleanup build env.
RUN apk del .build-deps

ifelse(do_flask, `enabled', `CMD ["gunicorn", "--bind", "0.0.0.0:80", "portato:app"]', `dnl')
ifelse(do_flask, `enabled', `', `dnl')
