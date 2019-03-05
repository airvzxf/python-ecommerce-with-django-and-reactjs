#!/bin/bash -xve

PROJECT=python_ecommerce
LABEL=dev


APP=database
./docker_create_container.sh -n ${PROJECT} -z ${LABEL} -a ${APP}
#docker exec -it python_ecommerce_database_dev bash

APP=phpmyadmin
./docker_create_container.sh -n ${PROJECT} -z ${LABEL} -a ${APP}


APP=web_service
./docker_create_container.sh -n ${PROJECT} -z ${LABEL} -a ${APP}


#APP=web
#./docker_create_container.sh -n ${PROJECT} -z ${LABEL} -a ${APP}


#yes | docker container prune

#docker run --name some-django-app -d my-django-app
#docker run --name python_ecommerce_web_service_dev -p 8001:8001 python_ecommerce_web_service:dev

#docker build -t python_ecommerce_web_service:dev .
#docker run -p 8000:8000 --name python_ecommerce_web_service_dev python_ecommerce_web_service:dev 

#docker run -it python_ecommerce_web_service:dev bash

#docker exec -it python_ecommerce_database_dev bash

#docker cp python_ecommerce_web_service:dev:/file/path/within/container /host/path/target


#docker run --mount type=bind,source="$(pwd)",target=/root/example/ <image> python app.py

