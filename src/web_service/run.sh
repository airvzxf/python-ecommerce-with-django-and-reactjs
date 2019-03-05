#!/bin/bash -xve

sed -i 's/127.0.0.1/db/g' x.py
sed -i "s/'HOST': '127.0.0.1'/'HOST': 'db'/g" api/settings.py
