#!/bin/bash

sleep 10

if [ $DJANGO_DEBUG = "true" ]; then
    echo "[START] install dependencies"
    pip install -r requirements.txt
fi

echo "[START] apply migrations"
python manage.py migrate

echo "[START] run preinit script"
echo "exec(open('prerun.py').read())" | python manage.py shell

if [ $DJANGO_DEBUG = "true" ]; then
    echo "[START] launch app in debug mode"
    python manage.py runserver 0.0.0.0:8000
else
    echo "[START] collect static resources"
    python manage.py collectstatic --noinput
    echo "[START] launch app in release mode"
    uwsgi --chdir=. \
          --module=app.wsgi:application \
          --env DJANGO_SETTINGS_MODULE=app.settings \
          --master \
          --http=0.0.0.0:8000 \
          --processes=5 \
          --uid=1000 --gid=2000 \
          --harakiri=20 \
          --max-requests=5000 \
          --vacuum
fi