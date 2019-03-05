#!/bin/bash -e

HOST="$1"
PORT="$2"

DB_HOST="$3"
DB_PORT="$4"

sed -i "s/'host': '127.0.0.1'/'host': '"${DB_HOST}"'/g" mysql_connection_tester.py
sed -i "s/'port': '3306'/'port': '"${DB_PORT}"'/g" mysql_connection_tester.py

sed -i "s/'HOST': '127.0.0.1'/'HOST': '"${DB_HOST}"'/g" api/settings.py
sed -i "s/'PORT': '127.0.0.1'/'PORT': '"${DB_PORT}"'/g" api/settings.py

until python mysql_connection_tester.py -c '\q'; do
  sleep 3
done

echo "MySQL is up - executing command"

python manage.py migrate

echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'israel.alberto.rv@gmail.com', 'Python1234Ecommerce!')" | python manage.py shell

python manage.py runserver ${HOST}:${PORT}
