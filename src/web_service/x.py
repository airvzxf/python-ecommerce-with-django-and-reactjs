#!/usr/bin/python

import mysql.connector
from mysql.connector import errorcode

config = {
  'user': 'dev_user',
  'password': '111',
  'host': '127.0.0.1',
  'port': '3306',
  'database': 'python_ecommerce',
  'raise_on_warnings': True
}

try:
  cnx = mysql.connector.connect(**config)
except mysql.connector.Error as err:
  if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
    print("Something is wrong with your user name or password")
  elif err.errno == errorcode.ER_BAD_DB_ERROR:
    print("Database does not exist")
  else:
    print(err)
  exit(-1)


cursor = cnx.cursor()

query = ("SELECT first_name, last_name FROM app_customer LIMIT 10;")

cursor.execute(query)

for (first_name, last_name) in cursor:
  print("{}, {} was hired".format(last_name, first_name))

cursor.close()
cnx.close()
