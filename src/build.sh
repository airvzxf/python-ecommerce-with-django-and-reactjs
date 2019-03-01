#!/bin/bash -xve

PROJECT=python_ecommerce
LABEL=dev


APP=database
./docker_create_container.sh -n ${PROJECT} -z ${LABEL} -a ${APP}
#docker exec -it python_ecommerce_database_dev bash

APP=phpmyadmin
./docker_create_container.sh -n ${PROJECT} -z ${LABEL} -a ${APP}


APP=web
./docker_create_container.sh -n ${PROJECT} -z ${LABEL} -a ${APP}


APP=web_service
./docker_create_container.sh -n ${PROJECT} -z ${LABEL} -a ${APP}
